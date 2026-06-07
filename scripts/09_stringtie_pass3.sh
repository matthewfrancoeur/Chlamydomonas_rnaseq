#!/bin/bash
# Script: 09_stringtie_pass3.sh
# Description: Transcript quantification against merged GTF
# Author: Matthew Francoeur
# Date: 2026

# Directories
MERGED=~/Desktop/Projects/Chlamydomonas_rnaseq/results/stringtie/merged
ALIGNMENT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/alignment
OUTPUT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/stringtie/pass3

#Files
merged_file=${MERGED}/merged.gtf

# Loop through all the bam files and run stringtie
for BAM in ${ALIGNMENT}/*.bam; do
    # Get just the filename without path and extension
    base=$(basename ${BAM} .bam)
    echo "Processing ${base}..."
    
    #Run stringtie
    stringtie ${BAM} \
    -G ${merged_file} \
    -o ${OUTPUT}/${base}.gtf \
    -e \
    -p 4

done