# Workflow: Biological Interpretation and Analysis Decisions

## Aim
To identify and functionally characterize shared genome-wide significant loci between Coronary Artery Disease (CAD) and Rheumatoid Arthritis (RA) through integrative GWAS, ChIP-seq, and eQTL analysis, in order to 
prioritize candidate regulatory variants underlying the known epidemiological link between autoimmune disease and cardiovascular risk.

---

## Biological Rationale

### Why CAD and RA?
Epidemiological studies consistently show that RA patients have significantly elevated cardiovascular risk independent of traditional CVD risk factors. This suggests a shared biological mechanism — most 
likely chronic systemic inflammation — rather than just coincidental co-occurrence. Identifying shared genetic variants provides a hypothesis-free way to uncover this mechanism at the molecular level.

### Why the HLA Region?
The 160 shared SNPs identified in this analysis are overwhelmingly concentrated on chromosome 6 in the HLA (Human Leukocyte Antigen) 
region. This is biologically meaningful because:
- The HLA region is the primary genetic determinant of autoimmune susceptibility
- HLA genes control antigen presentation to T cells — a central process in both autoimmune inflammation (RA) and atherosclerosis (CAD)
- Chronic HLA-mediated immune activation could represent the shared biological bridge between both diseases

### Why Immune Cell Types?
Since the shared genetic signal concentrated in immune regulatory genes,
H3K27ac ChIP-seq data from immune-relevant cell types was chosen:
- **CD4+ T cells** — central to RA pathology through autoantigen recognition and inflammatory cytokine production
- **CD14+ monocytes** — drive inflammation in both RA synovium and atherosclerotic plaques in CAD

If shared SNPs fall within active regulatory regions in these cell types, it suggests they dysregulate immune gene expression in a way that could contribute to both diseases simultaneously.

---

## Key Analysis Decisions and Justifications

### Decision 1 — Significance Threshold (p < 5×10⁻⁸)
Standard genome-wide significance threshold was applied to both datasets to ensure only robustly associated variants were included. This conservative threshold minimizes false positives at the cost 
of potentially missing true associations with smaller effect sizes.

### Decision 2 — Coordinate-Based SNP Matching
CAD data used chromosome:position format for SNP IDs while RA data used rsIDs. Shared SNPs were therefore identified by matching chromosomal coordinates rather than SNP identifiers — ensuring no 
true shared variants were missed due to ID format differences.

### Decision 3 — Distance = 0 Filter for ChIP-seq
Only SNPs physically inside gene boundaries (distance = 0) were carried forward for ChIP-seq analysis. This conservative filter ensures the highest confidence set of variants where the SNP is 
most likely to directly affect gene regulation.

### Decision 4 — H3K27ac as Regulatory Mark
H3K27ac was selected as the histone mark of interest because it specifically marks active enhancers and promoters — the regulatory elements most likely to be affected by non-coding genetic variants. 
A SNP overlapping an H3K27ac peak is more likely to have functional consequences than one in inactive chromatin.

### Decision 5 — Requiring Activity in Both Cell Types
Only SNPs active in H3K27ac peaks in BOTH T cells AND monocytes were considered high confidence. This dual requirement ensures the identified variants are relevant to both the autoimmune (T cell) 
and inflammatory (monocyte) components of the shared disease mechanism.

---

## Biological Interpretation of Results

### Phase 1 Finding — Shared Genetic Signal
160 SNPs reached genome-wide significance in both CAD and RA. The concentration of these SNPs on chromosome 6 in the HLA region is consistent with the known role of immune dysregulation in both 
diseases. The non-HLA shared SNP on chromosome 1 (rs34210977 in MMEL1) represents a potentially novel shared locus warranting further investigation.

### Phase 2 Finding — Gene Prioritization
Top genes by SNP density:
- HLA-B (29 SNPs), HLA-DRB1 (28 SNPs), HLA-DQA1 (19 SNPs)

HLA-DRB1 and HLA-DQA1 are particularly noteworthy as they encode MHC class II molecules responsible for presenting autoantigens to CD4+ T cells — a central mechanism in RA pathogenesis. Their 
presence in the shared CAD-RA loci suggests autoantigen presentation may be a shared driver of both conditions.

### Phase 3 Finding — Regulatory Evidence
Of 38 SNPs inside genes, 15 overlap active H3K27ac regulatory regions in both immune cell types. The cell-type specific signal patterns suggest distinct but overlapping mechanisms:

| Gene | Signal Pattern | Biological Implication |
|---|---|---|
| HLA-A | Stronger in T cells | May regulate adaptive immune response driving RA |
| HLA-C | Stronger in monocytes | May regulate innate immune inflammation driving CAD |
| HLA-B | Active in both equally | Most likely candidate for shared mechanism |

### Phase 4 Finding — eQTL Evidence
3 of 15 SNPs (rs9266196, rs9266144, rs697742) were identified as significant cis-eQTLs for HLA-C in whole blood (FDR = 0). 

Notably these SNPs are positionally assigned to HLA-B by RefGene coordinates, yet functionally regulate HLA-C expression — suggesting cross-gene regulatory effects within the densely packed HLA region. 
This is a known phenomenon in HLA biology and adds an important mechanistic dimension to the findings.

The opposing directions of effect are biologically interesting:
- rs9266196 increases HLA-C expression (Z = +47.62)
- rs9266144 and rs697742 decrease HLA-C expression (Z = -23.48, -22.12)

This suggests the HLA-C regulatory landscape at this locus is complex, with different allelic combinations producing opposing expression effects — potentially explaining individual differences 
in disease susceptibility.

---

## Overall Biological Narrative

Taken together, the three layers of evidence tell a coherent story:

**Layer 1 (GWAS):** RA and CAD share 160 genome-wide significant genetic loci, predominantly in the HLA region.

**Layer 2 (ChIP-seq):** 15 of these shared loci fall within active regulatory chromatin in immune cells relevant to both diseases, suggesting they are not just statistically significant but 
biologically active.

**Layer 3 (eQTL):** 3 of these regulatory variants demonstrably affect HLA-C gene expression in whole blood, providing the 
strongest evidence that these shared variants have functional molecular consequences.

This multi-layer evidence supports the hypothesis that shared HLA-region regulatory variants contribute to immune dysregulation in both RA and CAD, potentially representing the molecular basis 
of the known epidemiological link between these conditions.

---

## Limitations

- eQTL analysis was limited to whole blood (eQTLGen); cell-type specific eQTL validation in T cells and monocytes remains needed to confirm cell-type specific regulatory effects suggested by 
  ChIP-seq signal differences.
- Only 3 of 15 SNPs had detectable eQTL signals, consistent with known challenges of eQTL mapping in the highly polymorphic HLA region.
- Coordinate-based SNP matching between CAD and RA datasets may have introduced imprecision due to genome build differences.
- The analysis cannot establish causality — whether RA genetically causes CAD or vice versa requires Mendelian Randomization.

## Future Directions
- Cell-type specific eQTL analysis using DICE database
- Mendelian Randomization using TwoSampleMR to formally test 
  causal direction between RA and CAD
- Colocalization analysis (coloc) to confirm shared causal variants
- Drug target enrichment using OpenTargets and DGIdb
- Transcription factor binding site analysis to identify disrupted 
  regulatory motifs
