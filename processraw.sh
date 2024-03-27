#!/bin/sh
while read -r line; do
    echo "Processing: $line"
    dir=${line//[$'\r']}
    rm -rf ./$dir
    mkdir $dir
    read -r line
    lcount=${line//[$'\r']}
    while [ $lcount -ne 0 ]; do
        read -r line
        echo $line >> $dir/rrfpins.txt
        lcount=$(($lcount-1))
    done
    while read -r line; do
        line=${line//[$'\r\n']}
        if [ "$line" = "XXENDXX" ]; then
            break
        fi
        echo $line >> $dir/rrfboot.txt
    done
done < "$1"