#!/bin/bash

if [[ $1 == "" ]]; then
    DATA="../../data/day-3"
elif [[ $1 == "test" ]]; then
    DATA="../../data/day-3-example-1"
else
    DATA=$1  
fi

grep -P -o "(mul\(\d{1,3},\d{1,3}\))" $DATA > /tmp/filtered_mul

total=0
for line in $(cat /tmp/filtered_mul); do
    IFS=',' read -r -a array <<< $(echo $line | tr -d 'mul()')
    total=$((total + array[0] * array[1]))
done
echo $total