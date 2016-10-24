install.packages("ggplot2")
source("https://bioconductor.org/biocLite.R")
biocLite("geneplotter")
biocLite("edgeR")
library(edgeR)
library("ggplot2")
library("RColorBrewer")

setwd("/Users/FuNien/Documents/2016_RNA-seq/comparisons/20161015/Bim.LysMBim.Trif/all_genes_no_trimmed")

####Set variables for your script###

#Assigns the name of a file that contain your counts
#Should be organized as a tab-delimited file with your experimental conditions as columns and your genes as rows
#The second row should contain your group names
counts_file <- "Bim.LysMBim.Trif.normCounts.txt"

#Assigns the name of a file that contains your groups in the desired order
group_file <- "all.8mo.macs.txt"

#Assign a name according to which your output folder and files will be names
outputname <- "anova"

#Creates the names for your output folder and files based on your outputname variable
if (file.exists(outputname)==F){
  dir.create(file.path(outputname))
}
anova_file <- paste(outputname,"/",outputname,"_anova.txt", sep="")
logcounts_file_name <- paste(outputname, "/", outputname,"_log_counts.txt", sep="")
variance_summary_file <- paste(outputname,"/",outputname,"_var.txt", sep="")
scree_plot_file_name <- paste(outputname,"/",outputname,"_scree_plot.png", sep="")
scree_plot_name <- paste("Scree plot for ", outputname, sep="")
loadings_file_name <- paste(outputname,"/",outputname,"_loadings.txt", sep="")
pca_matrix_file_name <- paste(outputname,"/",outputname,"_pca_matrix_plot.png", sep="")
pca_plot_file_name <- paste(outputname,"/",outputname,"_PC1vPC2_plot.png", sep="")
pca_plot_title <- paste(outputname, ": PC1 vs PC2", sep="")

#Select the kind of P-value adjustment if any as well as the threshold
#assign to pcrit:
#"PValue" for un-adjusted p-values,
#"PBH" for Benjamini-Hochberg corrected p-values, or
#"PBonf" for Bonferroni corrected p-values
pcrit <- "PBonf"
#assign a threshold for your P-value or adjusted P-value
pthresh <- 0.05

#Reads from a tab-delimited file of normalized gene counts
counts <- read.delim(counts_file, row.names="Symbol", stringsAsFactor=FALSE)

#Transposes rows and columns, which is necessary for future manipulations
transpose.counts <- as.data.frame(t(counts))

#Reads from a file that contains the groups names in the desired order
group_list <- readLines(group_file)

#Selects only the groups you included in your group_list file
counts.selected <- subset(transpose.counts, transpose.counts$Group %in% group_list)

#Orders the groups based on the order in your group_list file
counts.selected$Group <- factor(counts.selected$Group, group_list, ordered=TRUE)
counts.selected <- counts.selected[with(counts.selected, order(counts.selected$Group)),]

counts.anova <- as.data.frame(t(counts.selected))
counts.groups <- as.character(lapply(counts.selected$Group, as.character))

#Performs edgeR's ANOVA-like test for differences and returns a file
#that includes p-values, and BH-and Bonferroni-adjusted p-values
z <- as.data.frame(counts.anova[-1,])
z <- as.data.frame(lapply(z, as.numeric))
rownames(z) <- rownames(counts.anova[-1,])
y <- DGEList(counts=z,group=counts.groups)
design <- model.matrix(~group,data=y$samples)
y <- estimateGLMCommonDisp(y,design)
y <- estimateGLMTrendedDisp(y,design)
y <- estimateGLMTagwiseDisp(y,design)
fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2:length(unique(counts.groups)))
anovares <- lrt$table
pvector <- lrt$table$PValue
PBH <- p.adjust(pvector, "BH")
PBonf <- p.adjust(pvector, "bonferroni")
anovares <- cbind(anovares, PBH, PBonf)
write.table(anovares, file=anova_file, sep = "\t")
if (pcrit == "PValue"){
  select.anovares <- anovares[anovares$PValue<pthresh,]
} else if (pcrit == "PBH"){
  select.anovares <- anovares[anovares$PBH<pthresh,]
} else if (pcrit == "PBonf"){
  select.anovares <- anovares[anovares$PBonf<pthresh,]
}

counts.sig <- rbind(counts.anova[1,], counts.anova[row.names(select.anovares),])
#write.table(data.frame(lapply(counts.sig, as.character), stringsAsFactors=FALSE, row.names = row.names(counts.sig)), file=paste(outputname, "/", outputname, "_selected_sig_counts_table.txt", sep=""), sep="\t")

transpose.counts.sig <- as.data.frame(t(counts.sig))

