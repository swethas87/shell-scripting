#!/bin/bash

echo "all vars used in the script are:$@"
echo "num of vars passed: $#"
echo "Scriptname: $0"
echo "Current working directory :  $PWD"
echo "Home directory of current user: $HOME"
echo "Which user: $USER"
echo "Hostname: $HOSTNAME"
echo "ProcessId of current shell script: $$"
sleep 20 &
echo "ProcessId of the last executed command: $!"