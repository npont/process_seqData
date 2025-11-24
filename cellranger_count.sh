#!/bin/sh

#SBATCH --job-name cellranger_count
#SBATCH --mem=70000
#SBATCH -t 24:00:00
#SBATCH --mail-type=BEGIN,END                                                                
#SBATCH --cpus-per-task=24
#SBATCH -o %x_%J.out
#SBATCH -e %x_%J.err

input_file=$(head -n ${SLURM_ARRAY_TASK_ID} $1 | tail -n 1)
sample=$(echo $input_file | sed 's/_S[0-9]\+_L001_R[0-9].*$//') #specific to my data, to remove everything after S.. i.e. just take the base

transcriptome_path="/path_to_transcriptome_directory/"
fastq_dir="path_to_fastq_directory/fastq/" #This is the output of sequana demultiplex 
output_dir="/path_to_output_directory/cellranger_count_output"

cellranger count --id=run_count_${sample} \
	--fastqs=${fastq_dir}/test_fastq/ \
	--sample=${sample} \
	--transcriptome=${transcriptome_path} \
       	--create-bam=true \
       --output-dir=${output_dir}/run_count_${sample}
