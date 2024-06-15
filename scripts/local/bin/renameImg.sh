#!/bin/bash

# Directory containing the images
directory=$1

# New name base
new_name_base=$2

# Counter
count=0

# Iterate over .jpg files
for file in "$directory"/*.jpg; do
    mv "$file" "$directory/$new_name_base"_"$count".jpg
    echo "Renamed '$file' to '$new_name_base"_"$count'.jpg"
    ((count++))
done

