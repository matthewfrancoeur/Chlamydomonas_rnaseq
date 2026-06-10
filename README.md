# Reanalysis of Nitrogen Depletion RNA-seq in *Chlamydomonas reinhardtii*

## Overview
This study will attempt to reproduce and expand upon the paper "Changes in Transcript Abundance in *Chlamydomonas reinhardtii* following Nitrogen Deprivation Predict Diversion of Metabolism" by Miller et al. 

## Biological Background
The response of *Chlamydomonas reinhardtii* to environmental nitrogen levels has important implications for both biotechnology industries [1] and the environment. Microalgae, including *C. reinhardtii*, tend to accumulate lipid droplets in response to nutrient deprivation. This response is relevant to their use as biomass producers for biofuel feedstock [1]. Additionally, nitrogen runoff from farming is a significant environmental concern. Therefore, understanding how algae respond to nutrient stimuli may help guide future actions, decisions, and policies. 

## Original Study
**Paper:** Changes in Transcript Abundance in *Chlamydomonas reinhardtii* following Nitrogen Deprivation Predict Diversion of Metabolism  

**Authors:**  Miller, R., Wu, G., Deshpande, R. R., Vieler, A., Gärtner, K., Li, X., Moellering, E. R., Zäuner, S., Cornish, A. J., Liu, B., Bullard, B., Sears, B. B., Kuo, M.-H., Hegg, E. L., Shachar-Hill, Y., Shiu, S.-H., & Benning, C.

**Year:** 2010 

**DOI:** https://doi.org/10.1104/pp.110.165159 

**BioProject:** PRJNA133477

**SRA Accession:**
**SRA Accessions (Illumina samples):**
| Name | Condition | SRR Accession |
|--------|-----------|---------------|
|  Chlamy_T_RNA_seq_1 | Nitrogen repletion (control) | SRR066643 |
| Chlamy_T_RNA_seq_2 | Nitrogen repletion (control) | SRR066644 |
| Chlamy_T_RNA_seq_3 | Nitrogen repletion (control) | SRR066645 |
| Chlamy_N_RNA_seq_1 | Nitrogen deprivation | SRR066646 |
| Chlamy_N_RNA_seq_2 | Nitrogen deprivation | SRR066647 |
| Chlamy_N_RNA_seq_3 | Nitrogen deprivation | SRR066648 |

## Why Reanalysis?
This effort is being conducted for both its educational and scientific value. In terms of education, it allows me to run through a bioinformatics pipeline from data to publication quality figure generation. Additionally, where appropriate, I plan to use modern tools to improve upon this 2010 study. Thus, I also hope to arrive at new scientific insights.

## Repository Structure
[TO BE UPDATED]

