#!/bin/bash
# Script: 06_sam_to_bam.sh
# Description: Convert sam files produced by hisat2 to sorted bam files
# Author: Matthew Francoeur
# Date: 2026

# Directories
ALIGNMENT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/alignment

# Loop through all the sam files convert each one to bam, and make an index
for SAM in ${ALIGNMENT}/*.sam; do
    # Get just the filename without path and extension
    base=$(basename ${SAM} .sam)
    echo "Processing ${base}..."
    
    #Convert to bam
    samtools sort -o ${ALIGNMENT}/${base}.bam ${SAM}

    #Create indexed bam
    samtools index ${ALIGNMENT}/${base}.bam

done
