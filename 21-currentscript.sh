#!/bin/bash

VALUE="This is currentscript"

echo "Before calling otherscript: $VALUE"
echo "Process ID of current shell script: $$"

./20-otherscript.sh

echo "After calling otherscript: $VALUE"
echo "Process ID of current shell script: $$"