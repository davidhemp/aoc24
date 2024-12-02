#!/bin/bash 

TOTAL=0
while read -u 3 -r report ; do 
    SAFE=1
    SUM_ABS=0
    ABS_SUM=0
    for i in $(echo $report | awk '{ print $1-$2,$2-$3,$3-$4,$4-$5}'); do
        ABS_SUM="$((ABS_SUM + i))"
        # Switch to absolute value for checking the difference
        i="${i#-}"
        SUM_ABS="$((SUM_ABS + i))"
        # Any two adjacent levels differ by at least one and at most three.
        if [[ $i -eq 0 ]] || [[ $i -gt 3 ]]; then
            SAFE=0
        fi
    done
    # The levels are either all increasing or all decreasing. If this isn't the case then 
    # the sum of the abs will be different from the abs of the sum.
    if [[ $SUM_ABS -ne ${ABS_SUM#-} ]]; then
        SAFE=0
    fi
    if [[ $SAFE -eq 1 ]]; then
        TOTAL=$((TOTAL + 1))
    fi
done 3< ../../data/day-2-example 

 echo "Total safe reports: $TOTAL"