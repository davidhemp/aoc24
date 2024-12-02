#!/bin/bash
sort ../../data/day-1 | awk '{ print $1 }' > /tmp/left-sorted
sort -k 2 ../../data/day-1 | awk '{ print $2 }' > /tmp/right-sorted

TOTAL=0
for l in $(cat /tmp/left-sorted); do 
    n=$(grep -c $l /tmp/right-sorted)
    TOTAL=$((TOTAL + l * n))
done
echo $TOTAL