#!/bin/bash
# Script: 10_prepDE.sh
# Description: Create text file of GTF file names and paths, run prepDE.py
# Author: Matthew Francoeur
# Date: 2026

# Directories
PASS3=~/Desktop/Projects/Chlamydomonas_rnaseq/results/stringtie/pass3
COUNTS=~/Desktop/Projects/Chlamydomonas_rnaseq/results/counts

# Loop through GTF files and create text file with names and paths
for GTF in ${PASS3}/*.gtf; do
    echo "$(basename $GTF .gtf) ${GTF}" 
done > ${PASS3}/sample_list.txt

# Run prepDE.py using text file 
python ~/miniconda3/envs/chlamydomonas_rnaseq/bin/prepDE.py \
    -i ${PASS3}/sample_list.txt \
    -g ${COUNTS}/gene_count_matrix.csv \
    -t ${COUNTS}/transcript_count_matrix.csv 
    