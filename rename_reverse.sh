#!/bin/bash

################# Reverse the renaming done in rename.sh ########################################
#		  If you need to rename all files having a certain naming pattern		#
#################################################################################################

# Loop through directories matching the pattern
for dir in $(find . -type d -name "*48_ss_sox2high*" | sort); do
    # Create the new directory name
    
    newdir=$(echo "$dir" | sed 's/48_ss_sox2highlow/48_ss_sox2high/g')
    
    # Rename the directory
    echo "Renaming directory: $dir -> $newdir"
    mv "$dir" "$newdir"
    
done

echo "Renaming complete!"
