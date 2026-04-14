#!/bin/bash
# Script 5: Convert significant SNPs to BED format and find shared SNPs
# BED format: chr | start | end | SNP_ID
# Author: Gautami Deshpande
# Date: April 2026

cd ~/GWAS_project/data

# Convert CAD to BED format
# Column 2 = chromosome, Column 3 = position, Column 10 = markername
echo "Converting CAD to BED format..."
awk -F'\t' 'NR>1 {print "chr"$2"\t"$3"\t"$3"\t"$10}' cad_significant.tsv > cad_snps.bed
echo "CAD BED file created with $(wc -l < cad_snps.bed) SNPs"
head -n 5 cad_snps.bed

# Convert RA to BED format
# Column 2 = chromosome, Column 3 = position, Column 1 = variant_id
echo "Converting RA to BED format..."
awk -F'\t' 'NR>1 {print "chr"$2"\t"$3"\t"$3"\t"$1}' ra_significant.tsv > ra_snps.bed
echo "RA BED file created with $(wc -l < ra_snps.bed) SNPs"
head -n 5 ra_snps.bed

# Find shared significant SNPs between CAD and RA
echo "Finding shared SNPs..."
cat cad_snps.bed ra_snps.bed | sort -k1,1 -k2,2n | uniq -d > shared_snps.bed
echo "Number of significant SNPs in both diseases:"
wc -l shared_snps.bed

if [ -s shared_snps.bed ]; then
    echo -e "\nFirst 10 shared SNPs:"
    head -n 10 shared_snps.bed
else
    echo "No shared SNPs found at p < 5e-8"
fi
