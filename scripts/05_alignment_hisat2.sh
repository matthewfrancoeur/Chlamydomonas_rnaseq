#!/bin/bash
# Script: 05_alignment_hisat2.sh
# Description: Perform aligment using hisat2 and trimmed reads
# Author: Matthew Francoeur
# Date: 2026

# Directories
PROCESSED=~/Desktop/Projects/Chlamydomonas_rnaseq/data/processed
REFERENCE=~/Desktop/Projects/Chlamydomonas_rnaseq/data/reference
ALIGNMENT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/alignment

#Files
INDEX=${REFERENCE}/chlamydomonas_v6_index

# Loop through all the trimmed fastq.gz files and align each one
for sample in ${PROCESSED}/*.fastq.gz; do
    # Get just the filename without path and extension
    base=$(basename ${sample} _trimmed.fastq.gz)
    echo "Processing ${base}..."
    
    #Align
    hisat2 \
    -x ${INDEX} \
    -U ${sample} \
    -S ${ALIGNMENT}/${base}.sam \
    --threads 4 \
    2> ${ALIGNMENT}/${base}_alignment_log.txt

done