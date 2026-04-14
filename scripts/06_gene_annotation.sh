#!/bin/bash
# Script 6: Annotate shared SNPs with nearest genes using RefGene
# Downloads RefGene from UCSC hg19 and uses bedtools closest
# Author: Gautami Deshpande
# Date: April 2026

# Download RefGene annotation
cd ~/GWAS_project/annotations
echo "Downloading RefGene from UCSC hg19..."
wget https://hgdownload.gi.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz
gunzip refGene.txt.gz
head -n 5 refGene.txt

# Extract required columns and convert to BED format
# Column 3 = chr, Column 5 = start, Column 6 = end, Column 13 = gene name
echo "Converting RefGene to BED format..."
awk -F'\t' '{print $3"\t"$5"\t"$6"\t"$13}' refGene.txt > genes.bed
head -n 5 genes.bed

# Sort both files for bedtools
echo "Sorting files..."
cd ~/GWAS_project/data
sort -k1,1 -k2,2n shared_snps.bed > shared_snps_sorted.bed

cd ~/GWAS_project/annotations
sort -k1,1 -k2,2n genes.bed > genes_sorted.bed

# Find closest gene for each shared SNP
echo "Finding closest gene for each shared SNP..."
cd ~/GWAS_project/data
bedtools closest \
    -a shared_snps_sorted.bed \
    -b ../annotations/genes_sorted.bed \
    -d > snps_with_genes.txt
head -n 10 snps_with_genes.txt

# Prioritize genes by SNP count
echo "Prioritizing genes by SNP count..."
cut -f8 snps_with_genes.txt | sort | uniq -c | sort -nr | head -20 > prioritized_genes.txt
cat prioritized_genes.txt

# Extract SNPs inside genes (distance = 0)
echo "Extracting SNPs inside genes..."
awk '$9 == 0 {print $4"\t"$8"\t"$9}' snps_with_genes.txt | sort -u >> snps_inside_genes.txt
echo -e "\nTotal unique SNP-gene pairs where SNP is inside gene: \
$(tail -n +3 snps_inside_genes.txt | wc -l)" >> snps_inside_genes.txt
cat snps_inside_genes.txt

# Prepare SNPs for ChIP-seq analysis
echo "Preparing SNPs for ChIP-seq analysis..."
awk '$9 == 0 && $4 != "NA"' snps_with_genes.txt | \
awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$8}' | \
sort -u > snps_for_chipseq.bed
echo "SNPs for ChIP-seq: $(wc -l < snps_for_chipseq.bed)"
head -5 snps_for_chipseq.bed
