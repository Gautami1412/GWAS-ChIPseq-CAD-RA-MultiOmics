**eqtlgen_my_snps_final.txt**: eQTL analysis results from eQTLGen Phase 1 (n=31,684), identifying 3 of the 15 shared regulatory SNPs as significant cis-eQTLs for HLA-C in whole blood.

**prioritized_genes.txt**: Genes ranked by the number of shared SNPs they contain — top candidates include HLA-B (29 SNPs), HLA-DRB1 (28 SNPs), and HLA-DQA1 (19 SNPs).

**shared_regulatory_snps_annotated.txt**: Contains the 15 highest confidence SNPs that overlap H3K27ac active regulatory regions in both CD4+ T cells and CD14+ monocytes, annotated with signal strength for each cell type.

**shared_snps.bed**: Contains the 160 SNPs that are genome-wide significant (p < 5×10⁻⁸) in both CAD and RA, representing the core shared genetic signal between the two diseases.

**snps_for_chipseq.bed**: Contains 38 SNPs with distance = 0 prepared specifically for ChIP-seq overlap analysis, with columns: chromosome, start, end, rsID, and gene name.

**snps_inside_genes.bed**: Contains 47 SNP-gene pairs where the shared SNP physically sits inside a gene (distance = 0), representing the highest confidence set of functionally located variants.
