#!/bin/bash
# Author: Matej Habrnal <mhabrnal@redhat.com>

LOG_FILE=test.log
LOG_SEPARATOR='----------------------------------------------------'

QUERIES_DIR="."

function createSeparator
{
    sep="$LOG_SEPARATOR\n"
    sep+="$1"
    sep+="\n"
    sep+="$LOG_SEPARATOR\n"
}

function log
{
    echo -e "$1"
    echo -e "$1" >> $LOG_FILE
}

function logWithSeparator
{
    createSeparator "$1"
    log "$sep"
}

# logResult returnCode message
function logResult
{
    if [[ $1 == 0 ]]; then
        log "PASS : $2\n"
    else
        log "FAIL : $2\n"
    fi
}

function rlJournalStart
{
    return 0
}

function rlPhaseStartSetup
{
    return 0
}

function rlPhaseStartTest
{
    logWithSeparator "$1"
}

function rlPhaseEnd
{
#logWithSeparator "rlPhaseEnd"
    return 0
}

function rlRun
{
    local command=$1
    local expected_orig=${2:-0}
    local expected=${2:-0}
    local comment
    local comment_begin
    if [[ -z "$3" ]]; then
      comment_begin="Running '$command'"
      comment="Command '$command'"
    else
      comment_begin="$3 :: actually running '$command'"
      comment="$3"
    fi

    echo "$comment_begin" "BEGIN"

    eval "$command"
    local exitcode=$?

    echo "rlRun: command = '$command'; exitcode = $exitcode; expected = $expected"
    if [[ $exitcode == $expected ]]; then
        retval=0
    else
        retval=1
    fi

    logResult $retval "$command"
    return $retval
}

function rlAssertGrep
{
    if [ ! -e "$2" ] ; then
        echo "rlAssertGrep: failed to find file $2"
        return 2
    fi
    local options=${3:--q}
    grep $options "$1" "$2"

    local exitcode=$?
    command="File '$2' should contain '$1'"
    echo $command

    logResult $exitcode "$command"
    return $exitcode
}

function rlAssertNotGrep
{
    if [ ! -e "$2" ] ; then
        echo "rlAssertGrep: failed to find file $2"
        return 2
    fi
    local options=${3:--q}
    grep $options "$1" "$2"

    local exitcode=$?
    if [ $exitcode == 0 ]; then
        exitcode=1
    else
        exitcode=0
    fi

    command="File '$2' should not contain '$1'"
    echo $command

    logResult $exitcode "$command"
    return $exitcode
}

function rlPhaseStartCleanup
{
    logWithSeparator "rlPhaseStartCleanup"
}

function rlBundleLogs
{
    local pass_count=`grep 'PASS' $LOG_FILE | wc -l`
    local fail_count=`grep 'FAIL' $LOG_FILE | wc -l`

    log $LOG_SEPARATOR
    log "TEST STATUS"
    log "PASS: $pass_count"
    log "FAIL: $fail_count"
    log "TOTAL: $(( $pass_count + $fail_count))"
    log $LOG_SEPARATOR

    if [[ $fail_count == 0 ]]; then
        test_return_value=0
    else
        test_return_value=1
    fi
}

function rlJournalPrintText
{
    return 0
}

function rlJournalEnd
{
    t_CheckExitStatus $test_return_value
}
