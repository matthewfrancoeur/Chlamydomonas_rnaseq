#!/bin/bash
# Script: 01_qc_fastqc.sh
# Description: Run FastQC quality assessment on raw FASTQ files
# Author: Matthew Francoeur
# Date: 2026

# Directories
RAW=~/Desktop/Projects/Chlamydomonas_rnaseq/data/raw
QC_RAW=~/Desktop/Projects/Chlamydomonas_rnaseq/results/qc/raw

# Run FastQC on all samples
fastqc $RAW/*.fastq.gz -o $QC_RAW