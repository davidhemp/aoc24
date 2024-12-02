#!/bin/bash 

TOTAL=0
while read -u 3 -r report ; do 
    SAFE=1
    DIRECTION=0
    START=1
    n=0
    nn=0
    for level in $report; do
        # Skip the first level
        if [[ $START -eq 1 ]]; then
            n=$level
            START=0
            continue
        fi
        
        # Increment the levels
        nn="$n"
        n="$level"
        # Calculate the difference between two adjacent levels
        DIFF=$(( nn - n ))

        # Check direction or set if it is not set yet
        if [[ $DIRECTION -eq 0 ]]; then
            if [[ DIFF -lt 0 ]]; then
                DIRECTION=-1
            elif [[ DIFF -gt 0 ]]; then
                DIRECTION=1
            fi
        elif [[ $DIRECTION -eq -1 ]] && [[ DIFF -gt 0 ]]; then
            ERR="DIRECTION CHANGED"
            SAFE=0
        elif [[ $DIRECTION -eq 1 ]] && [[ DIFF -lt 0 ]]; then
            ERR="DIRECTION CHANGED"
            SAFE=0
        fi

        # Switch to absolute value for checking the difference
        DIFF="${DIFF#-}"
        # Any two adjacent levels differ by at least one and at most three.
        if [[ $DIFF -eq 0 ]] || [[ $DIFF -gt 3 ]]; then
            ERR="Out of range ${DIFF}"
            SAFE=0
        fi
    done
    if [[ $SAFE -eq 1 ]]; then
        TOTAL=$((TOTAL + 1))
        echo "SAFE"
    else
        echo "UNSAFE: $ERR $report"
    fi
done 3< ../../data/day-2-example

 echo "Total safe reports: $TOTAL"