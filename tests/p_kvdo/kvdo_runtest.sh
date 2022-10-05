#!/bin/bash
# vim: dict+=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   runtest.sh of VDO smoke test
#   Description: Check that VDO is able to read/write data and start/stop
#   Author: Andy Walsh <awalsh@redhat.com>
#   Vendored into sig-core-t_functional by Adam Saleh <asaleh@redhat.com>
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   Copyright (c) 2018 Red Hat, Inc.
#
#   This program is free software: you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation, either version 2 of
#   the License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#   PURPOSE.  See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see http://www.gnu.org/licenses/.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# only run on centos 8 for now
if [ "$centos_ver" -ne "8" ]; then
  t_Log "non c8 => SKIPPING"
  exit 0
fi

# Include Beaker environment
. /usr/share/beakerlib/beakerlib.sh || exit 1

arch=$(uname -m)

function insertModuleWithDMesgOutput() {
        moduleName=$1

        modulePath=$(rpm -ql kmod-kvdo | grep "${1}.ko$")

        exitVal=0
        rlRun "dmesg -c > /dev/null"
        rlRun "insmod ${modulePath}" || exitVal=255
        rlRun "dmesg"

        if [ ${exitVal} -ne 0 ]; then
          rlDie "Exiting with failure due to module/kernel incompatibility"
        fi
}

# Check whether we received URLs (via environment variables), and if not, let
# the system just use the enabled repositories to install the packages.
if [ -z ${kvdo_version} ] || [ -z ${kvdo_release} ]; then
        kvdo_pkg=kmod-kvdo
else
        kvdo_pkg=${brew_base_url}/kmod-kvdo/${kvdo_version}/${kvdo_release}/${arch}/kmod-kvdo-${kvdo_version}-${kvdo_release}.${arch}.rpm
fi

if [ -z ${vdo_version} ] || [ -z ${vdo_release} ]; then
        vdo_pkg=vdo
else
        vdo_pkg=${brew_base_url}/vdo/${vdo_version}/${vdo_release}/${arch}/vdo-${vdo_version}-${vdo_release}.${arch}.rpm
fi

rlJournalStart

rlPhaseStartSetup "Create backing device"
        rlRun "TmpDir=\$(mktemp -d)" 0 "Creating tmp directory"
        rlRun "pushd $TmpDir"
        rlRun "df ."

        # If we end up with less than 10G of available space, then we can't
        # create a VDO volume sufficient for testing.  We should bail out as a
        # result.
        loopbackSize=$(($(df --sync --output=avail / | tail -1) * 1024 - 1024*1024*1024))
        if [ ${loopbackSize} -lt $((1024*1024*1024*10)) ]; then
          rlDie "Not enough space to create loopback device."
        fi
        rlRun "truncate -s ${loopbackSize} $TmpDir/loop0.bin" 0 "Laying out loopfile backing"
        rlRun "losetup /dev/loop0 $TmpDir/loop0.bin" 0 "Creating loopdevice"
        rlRun "mkdir -p /mnt/testmount" 0 "Creating test mountpoint dir"
rlPhaseEnd

rlPhaseStartSetup "Install software"
        if ! rlCheckRpm kmod-kvdo
        then
                rlRun "yum install -y ${kvdo_pkg}" 0 "Installing kmod-kvdo" || rlDie "Unable to install 'kmod-kvdo' package"
        	rlAssertRpm kmod-kvdo
        fi
        if ! rlCheckRpm vdo
        then
                rlRun "yum install -y ${vdo_pkg}" 0 "Installing vdo" || rlDie "Unable to install 'vdo' package"
        	rlAssertRpm vdo
        fi
rlPhaseEnd

rlPhaseStartTest "Gather Relevant Info"
        # Gather some system information for debug purposes
        rlRun "uname -a"
        rlRun "find /lib/modules -name kvdo.ko"
        rlRun "modinfo uds" || insertModuleWithDMesgOutput uds
        rlRun "modinfo kvdo" || insertModuleWithDMesgOutput kvdo
rlPhaseEnd

rlPhaseStartTest "Generate Test Data"
        # Write some data, check statistics
        rlRun "dd if=/dev/urandom of=${TmpDir}/urandom_fill_file bs=1M count=100"
        rlRun "ls -lh ${TmpDir}/urandom_fill_file"
rlPhaseEnd

