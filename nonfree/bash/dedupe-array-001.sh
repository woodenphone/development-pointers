#!/usr/bin/env bash
## dedupe_array.001.sh
## ======================================== ##
## Source: https://stackoverflow.com/questions/54797475/how-to-remove-duplicate-elements-in-an-existing-array-in-bash
## RETRIEVED: 2025-01-18
## ======================================== ##
newArr=()
while IFS= read -r -d '' x
do
    newArr+=("$x")
done < <(printf "%s\0" "${arr[@]}" | sort -uz)
