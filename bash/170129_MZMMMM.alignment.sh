/projects/p20742/tools/buildPipelineScripts.draft.pl \
-o /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output_merged_2_3/merged_bam \
-bam /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output_merged_2_3/merged_bam/bam \
-c /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output_merged_2_3/20170129_comparisons_MMMMZM.csv \
-g mm10 \
-t RNA \
-buildBcl2fq 0 \
-runBcl2fq 0 \
-runTrim 0 \
-buildAlign 0 \
-runAlign 0 \
-uploadASHtracks 0 \
-buildEdgeR 1 \
-runEdgeR 1 \
>& /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output_merged_2_3/merged_bam/MMM_MZM_Mouse_EdgeR &