/projects/p20742/tools/buildPipelineScripts.draft.pl \
    -o /projects/b1038/Rheumatology/20161006_HumanSynovium_SortedMacs/HSSortedMacs_Output/ \
    -bs /projects/b1038/Rheumatology/20161006_HumanSynovium_SortedMacs/161006_NB501488_0041_AHVLW7BGXY/ \
    -g hs19 \
    -t RNA \
    -buildBcl2fq 1 \
    -runBcl2fq 1 \
    -runTrim 1 \
    -buildAlign 1 \
    -runAlign 1 \
    -uploadASHtracks 0 \
    -buildEdgeR 0 \
    -runEdgeR 0 \
    >& /projects/b1038/Rheumatology/20161006_HumanSynovium_SortedMacs/Logs/output.log &
