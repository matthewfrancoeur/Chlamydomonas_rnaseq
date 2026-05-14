#!/bin/bash
# Script: 02_trimming_fastp.sh
# Description: Trim raw reads using fastp
# Author: Matthew Francoeur
# Date: 2026

# Directories
RAW=~/Desktop/Projects/Chlamydomonas_rnaseq/data/raw
PROCESSED=~/Desktop/Projects/Chlamydomonas_rnaseq/data/processed
QC_FASTP=~/Desktop/Projects/Chlamydomonas_rnaseq/results/qc/fastp

# Loop through all raw FASTQ files and trim each one
for sample in $RAW/*.fastq.gz; do
    # Get just the filename without path and extension
    base=$(basename ${sample} .fastq.gz)
    echo "Processing ${base}..."
    
    fastp \
        --in1 ${sample} \
        --out1 $PROCESSED/${base}_trimmed.fastq.gz \
        --qualified_quality_phred 20 \
        --trim_poly_x \
        --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
        --cut_right \
        --cut_right_window_size 1 \
        --cut_right_mean_quality 20 \
        --length_required 30 \
        --disable_trim_poly_g \
        --html $QC_FASTP/${base}_fastp.html \
        --json $QC_FASTP/${base}_fastp.json \
        --thread 4
done
