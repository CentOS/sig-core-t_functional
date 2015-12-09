#!/bin/bash
# Author: Matej Habrnal <mhabrnal@redhat.com>

TEST_DIR="tests/p_abrt-cli"
source $TEST_DIR/_lib.sh
source $TEST_DIR/_CentOSBugTracker.conf

t_Log "Running $0 - test reporting to CentOS Bug Tracker"

# testing if bugs-test.centos.org is reachable for that test ..
curl --silent -I http://bugs-test.centos.org/my_view_page.php|grep -q "HTTP/1.1 200 OK"
if [ "$?" -ne "0" ];then
  t_Log "Mantis test instance doesn't seem reachable ... SKIP"
  exit 0
fi

# run only on centos 7 or greater
[[ $centos_ver -lt 7 ]] && exit 0


conf_file="/etc/libreport/events/report_CentOSBugTracker.conf"
abrt_action_conf_file="/etc/abrt/abrt-action-save-package-data.conf"

cat > /etc/libreport/events.d/test_event.conf << _EOF_
EVENT=notify
        touch /tmp/abrt-done
EVENT=notify-dup
        touch /tmp/abrt-done
_EOF_

function wait_for_hooks() {
    echo "Waiting for all hooks to end"
    local c=0
    while [ ! -f "/tmp/abrt-done" ]; do
        sleep 0.1
        let c=$c+1
        if [ $c -gt 3000 ]; then
            echo "Timeout"
            break
        fi
    done
    t=$( echo "scale=2; $c/10" | bc )
    echo "Hooks ended in $t seconds"
}

function get_crash_path()
{
    crash_PATH="$(abrt-cli list 2> /dev/null | grep Directory | awk '{ print $2 }' | tail -n1)"

    if [ ! -d "$crash_PATH" ]; then
        echo "No crash dir generated, this shouldn't happen"
        exit 1
    fi
    echo "crash dir path: $crash_PATH"
}

function check_prior_crashes()
{
    abrt-cli list 2> /dev/null >cli-list.log
    count_of_crashes=`wc -l < cli-list.log`
    rm -f cli-list.log

    if [[ $count_of_crashes != 0 ]]; then
        echo "There are some existing crashes"
        exit 1
    fi
}

function generate_crash()
{
    echo "Generate crash"
    sleep 1000 &
    kill -SIGSEGV $!
    sleep 3
}

function set_configuration()
{
    conf_file_original=`cat $conf_file`
    abrt_action_conf_file_original=`cat $abrt_action_conf_file`

    cat > $conf_file << EOF
Mantisbt_MantisbtURL = $URL
Mantisbt_Login = $LOGIN
Mantisbt_Password = $PASSWORD
Mantisbt_SSLVerify = $SSLVERIFY
EOF

    cat > $abrt_action_conf_file << EOF
OpenGPGCheck = no
BlackList = nspluginwrapper, valgrind, strace, mono-core
ProcessUnpackaged = no
BlackListedPaths = /usr/share/doc/*, */example*, /usr/bin/nspluginviewer, /usr/lib/xulrunner-*/plugin-container
Interpreters = python2, python2.7, python, python3, python3.3, perl, perl5.16.2
EOF
}

function restore_configuration()
{
    echo $conf_file_original > $conf_file
    echo $abrt_action_conf_file_original > $abrt_action_conf_file
}

rlJournalStart
    rlPhaseStartSetup
        LANG=""
        export LANG

        check_prior_crashes

        systemctl start abrtd
        systemctl start abrt-ccpp

        orig_editor=`echo $EDITOR`
        export EDITOR=cat

        TmpDir=$(mktemp -d)
        cp $TEST_DIR/_expect $TmpDir/expect
        cp $TEST_DIR/_expect_report $TmpDir/expect_report

        pushd $TmpDir
    rlPhaseEnd

    rlPhaseStartTest "testing workflow"
        generate_crash
        get_crash_path
        wait_for_hooks

        rlRun "./expect $crash_PATH &> abrt-cli.log" 0 "run abrt-cli report CRASH_DIR"

        rlAssertGrep "CentOS Bug Tracker User name:" abrt-cli.log
        rlAssertGrep "CentOS Bug Tracker Password:" abrt-cli.log

        mv -fv abrt-cli.log p_abrt-cli-testing_workflow.log
    rlPhaseEnd

    rlPhaseStartTest "create a new issue"
        #set url, username and password
        set_configuration

        echo "I am comment. abrt-cli testing" > $crash_PATH/comment
        hash=`date +%s`
        echo $hash > $crash_PATH/duphash
        rlRun "./expect_report $crash_PATH &> abrt-cli.log" 0 "run report-cli -e report_CentOSBugTracker CRASH_DIR"

        rlAssertGrep "Checking for duplicates" abrt-cli.log
        rlAssertGrep "Creating a new issue" abrt-cli.log
        rlAssertGrep "Adding External URL to issue" abrt-cli.log

        #get issue id
        issue_id=`grep "Status: new " abrt-cli.log | grep -e [0-9]* -o`
        echo "Created issue $issue_id"

        mv -fv abrt-cli.log p_abrt-cli-created_new_issue.log
    rlPhaseEnd

    rlPhaseStartTest "duplicate issue"

        rlRun "./expect_report $crash_PATH &> abrt-cli.log" 0 "run report-cli -e report_CentOSBugTracker CRASH_DIR"

        rlAssertGrep "Checking for duplicates" abrt-cli.log
        rlAssertGrep "Bug is already reported:" abrt-cli.log
        rlAssertGrep "Adding new comment to issue" abrt-cli.log

        mv -fv abrt-cli.log p_abrt-cli-duplicate_issue.log
    rlPhaseEnd

    rlPhaseStartTest "check created issue"

        data="<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:ns3=\"http://futureware.biz/mantisconnect\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:ns0=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:ns1=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns2=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Header/><ns1:Body><ns3:mc_issue_get><username xsi:type=\"ns2:string\">$LOGIN</username><password xsi:type=\"ns2:string\">$PASSWORD</password><issue_id xsi:type=\"ns2:integer\">$issue_id</issue_id></ns3:mc_issue_get></ns1:Body></SOAP-ENV:Envelope>"

        curl --data "$data" -H "Content-Type:text/xml" $URL"/api/soap/mantisconnect.php" > curl.log
        rlAssertGrep "<summary xsi:type=\"xsd:string\">\[abrt\]" curl.log
        rlAssertGrep "I am comment. abrt-cli testing" curl.log
        rlAssertGrep "AttachmentData\[[0-9]*\]" curl.log -e
        rlAssertNotGrep "AttachmentData\[0\]" curl.log
        rlAssertGrep "CustomFieldValueForIssueData\[[0-9]*\]" curl.log -e
        rlAssertNotGrep "CustomFieldValueForIssueData\[0\]" curl.log
        rlAssertGrep "IssueNoteData\[1\]\"" curl.log

        mv -fv curl.log p_abrt-cli-check_created_issue.log
    rlPhaseEnd

    rlPhaseStartCleanup
        restore_configuration
        rlRun "abrt-cli remove $crash_PATH" 0
        rlBundleLogs #create test statistic
        # copy all log to /tmp/
        cp -v p_abrt-cli*.log /tmp/
        popd # TmpDir
        rm -rf $TmpDir
        export EDITOR=$orig_editor
        rm -f "/tmp/abrt-done"
    rlPhaseEnd
    rlJournalPrintText
rlJournalEnd
