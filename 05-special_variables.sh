#!/bin/bash

echo "All variables: $@"
echo "Numver of variables passed: $#"
echo "Script name: $0"
echo "print working directory: $PWD"
echo "print home directory: $HOME"
echo "whcih user: $USER"
echo "Hostname: $HOSTNAME"
echo "Process ID: $$"
sleep 60 &
echo "Process Id of last background commands: $!"