#!/bin/bash
MOVIES=("RRR" "DJTillu" "murari")

#list always starts with 0
#size of above array is 3
#index are 0,1,2
echo "First movie is : ${MOVIES[0]}"
echo "All movies are ${MOVIES[@]}"