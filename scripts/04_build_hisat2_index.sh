#!/bin/bash
# Script: 04_build_hisat2_index.sh
# Description: Build hisat2 index using splice and exon sites from annotation file
# Author: Matthew Francoeur
# Date: 2026

# Directories
REFERENCE=~/Desktop/Projects/Chlamydomonas_rnaseq/data/reference

# Files
gff3_file=${REFERENCE}/CreinhardtiiCC_4532_707_v6.1.gene_exons.gff3
annotation_file=${REFERENCE}/CreinhardtiiCC_4532_707_v6.1.gene_exons.gtf
genome_file=${REFERENCE}/CreinhardtiiCC_4532_707_v6.0.fa

# Convert GFF3 to GTF format for HISAT2 compatibility
gffread ${gff3_file} -T -o ${annotation_file}

# Extract splice sites from annotation
hisat2_extract_splice_sites.py ${annotation_file} > ${REFERENCE}/splice_sites.txt

# Extract exons sites from annotation
hisat2_extract_exons.py ${annotation_file} > ${REFERENCE}/exons.txt

# Build HISAT2 index with splice sites and exons
hisat2-build \
    --ss ${REFERENCE}/splice_sites.txt \
    --exon ${REFERENCE}/exons.txt \
    ${genome_file} \
    ${REFERENCE}/chlamydomonas_v6_index