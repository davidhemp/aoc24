#!/bin/bash 

TOTAL=0
while read -u 3 -r report ; do 
    SAFE=1
    DIRECTION=0
    for i in $(echo $report | awk '{ print $1-$2,$2-$3,$3-$4,$4-$5}'); do
        # Set the direction if it is not set
        if [[ $DIRECTION -eq 0 ]]; then
            if [[ $i -lt 0 ]]; then
                DIRECTION=-1
            elif [[ $i -gt 0 ]]; then
                DIRECTION=1
            fi
        elif [[ $DIRECTION -eq -1 ]] && [[ $i -gt 0 ]]; then
            SAFE=0
        elif [[ $DIRECTION -eq 1 ]] && [[ $i -lt 0 ]]; then
            SAFE=0
        fi

        # Switch to absolute value for checking the difference
        i="${i#-}"
        # Any two adjacent levels differ by at least one and at most three.
        if [[ $i -eq 0 ]] || [[ $i -gt 3 ]]; then
            SAFE=0
        fi
    done
    if [[ $SAFE -eq 1 ]]; then
        TOTAL=$((TOTAL + 1))
        echo "SAFE"
    else
        echo "UNSAFE"
    fi
done 3< ../../data/day-2-example

 echo "Total safe reports: $TOTAL"