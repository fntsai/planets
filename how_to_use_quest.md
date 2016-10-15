# Chapter 1 
In the followin we will talk about
* how to run pl file.
* how to control a job on Quest.

## This is Section 1
Following is the scripts for running ? pipeline on Quest.

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

Update: xxxXXX
Update: XXXxxx

Reference: [Clicl me](http://www.it.northwestern.edu/research/user-services/quest/job-management.html)

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
