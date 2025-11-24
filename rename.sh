#!/bin/bash

###################### Script to rename samples matching a certain naming pattern  #######################
#		       Here it renames sox2high to sox2highlow as an example				 #
##########################################################################################################

# First pass: Find and rename all files containing the pattern
echo "=== Renaming files ==="
find . -type f -name "*48_mb_sox2high*" | while read file; do
    dirname=$(dirname "$file")
    basename=$(basename "$file")
    newbasename=$(echo "$basename" | sed 's/48_mb_sox2high/48_mb_sox2highlow/g')
    newfile="$dirname/$newbasename"
    echo "Renaming file: $file -> $newfile"
    mv "$file" "$newfile"
done

# Second pass: Find and rename all directories matching the pattern
# Process directories in reverse depth order to avoid renaming issues
echo -e "\n=== Renaming directories ==="
find . -type d -name "*48_mb_sox2high*" | sort -r | while read dir; do
    newdir=$(echo "$dir" | sed 's/48_mb_sox2high/48_mb_sox2highlow/g')
    echo "Renaming directory: $dir -> $newdir"
    mv "$dir" "$newdir"
done

echo -e "\nRenaming complete!"
