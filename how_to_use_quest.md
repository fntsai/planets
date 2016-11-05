# Chapter 1 
In the followin we will talk about
* how to run pl file.
* how to control a job on Quest.
* how to backup a folder (copy).

## This is Section 1
Following is the scripts for running alignment pipeline on Quest.

```sh
/projects/p20742/tools/buildPipelineScripts.draft.pl \
    -o /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output/latest  \
    -bs /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/160725_NB501488_0017_AH5KLLBGXY \
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
    >& /projects/b1038/Rheumatology/20160725-Bim_Kid-Macs/output/latest/kidney_macs_output.log &
```


## This is Section 2
Following is the scripts for running pairwise pipeline on Quest.

```sh
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
```

## How to control job in Quest

Reference: [Northwestern IT](http://www.it.northwestern.edu/research/user-services/quest/job-management.html)
This is **bold**. This is *italitc*.
This is a table:

| C1|C2 |C3 |   |   |
|---|---|---|---|---|
|   |   |   |   |   |
|   |   |   |   |   |
|   |   |   |   |   |

To check job status, use
```sh
showq -w user=pjh116
```
or simply use
```sh
qstat
```
To kill a job, use
```sh
mjobctl -c <JOB ID>
```
## How to copy (backup) the content of a folder

Command is simple, here I provide two samples to show how to copy entire directory in linux.

```
cp -r sourcedir targetdir
```

for instance,

1. Copy anything from current directory to /usr/local/download

```
cp -r * /usr/local/download
```

2. Copy whole directory (include content) /usr/local/fromdownload to target /usr/local/download. This can be used for backing up a folder.

```
cp -r  /usr/local/fromdownload  /usr/local/download
```

**Note** 

If `cp` failed to perform the copy, for example, an existing destination file cannot be opened, then try using `cp -rf` instead of `cp -r`, which shall remove te existing destination file and redo the copy.
```
cp -rf
```

## How to create a link

Here we show how to create a (soft) link to a folder or a file in linux.
```
ln -s <target> <link>
```
For example, if we want to create a link, namely `Perlman_2016027` to `20161104_MZM_kidmacs_Perlman_2016027`, then we can use

```
ln -s 20161104_MZM_kidmacs_Perlman_2016027 Perlman_2016027
```





