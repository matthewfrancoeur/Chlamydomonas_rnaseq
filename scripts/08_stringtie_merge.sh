#!/bin/bash
# Script: 08_stringtie_merge.sh
# Description: Create merged GTF fiile
# Author: Matthew Francoeur
# Date: 2026

# Directories
REFERENCE=~/Desktop/Projects/Chlamydomonas_rnaseq/data/reference
OUTPUT=~/Desktop/Projects/Chlamydomonas_rnaseq/results/stringtie/merged
PASS1=~/Desktop/Projects/Chlamydomonas_rnaseq/results/stringtie/pass1

#Files
annotation_file=${REFERENCE}/CreinhardtiiCC_4532_707_v6.1.gene_exons.gtf

#Merge all individually quaniitfied GTF files against reference GTF
stringtie --merge \
    -G ${annotation_file} \
    -o ${OUTPUT}/merged.gtf \
    ${PASS1}/*.gtf