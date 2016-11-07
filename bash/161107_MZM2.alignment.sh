/projects/p20742/tools/buildPipelineScripts.draft.pl \
-o /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output_3 \
-bs /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/160627_NB501488_0013_AH3KNWBGXY_MZM2 \
-g mm10 \
-t RNA \
-buildBcl2fq 1 \
-runBcl2fq 1 \
-runTrim 1 \
-buildAlign 1 \
-runAlign 1 \
-uploadASHtracks 0 \
-buildEdgeR 0 \
-runEdgeR 0 \
>& /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output_3/MZM2_output.log &