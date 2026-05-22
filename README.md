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
### Data Acquisition
Sequencing reads were downloaded from the NCBI’s Sequence Read Archive database using SRA-tools version 2.10.1 (2). Six samples, originally part of the paper by Miller et al. (1), were downloaded using the SRR accession numbers SRR066643-SRR066648. Data from all samples represents single-end RNA-seq reads collected via an Illumina Genome Analyzer II. The first three samples represent the nitrogen replete condition, and the second three the nitrogen deprivation condition. Two additional samples, sequenced using 454 GS FLX, were included in the original analysis. These were not analyzed in this study due to the different sequencing platform used. 
### Quality Assessment
The raw files were first examined using fastqc version 0.12.1 (3). Raw reads were 75 bases in length, and counts ranged from approximately 15.2 to 18.3 million reads per sample. Sequences showed a drop in quality towards the 3’ end, with the per base sequence quality dropping below 20 around position 50. Additionally, adapter content, primarily the Illumina universal adapter, increased in all samples beginning at around position 30 and increasing towards the 3’ end.  Adapter content maxed out between approximately 6 and 14 percent in all samples. Furthermore, per base sequence content showed 5’ signatures characteristic of hexamer priming bias (4), and an overall GC content reflective of the *C. reinhardtii* genome (5). Per tile quality was flagged in three samples, indicative of localized flow cell issues. Additionally, per sequence quality scores were flagged in three samples, reflective of the quality degradation previously mentioned. Such quality issues are consistent with the early Illumina GA II instrumentation used in this study. Per sequence GC content was also flagged in one sample. Sequence duplication was observed in all samples, as is expected with RNA-seq. Finally, polyA regions were overrepresented in two samples, which is indicative of the mRNA origin of the sequenced material. 
### Read Trimming
Reads were trimmed using fastp (6) version 0.22.0 with parameters selected to closely match the methods of Miller et al. (1). PolyX trimming  was enabled (--trim_poly_x) to remove polyA tails, while polyG trimming  was disabled (--disable_trim_poly_g) due to this being an artifact of two-color Illumina chemistry not implemented by the Illumina GA II used in this study. The Illumina universal adapter was specified (--adapter_sequence) for adapter trimming. Additionally, bases with a quality under 20 were trimmed from the 3’ end of reads using sliding window trimming (--cut_right, --cut_right_window_size 1,                               --cut_right_mean_quality 20), with only reads greater than or equal to 30 bases retained for further analysis (--length_required 30). Finally, the qualified quality phred score was set to 20 (--qualified_quality_phred 20) as an additional quality check. 
### Post-Trimming Quality Assessment
Pre- and post-trimming quality were compared, and trimming results analyzed, using MultiQC (7). Post-trimming read counts ranged from approximately 8.6 to 10.6 million reads, and the median read length of samples was between 45 and 47 bases. This reduction in median read lengths from 75  reflects the removal of low quality bases from the 3’ end of reads. Per base sequence content showed the same characteristics as before, while post-trimming sequence length distributions were flagged due to variations in read lengths. Adapter content was only flagged in sample SRR066646, which had the highest pre-trimming adapter content, suggesting incomplete adapter removal in this sample. Additionally, two samples were flagged for per tile sequence quality, including one sample not flagged in the raw data. This new flag likely reflects changes in the quality profile following 3’ trimming. Other than those mentioned above, all status checks were passing, which represents a marked improvement over the raw data. 

[TO BE UPDATED]

## Key Findings
[TO BE UPDATED]

## Dependencies and Setup
[TO BE UPDATED]

## Acknowledgements
[TO BE UPDATED]

## References
1.	Miller R, Wu G, Deshpande RR, Vieler A, Gärtner K, Li X, et al. Changes in transcript abundance in Chlamydomonas reinhardtii following nitrogen deprivation predict diversion of metabolism. Plant Physiol. 2010 Dec;154(4):1737–52. doi:10.1104/pp.110.165159 PubMed PMID: 20935180; PubMed Central PMCID: PMC2996024.
2.	SRA Toolkit Development Team. GitHub [Internet]. [cited 2026 May 21]. 01. Downloading SRA Toolkit. Available from: https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit
3.	Andrews S. Babraham Bioinformatics - FastQC A Quality Control tool for High Throughput Sequence Data [Internet]. [cited 2026 May 21]. Available from: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
4.	Hansen KD, Brenner SE, Dudoit S. Biases in Illumina transcriptome sequencing caused by random hexamer priming. Nucleic Acids Res. 2010 Jul;38(12):e131. doi:10.1093/nar/gkq224 PubMed PMID: 20395217; PubMed Central PMCID: PMC2896536.
5.	Merchant SS, Prochnik SE, Vallon O, Harris EH, Karpowicz SJ, Witman GB, et al. The Chlamydomonas Genome Reveals the Evolution of Key Animal and Plant Functions. Science. 2007 Oct 12;318(5848):245–50. doi:10.1126/science.1143609 PubMed PMID: 17932292; PubMed Central PMCID: PMC2875087.
6.	Chen S, Zhou Y, Chen Y, Gu J. fastp: an ultra-fast all-in-one FASTQ preprocessor. Bioinformatics. 2018 Sep 1;34(17):i884–90. doi:10.1093/bioinformatics/bty560 PubMed PMID: 30423086; PubMed Central PMCID: PMC6129281.
7.	Ewels P, Magnusson M, Lundin S, Käller M. MultiQC: summarize analysis results for multiple tools and samples in a single report. Bioinformatics. 2016;32(19):3047. doi:10.1093/bioinformatics/btw354




