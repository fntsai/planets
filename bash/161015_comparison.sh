/projects/p20742/tools/buildPipelineScripts.draft.pl \
-o /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output/latest/Perlman_FuNien_20160725 \
-bam /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output/latest/Perlman_FuNien_20160725/bam \
-c /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/comparisons.BimLysMBimTrif.csv \
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
>& /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output/Perlman_FuNien_20160725/KidneyMacs_Mouse_EdgeR &
