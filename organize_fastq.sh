#!/bin/bash

################## Script used to organize the fastq files into subdirectories ##################
#	Fastq files (=after demultiplexing) are all shuffled in one same directory		#
#	We want to have a folder with as many subdirectories as samples sequenced		#
#	and in which each subdirectory contains a sample_R1.fastq.gz and its mate		#
#	namely sample_R2.fastq.gz								#
#	Goal: ease downstream analysis by having files organized in a clean manner		#
#################################################################################################



FASTQ_DIR="/path_to_fastq_files/" # Fastq files are the output of demultiplexing (I use sequana demultiplex)
TARGET_DIR="/path_to_fastq_target_dir/" # Example: "/project/data/raw_data/zebrafish/RNA/name_experiment/"  

mkdir -p "$TARGET_DIR"

cd "$FASTQ_DIR"

# Process each R1 file and move both R1 and R2 to appropriate subdirectory
for r1_file in *_R1_001.fastq.gz; do
    # Extract the sample name (everything before _R1_001.fastq.gz)
    sample_name=${r1_file%_R1_001.fastq.gz}
    
    # Create subdirectory for this sample
    mkdir -p "$TARGET_DIR/$sample_name"
    
    # Move R1 file
    cp "$r1_file" "$TARGET_DIR/$sample_name/"
    
    # Find and move corresponding R2 file
    r2_file="${sample_name}_R2_001.fastq.gz"
    if [ -f "$r2_file" ]; then
        cp "$r2_file" "$TARGET_DIR/$sample_name/"
        echo "Moved $r1_file and $r2_file to $TARGET_DIR/$sample_name/"
    else
        echo "Warning: Could not find matching R2 file for $r1_file"
    fi
done

echo "File organization complete!"
