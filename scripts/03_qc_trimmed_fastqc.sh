#!/bin/bash
# Script: 03_qc_trimmed_fastqc.sh
# Description: Run FastQC quality assessment on trimmed FASTQ files
# Author: Matthew Francoeur
# Date: 2026

# Directories
PROCESSED=~/Desktop/Projects/Chlamydomonas_rnaseq/data/processed
QC_TRIMMED=~/Desktop/Projects/Chlamydomonas_rnaseq/results/qc/trimmed

# Run FastQC on all trimmed samples
fastqc $PROCESSED/*.fastq.gz -o $QC_TRIMMED