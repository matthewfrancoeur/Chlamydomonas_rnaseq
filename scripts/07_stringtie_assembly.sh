#!/bin/bash
# Script: 07_stringtie_assembly.sh
# Description: Transcript quantification against reference GTF
# Author: Matthew Francoeur
# Date: 2026

# Directories
REFERENCE=~/Desktop/Projects/Chlamydomonas_rnaseq/data/reference
ALIGNMENT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/alignment
OUTPUT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/stringtie/pass1

#Files
annotation_file=${REFERENCE}/CreinhardtiiCC_4532_707_v6.1.gene_exons.gtf

# Loop through all the bam files and run stringtie
for BAM in ${ALIGNMENT}/*.bam; do
    # Get just the filename without path and extension
    base=$(basename ${BAM} .bam)
    echo "Processing ${base}..."
    
    #Run stringtie
    stringtie ${BAM} \
    -G ${annotation_file} \
    -o ${OUTPUT}/${base}.gtf \
    -e \
    -p 4

done
