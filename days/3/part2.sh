#!/bin/bash

if [[ $1 == "" ]]; then
    DATA="../../data/day-3"
elif [[ $1 == "test" ]]; then
    DATA="../../data/day-3-example-2"
else
    DATA=$1  
fi

grep -P -o "(mul\(\d+,\d+\))|(do\(\))|(don't\(\))" $DATA > /tmp/filtered

total=0
mul=1
for line in $(cat /tmp/filtered); do
    if [[ $line == "do()" ]]; then
        mul=1
    elif [[ $line == "don't()" ]]; then
        mul=0
    else
        if [[ $mul == 1 ]]; then
            IFS=',' read -r -a array <<< $(echo $line | tr -d 'mul()')
            total=$((total + array[0] * array[1]))
        fi
    fi
done

echo $total