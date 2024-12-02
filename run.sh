#!/bin/bash

# Run Each day
for d in $(ls days); do
    echo "Running $d"
    ./days/$d/run.sh
done
