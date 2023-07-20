#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - libbpf tools"

if [[ "$centos_ver" -le 8 ]]; then
  t_Log "Running $0 in EL8 or less -> SKIP"
  exit 0
fi

version_tests=(
"bpf-bindsnoop -V"
"bpf-biolatency -V"
"bpf-biopattern -V"
"bpf-biosnoop -V"
"bpf-biostacks -V"
"bpf-biotop -V"
"bpf-bitesize -V"
"bpf-btrfsdist -V"
"bpf-btrfsslower -V"
"bpf-cachestat -V"
"bpf-capable -V"
"bpf-cpudist -V"
"bpf-cpufreq -V"
"bpf-drsnoop -V"
"bpf-execsnoop -V"
"bpf-exitsnoop -V"
"bpf-ext4dist -V"
"bpf-ext4slower -V"
"bpf-filelife -V"
"bpf-filetop -V"
"bpf-fsdist -V"
"bpf-fsslower -V"
"bpf-funclatency -V"
"bpf-gethostlatency -V"
"bpf-hardirqs -V"
"bpf-javagc -V"
"bpf-killsnoop -V"
"bpf-klockstat -V"
"bpf-ksnoop -V"
"bpf-llcstat -V"
"bpf-mdflush -V"
"bpf-mountsnoop -V"
"bpf-nfsdist -V"
"bpf-nfsslower -V"
"bpf-numamove -V"
"bpf-offcputime -V"
"bpf-oomkill -V"
"bpf-opensnoop -V"
"bpf-readahead -V"
"bpf-runqlat -V"
"bpf-runqlen -V"
"bpf-runqslower -V"
"bpf-sigsnoop -V"
"bpf-slabratetop -V"
"bpf-softirqs -V"
"bpf-solisten -V"
"bpf-statsnoop -V"
"bpf-syscount -V"
"bpf-tcpconnect -V"
"bpf-tcpconnlat -V"
"bpf-tcplife -V"
"bpf-tcprtt -V"
"bpf-tcpstates -V"
"bpf-tcpsynbl -V"
"bpf-tcptop -V"
"bpf-tcptracer -V"
"bpf-vfsstat -V"
"bpf-wakeuptime -V"
"bpf-xfsdist -V"
"bpf-xfsslower -V"
)

tracing_tests=(
"bpf-biolatency 1 1"
"bpf-biopattern 1 1"
# IGNORE, CURRENTLY BROKEN: "bpf-biosnoop 1", see https://bugzilla.redhat.com/show_bug.cgi?id=2219196
"bpf-biostacks 1"
"bpf-biotop 1 1"
"bpf-bitesize 1 1"
"bpf-cachestat 1 1"
"bpf-cpudist 1 1"
# IGNORE, CURRENTLY BROKEN: "bpf-cpufreq -d 1", see https://github.com/iovisor/bcc/issues/4651
"bpf-drsnoop -d 1"
"bpf-filetop 1 1"
"bpf-fsdist -t $(df -T $(pwd) | tail -1 | awk '{print $2}') 1 1"
"bpf-fsslower -t $(df -T $(pwd) | tail -1 | awk '{print $2}') -d 1"
"bpf-funclatency -i 1 -d 1 vfs_read"
"bpf-hardirqs 1 1"
"bpf-klockstat -d 1"
"bpf-llcstat 1"
"bpf-offcputime 1"
# IGNORE, CURRENTLY BROKEN: "bpf-opensnoop -d 1", see https://bugzilla.redhat.com/show_bug.cgi?id=2219192
# IGNORE, CURRENTLY BROKEN: "bpf-readahead -d 1", see https://bugzilla.redhat.com/show_bug.cgi?id=2219193
"bpf-runqlat 1 1"
"bpf-runqlen 1 1"
"bpf-slabratetop 1 1"
"bpf-softirqs 1 1"
"bpf-syscount -d 1 -T 1"
"bpf-tcprtt -d 1 -i 1"
"bpf-tcpsynbl 1 1"
"bpf-tcptop 1 1"
"bpf-vfsstat 1 1"
"bpf-wakeuptime 1"
)

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

one_failed=0

for cmd in "${version_tests[@]}"; do
  t_Log "Running $0 - libbpf-tools test: ${cmd}"
  if ! eval "${cmd}" > ${output_file} 2>&1; then
    t_Log "FAIL: $0: libbpf-tools test: ${cmd}"
    cat ${output_file}
    one_failed=1
  else
    t_Log "PASS: $0: libbpf-tools test: ${cmd}"
  fi
done

for cmd in "${tracing_tests[@]}"; do
  t_Log "Running $0 - libbpf-tools test: ${cmd}"
  if ! eval "${cmd}" > ${output_file} 2>&1; then
    t_Log "FAIL: $0: libbpf-tools test: ${cmd}"
    cat ${output_file}
    one_failed=1
  else
    t_Log "PASS: $0: libbpf-tools test: ${cmd}"
  fi
done

if [[ "${one_failed}" == "1" ]]; then
  t_Log "FAIL: $0: At least one test failed, see logs above"
fi

exit ${one_failed}
