#!/bin/bash 
#The rules haven't changed much from part1 but we need to allow for a single level skip. 
#To do this I have generated every possible combination of the levels in a single report and then just part1 over that. 

if [[ $1 == "" ]]; then
    DATA="../../data/day-2"
elif [[ $1 == "test" ]]; then
    DATA="../../data/day-2-example"
else
    DATA=$1  
fi

TOTAL=0
while read -u 3 -r report ; do
    printf "" > /tmp/levels
    lenght="$(echo $report | wc -w)"
    skip_indice=0
    while [[ $skip_indice -lt $lenght ]] ; do
        levels=( $report )
        for i in ${!levels[@]}; do
            if [[ $i -ne skip_indice ]]; then
                printf "%s " "${levels[$i]}" >> /tmp/levels
            fi
        done
        printf "\n" >> /tmp/levels
        skip_indice=$((skip_indice+1))
    done
    ./part1.sh /tmp/levels 1> /dev/null
    if [[ $? -eq 0 ]]; then
        TOTAL=$((TOTAL + 1))
    fi
done 3< $DATA

 echo "Total safe reports: $TOTAL"