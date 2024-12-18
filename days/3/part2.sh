#!/bin/bash

if [[ $1 == "" ]]; then
    DATA="../../data/day-3"
elif [[ $1 == "test" ]]; then
    DATA="../../data/day-3-example-2"
else
    DATA=$1  
fi

rm -f /tmp/encapsulated /tmp/filtered_do /tmp/filtered_mul

echo -n "do()" > /tmp/encapsulated
cat $DATA >>/tmp/encapsulated
echo "don't()" >> /tmp/encapsulated
egrep -o "do\(\).*don't\(\)" /tmp/encapsulated >> /tmp/filtered_do
egrep -o "mul\([0-9]{1,3}\,[0-9]{1,3}\)" /tmp/filtered_do > /tmp/filtered_mul

total=0
for line in $(cat /tmp/filtered_mul); do
    IFS=',' read -r -a array <<< $(echo $line | tr -d 'mul()')
    total=$((total + array[0] * array[1]))
done
echo $total