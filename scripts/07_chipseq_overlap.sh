#!/bin/bash
# Script 7: Overlap shared SNPs with H3K27ac ChIP-seq peaks from ENCODE
# Cell types: CD4+ T cells (ENCFF347ILA), CD14+ monocytes (ENCFF706YSV)
# H3K27ac marks active enhancers and promoters
# Author: Gautami Deshpande
# Date: April 2026

cd ~/GWAS_project/chipseq

# Download ChIP-seq data from ENCODE
echo "Downloading H3K27ac ChIP-seq data for CD4+ T cells..."
wget https://www.encodeproject.org/files/ENCFF347ILA/@@download/ENCFF347ILA.bed.gz
gunzip ENCFF347ILA.bed.gz
mv ENCFF347ILA.bed H3K27ac_CD4Tcell_hg19.bed

echo "Downloading H3K27ac ChIP-seq data for CD14+ monocytes..."
wget https://www.encodeproject.org/files/ENCFF706YSV/@@download/ENCFF706YSV.bed.gz
gunzip ENCFF706YSV.bed.gz
mv ENCFF706YSV.bed H3K27ac_CD14monocyte_hg19.bed

# Overlap SNPs with ChIP-seq peaks
echo "Overlapping SNPs with T cell ChIP-seq peaks..."
bedtools intersect \
    -a ../data/snps_for_chipseq.bed \
    -b H3K27ac_CD4Tcell_hg19.bed \
    -wa -wb > snps_H3K27ac_CD4Tcell.txt

echo "Overlapping SNPs with monocyte ChIP-seq peaks..."
bedtools intersect \
    -a ../data/snps_for_chipseq.bed \
    -b H3K27ac_CD14monocyte_hg19.bed \
    -wa -wb > snps_H3K27ac_CD14monocyte.txt

echo "T cell overlapping SNPs: $(wc -l < snps_H3K27ac_CD4Tcell.txt)"
echo "Monocyte overlapping SNPs: $(wc -l < snps_H3K27ac_CD14monocyte.txt)"

# Find SNPs common to both cell types
echo "Finding SNPs active in both cell types..."
awk '{print $4}' snps_H3K27ac_CD4Tcell.txt | sort > tcell_snps.txt
awk '{print $4}' snps_H3K27ac_CD14monocyte.txt | sort > monocyte_snps.txt
comm -12 tcell_snps.txt monocyte_snps.txt > shared_regulatory_snps.txt
echo "SNPs active in both cell types: $(wc -l < shared_regulatory_snps.txt)"

# Combine columns from both cell types
echo "Creating annotated shared regulatory SNPs file..."
grep -Ff shared_regulatory_snps.txt snps_H3K27ac_CD4Tcell.txt | \
    awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$12}' | \
    sort -u > temp_tcell.txt

grep -Ff shared_regulatory_snps.txt snps_H3K27ac_CD14monocyte.txt | \
    awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$12}' | \
    sort -u > temp_monocyte.txt

paste temp_tcell.txt temp_monocyte.txt | \
    awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$12}' \
    > shared_regulatory_snps_annotated.txt

echo "Final annotated file created"
cat shared_regulatory_snps_annotated.txt