## Methods
### Computational Environment
All analyses for this study were done using a main chlamydomonas_rnaseq conda environment unless otherwise noted. Full specifications are available in environment/environment.yml. Due to a dependency conflict, a separate samtools_env conda environment was created specifically for samtools, which is available in environment/samtools_environment.yml. Both conda environments were managed with conda version 25.7.0, and packages were installed primarily from the bioconda and conda-forge channels.   
### Data Acquisition
Sequencing reads were downloaded from the NCBI’s Sequence Read Archive database using sra-tools version 2.10.1 (2). Six samples, originally part of the paper by Miller et al. (1), were downloaded using the SRR accession numbers SRR066643-SRR066648. Data from all samples represents single-end RNA-seq reads collected via an Illumina Genome Analyzer II. The first three samples represent the nitrogen replete condition, and the second three the nitrogen deprivation condition. Two other samples, sequenced using a 454 GS FLX system, provided additional insights to the original study. That being said, this reanalysis focuses on direct comparison of the six Illumina samples. 
### Quality Assessment
The raw files were first examined using FastQC version 0.12.1 (3). Raw reads were 75 bases in length, and counts ranged from approximately 15.2 to 18.3 million reads per sample. Sequences showed a drop in quality towards the 3’ end, with the per base sequence quality dropping below 20 around position 50. Additionally, adapter content, primarily the Illumina universal adapter, increased in all samples beginning at around position 30 and increasing towards the 3’ end.  Adapter content maxed out between approximately 6 and 14 percent in all samples. Furthermore, per base sequence content showed 5’ signatures characteristic of hexamer priming bias (4), and an overall GC content reflective of the *C. reinhardtii* genome (5). Per tile quality was flagged in three samples, indicative of localized flow cell issues. Additionally, per sequence quality scores were flagged in three samples, reflective of the quality degradation previously mentioned. Such quality issues are consistent with the early Illumina GA II instrumentation used in this study. Per sequence GC content was also flagged in one sample. Sequence duplication was observed in all samples, as is expected with RNA-seq. Finally, polyA regions were overrepresented in two samples, which is indicative of the mRNA origin of the sequenced material. 
[Full parameters documented in scripts/01_qc_raw_fastqc.sh](scripts/01_qc_raw_fastqc.sh)
### Read Trimming
Reads were trimmed using fastp version 0.22.0 (6) with parameters selected to closely match the methods of Miller et al. (1). PolyX trimming  was enabled (--trim_poly_x) to remove polyA tails, while polyG trimming was disabled (--disable_trim_poly_g) due to this being an artifact of two-color Illumina chemistry not implemented by the Illumina GA II used in this study. The Illumina universal adapter sequence was specified (--adapter_sequence) for adapter trimming. Additionally, bases with a quality under 20 were trimmed from the 3’ end of reads using sliding window trimming (--cut_right, --cut_right_window_size 1, --cut_right_mean_quality 20), with only reads greater than or equal to 30 bases retained for further analysis (--length_required 30). Finally, the qualified quality phred score was set to 20 (--qualified_quality_phred 20) as an additional quality check. 
[Full parameters documented in scripts/02_trimming_fastp.sh](scripts/02_trimming_fastp.sh)
### Post-Trimming Quality Assessment
Pre- and post-trimming quality were compared, and trimming results analyzed, using MultiQC version 1.35 (7). Post-trimming read counts ranged from approximately 8.6 to 10.6 million reads, and the median read length of samples was between 45 and 47 bases. This reduction in median read lengths from 75 bases reflects the removal of low quality bases from the 3’ end of reads. Per base sequence content showed the same characteristics as before, while post-trimming sequence length distributions were flagged due to variations in read lengths. Adapter content was only flagged in sample SRR066646, which had the highest pre-trimming adapter content, suggesting incomplete adapter removal in this sample. Additionally, two samples were flagged for per tile sequence quality, including one sample not flagged in the raw data. This new flag likely reflects changes in the quality profile following 3’ trimming. Other than those mentioned above, all status checks were passing, which represents a marked improvement over the raw data. 
[Full parameters documented in scripts/03_qc_trimmed_fastqc.sh](scripts/03_qc_trimmed_fastqc.sh)
### Reference Genome
The *Chlamydomonas reinhardtii* v6.0 genome assembly and v6.1 annotation (8) were downloaded from Phytozome (https://phytozome-next.jgi.doe.gov). This genome is the newest version available, and features substantially improved quality and annotations (8). Thus, the use of the v6.0 genome represents a notable improvement over the original paper, which used version 4.0 (1). That being said, the v6.0 genome uses strain CC-4532 as its primary reference (8), while the experimental analysis done by Miller et al. used strain dw15.1 (1). This is a minor inconsistency, however, the version 4.0 genome used for the original analysis is based on strain CC-503 (8,9), which is also inconsistent with the experimental strain used. Overall, the v6.0 genome represents the most complete and current genome assembly available and was thus chosen for this reanalysis study. 
### Alignment
An index was built and alignment performed using HISAT2 version 2.2.2 (10). To build the index, the provided GFF3 reference genome was converted to GTF format as required by hisat2_extract_splice_sites.py and hisat2_extract_exons.py. This conversion was done using gffread version 0.12.7 (11). After conversion, splice and exon sites were extracted and stored as text files using hisat2_extract_splice_sites.py and hisat2_extract_exons.py respectively. These files were then used to build a splice-aware index file for the genome using the HISAT2 build tool (hisat2-build) and the reference genome. The splice site text file was specified using the flag --ss, while the exon sites were given using the flag --exon. Finally, alignment was performed on each trimmed file using HISAT2 and the constructed index. The index was passed to HISAT2 using the flag -x, and the output directed to a SAM file using the flag -S. The HISAT2 standard error output was also directed to a separate alignment_log.txt file for each sample, which captured alignment statistics. Overall alignment rates ranged from 91.54% to 95.76%, indicating successful alignment to the v6.0 reference genome. 
[Index parameters documented in scripts/04_build_hisat2_index.sh](scripts/04_build_hisat2_index.sh)
[Alignment parameters documented in scripts/05_alignment_hisat2.sh](scripts/05_alignment_hisat2.sh)
### SAM to BAM Conversion
The aligned SAM files were then converted to BAM format to reduce file size and improve processing speed. Additionally, from each resulting file an indexed BAM file was generated for use by downstream tools. This process was done using samtools version 1.9 (12) and a separate samtools_env conda environment. 
[Full parameters documented in scripts/06_sam_to_bam.sh](scripts/06_sam_to_bam.sh)
### Transcript Quantification (StringTie)
StringTie version 2.1.7 (13) was used for transcript quantification. First, the BAM files were individually quantified against the GTF annotation file converted from the reference GFF3. Additionally, the -e flag was specified to restrict quantification to reference transcripts only, which simplifies downstream analysis. Next, the resulting quantified GTF files from each sample were merged into a combined GTF file, using the StringTie merge function (stringtie --merge), which includes all observed transcript types across all samples. The BAM files were then passed through StringTie again, however, this time they quantified against the merged GTF file. The -e flag was also used in this case. This three-step process allows all samples to be quantified against the same reference, which is particularly important when novel transcript discovery is enabled. In this case, one pass against the reference would likely have sufficed, however, the full three passes were used for completeness and because transcript discovery was originally planned but later decided against. 
### Count Matrix Generation (prepDE)
The quantified GTF files from each sample were then converted to count matrices in CSV format for use by DESeq2. This was done using prepDE.py, which is a Python script included in StringTie (13). A sample list file containing sample names and GTF file paths was generated and passed to prepDE.py using the -i flag. Finally, the flags -g and -t were specified to generate both a gene count matrix and transcript count matrix CSV. 
[Full parameters documented in scripts/10_prepDE.sh](scripts/10_prepDE.sh)
## Key Findings

[TO BE UPDATED]

## Dependencies and Setup
[TO BE UPDATED]

## Acknowledgements
These sequence data were produced by the US Department of Energy Joint Genome Institute https://www.jgi.doe.gov in collaboration with the user community. 
[TO BE UPDATED]

## References
1.	Miller R, Wu G, Deshpande RR, Vieler A, Gärtner K, Li X, et al. Changes in transcript abundance in Chlamydomonas reinhardtii following nitrogen deprivation predict diversion of metabolism. Plant Physiol. 2010 Dec;154(4):1737–52. doi:10.1104/pp.110.165159 PubMed PMID: 20935180; PubMed Central PMCID: PMC2996024.
2.	SRA Toolkit Development Team. GitHub [Internet]. [cited 2026 May 21]. 01. Downloading SRA Toolkit. Available from: https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit
3.	Andrews S. Babraham Bioinformatics - FastQC A Quality Control tool for High Throughput Sequence Data [Internet]. [cited 2026 May 21]. Available from: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
4.	Hansen KD, Brenner SE, Dudoit S. Biases in Illumina transcriptome sequencing caused by random hexamer priming. Nucleic Acids Res. 2010 Jul;38(12):e131. doi:10.1093/nar/gkq224 PubMed PMID: 20395217; PubMed Central PMCID: PMC2896536.
5.	Merchant SS, Prochnik SE, Vallon O, Harris EH, Karpowicz SJ, Witman GB, et al. The Chlamydomonas Genome Reveals the Evolution of Key Animal and Plant Functions. Science. 2007 Oct 12;318(5848):245–50. doi:10.1126/science.1143609 PubMed PMID: 17932292; PubMed Central PMCID: PMC2875087.
6.	Chen S, Zhou Y, Chen Y, Gu J. fastp: an ultra-fast all-in-one FASTQ preprocessor. Bioinformatics. 2018 Sep 1;34(17):i884–90. doi:10.1093/bioinformatics/bty560 PubMed PMID: 30423086; PubMed Central PMCID: PMC6129281.
7.	Ewels P, Magnusson M, Lundin S, Käller M. MultiQC: summarize analysis results for multiple tools and samples in a single report. Bioinformatics. 2016;32(19):3047. doi:10.1093/bioinformatics/btw354
8.	Craig RJ, Gallaher SD, Shu S, Salomé PA, Jenkins JW, Blaby-Haas CE, et al. The Chlamydomonas Genome Project, version 6: Reference assemblies for mating-type plus and minus strains reveal extensive structural mutation in the laboratory. Plant Cell. 2023 Feb 1;35(2):644–72. doi:10.1093/plcell/koac347
9.	Blaby IK, Blaby-Haas CE, Tourasse N, Hom EFY, Lopez D, Aksoy M, et al. The Chlamydomonas genome project: a decade on. Trends Plant Sci. 2014 Oct 1;19(10):672–80. doi:10.1016/j.tplants.2014.05.008
10.	Kim D, Paggi JM, Park C, Bennett C, Salzberg SL. Graph-based genome alignment and genotyping with HISAT2 and HISAT-genotype. Nat Biotechnol. 2019 Aug;37(8):907–15. doi:10.1038/s41587-019-0201-4
11.	Pertea G, Pertea M. GFF Utilities: GffRead and GffCompare [Internet]. F1000Research; 2020 [cited 2026 Jun 8]. Available from: https://f1000research.com/articles/9-304 doi:10.12688/f1000research.23297.2
12.	Danecek P, Bonfield JK, Liddle J, Marshall J, Ohan V, Pollard MO, et al. Twelve years of SAMtools and BCFtools. GigaScience. 2021 Feb 1;10(2):giab008. doi:10.1093/gigascience/giab008
13.	Pertea M, Pertea GM, Antonescu CM, Chang TC, Mendell JT, Salzberg SL. StringTie enables improved reconstruction of a transcriptome from RNA-seq reads. Nat Biotechnol. 2015 Mar;33(3):290–5. doi:10.1038/nbt.3122 PubMed PMID: 25690850; PubMed Central PMCID: PMC4643835.

