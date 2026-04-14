#!/bin/bash
# Script 4: Filter for genome-wide significant SNPs (p < 5e-8)
# CAD: p-value in column 1
# RA: p-value in column 8
# Author: Gautami Deshpande
# Date: April 2026

cd ~/GWAS_project/data

# Filter CAD significant SNPs
echo "Filtering CAD SNPs at p < 5e-8..."
awk -F'\t' 'NR==1 || $1 < 0.00000005' GCST90132314_buildGRCh37.tsv > cad_significant.tsv
echo "CAD significant SNPs: $(wc -l < cad_significant.tsv)"

# Filter RA significant SNPs
echo "Filtering RA SNPs at p < 5e-8..."
zcat GCST90132223_buildGRCh37.tsv.gz | awk -F'\t' 'NR==1 || $8 < 0.00000005' > ra_significant.tsv
echo "RA significant SNPs: $(wc -l < ra_significant.tsv)"
