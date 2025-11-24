#!/bin/sh

#SBATCH -J Fastqc
#SBATCH --mem=70000
#SBATCH -t 24:00:00
#SBATCH -c 12
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=
#SBATCH -o fastqc_out
#SBATCH -e fastqc_err


usage() {
    echo "Usage: $0 [-o OUTPUT_DIR] [-h]"
    echo ""
    echo "  -o OUTPUT_DIR    Specify the directory where FastQC results will be saved (default: fastqc_output)"
    echo "  -h               Show this help message and exit"
    exit 1
}


# Default values
OUTPUT_DIR="fastqc_output/"


# Parse command-line options
while getopts ":o:h" opt; do
    case ${opt} in
        o )
            OUTPUT_DIR=$OPTARG
            ;;
        h )
            usage
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done


module load fastqc 

mkdir -p "$OUTPUT_DIR"


# Run FastQC 
fastqc -t 12 -o "$OUTPUT_DIR" *.fastq.gz


echo "FastQC analysis complete. Results saved in: $OUTPUT_DIR"
