/projects/p20742/tools/buildPipelineScripts.draft.pl \
    -o /projects/p20738/Pulmonary/Aging_Brain_20160905/Aging_Brain_Output/ \
    -bam /projects/p20738/Pulmonary/Aging_Brain_20160905/Aging_Brain_Output/20160728_Aging_Brain/bam \
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
    >& /projects/p20738/Pulmonary/Aging_Brain_20160905/getcounts20160906.log &
