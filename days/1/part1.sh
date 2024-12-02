#!/bin/bash
sort ../../data/day-1 | awk '{ print $1 }' > /tmp/left-sorted
sort -k 2 ../../data/day-1 | awk '{ print $2 }' > /tmp/right-sorted

TOTAL_DIFF=0
while read -u 3 -r left && read -u 4 -r right ; do 
    diff="$((left - right))"
    if [[ $diff -lt 1 ]]; then 
        diff="$(( diff * -1))"
    fi
    TOTAL_DIFF="$((TOTAL_DIFF + diff))"
done 3</tmp/left-sorted 4</tmp/right-sorted 
echo $TOTAL_DIFF