for partition_type in "raw" "lvm" "part"
do
        case $partition_type in
                "raw"*)
                        backing_device=/dev/loop0
                        ;;
                "lvm"*)
                        rlPhaseStartTest "Create LVM backing device"
                                rlRun "pvcreate /dev/loop0" 0 "Creating PV"
                                rlRun "vgcreate vdo_base /dev/loop0" 0 "Creating VG"
                                rlRun "lvcreate -n vdo_base -l100%FREE vdo_base" 0 "Creating LV"
                        rlPhaseEnd
                        backing_device=/dev/vdo_base/vdo_base
                        ;;
                "part"*)
                        rlPhaseStartTest "Create partitioned backing device"
                                rlRun "parted -s /dev/loop0 mklabel msdos" 0 "Creating label"
                                rlRun 'parted -s /dev/loop0 mkpart primary "" 1M -- -1M' 0 "Creating partition"
                        rlPhaseEnd
                        backing_device=/dev/loop0p1
                        ;;
                *)
                        ;;
        esac

        rlPhaseStartTest "Smoke Test"
                # Create the VDO volume and get the initial statistics
                rlRun "vdo create --name=vdo1 --device=${backing_device} --verbose" 0 "Creating VDO volume vdo1"
                rlRun "vdostats vdo1"

                # Create a filesystem and mount the device, check statistics
                rlRun "mkfs.xfs -K /dev/mapper/vdo1" 0 "Making xfs filesystem on VDO volume"
                rlRun "mount -o discard /dev/mapper/vdo1 /mnt/testmount" 0 "Mounting xfs filesystem on VDO volume"
                rlRun "df --sync /mnt/testmount"
                rlRun "vdostats vdo1"

                # Copy the test data onto VDO volume 4 times to get some deduplication
                for i in {1..4}
                do
                  rlRun "cp ${TmpDir}/urandom_fill_file /mnt/testmount/test_file-${i}"
                done
                rlRun "df --sync /mnt/testmount"
                rlRun "vdostats vdo1"

                # Verify the data
                for i in {1..4}
                do
                        rlRun "cmp ${TmpDir}/urandom_fill_file /mnt/testmount/test_file-${i}"
                done

                # Unmount and stop the volume, check statistics
                rlRun "umount /mnt/testmount" 0 "Unmounting testmount"
                rlRun "vdostats vdo1"
                rlRun "vdo stop --name=vdo1 --verbose" 0 "Stopping VDO volume vdo1"

                # Start the VDO volume, mount it, check statistics, verify data.
                rlRun "vdo start --name=vdo1 --verbose" 0 "Starting VDO volume vdo1"
                rlRun "mount -o discard /dev/mapper/vdo1 /mnt/testmount" 0 "Mounting xfs filesystem on VDO volume"

                rlRun "df --sync /mnt/testmount"
                rlRun "vdostats vdo1"

                # Verify the data
                for i in {1..4}
                do
                        rlRun "cmp ${TmpDir}/urandom_fill_file /mnt/testmount/test_file-${i}"
                done
        rlPhaseEnd

        rlPhaseStartCleanup
                rlRun "umount /mnt/testmount" 0 "Unmounting testmount"
                rlRun "vdo remove --name=vdo1 --verbose" 0 "Removing VDO volume vdo1"
                case $partition_type in
                        "lvm"*)
                                rlPhaseStartCleanup
                                        rlRun "lvremove -ff ${backing_device}" 0 "Removing LV"
                                        rlRun "vgremove vdo_base" 0 "Removing VG"
                                        rlRun "pvremove /dev/loop0" 0 "Removing PV"
                                rlPhaseEnd
                                ;;
                        "part"*)
                                rlPhaseStartCleanup
                                    rlRun "parted -s /dev/loop0 rm 1" 0 "Removing partition"
                                rlPhaseEnd
                                ;;
                        *)
                                ;;
                esac

                rlRun "dd if=/dev/zero of=/dev/loop0 bs=1M count=10 oflag=direct" 0 "Wiping Block Device"

        rlPhaseEnd
done

rlPhaseStartCleanup
        rlRun "losetup -d /dev/loop0" 0 "Deleting loopdevice"
        rlRun "rm -f $TmpDir/loop0.bin" 0 "Removing loopfile backing"
        rlRun "popd"
        rlRun "rm -r $TmpDir" 0 "Removing tmp directory"
rlPhaseEnd

rlJournalPrintText
rlJournalEnd
