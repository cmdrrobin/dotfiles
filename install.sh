#!/usr/bin/env bash

echo
echo "     ____ ____ ____ ____ ____ ____ ____ ____"
echo "     ||D |||O |||T |||F |||I |||L |||E |||S ||"
echo "     ||__|||__|||__|||__|||__|||__|||__|||__||"
echo "     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|"
echo

DRY=0
SCRIPT_DIR=$(PWD); export SCRIPT_DIR

log() {
    if [[ $DRY == "1" ]]; then
        echo "[DRY_RUN]: $1"
    else
        echo "$1"
    fi
}

while [[ $# -gt 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        DRY="1"
    fi
    shift
done

# Some basic stuff
mkdir -p $HOME/code

# collect all (executable) scripts
RUNS_DIR=`find $SCRIPT_DIR/runs -mindepth 1 -maxdepth 1 -type f -perm +u+x | sort`

# Run each script
for run in $RUNS_DIR; do
    log "Running script: $run"

    [[ $DRY == "0" ]] && $run
done
