/projects/p20742/tools/buildPipelineScripts.draft.pl \
-o /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output \
-bs /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/160624_NB501488_0012_AH3HMHBGXY_MZM1 \
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
>& /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output/kidney_macs_output.log &