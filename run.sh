#!/bin/bash

# Run Each day
for d in $(ls days); do
    echo "Running $d"
    pushd ./days/$d
    ./run.sh
    popd
done
