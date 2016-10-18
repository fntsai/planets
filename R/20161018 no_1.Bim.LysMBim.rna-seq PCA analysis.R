#install.packages("ggplot2")
#install.packages("Cairo")
#source("https://bioconductor.org/biocLite.R")
#biocLite("geneplotter")
#biocLite("edgeR")
library("Cairo")
library("edgeR")
library("ggplot2")
library("RColorBrewer")

#setwd("~/Desktop/R/Macrophages/")
setwd("/Users/FuNien/Documents/2016_RNA-seq/comparisons/20161015/Bim.LysMBim/no_1")

####Set variables for your script###

#Assigns the name of a file that contain your counts
#Should be organized as a tab-delimited file with your experimental conditions as columns and your genes as rows
#The second row should contain your group names
counts_file <- "no_1.trimmed.Bim.LysMBim.macs.txt"

#Assigns the name of a file that contains your groups in the desired order
group_file <- "Bim.LysMBim.macs.txt"

#Assign a name according to which your output folder and files will be names
outputname <- "no_1.PCA.Bim.LysMBim"

#Creates the names for your output folder and files based on your outputname variable
if (file.exists(outputname)==F){
  dir.create(file.path(outputname))
}
logcounts_file_name <- paste(outputname, "/", outputname,"_log_counts.txt", sep="")
variance_summary_file <- paste(outputname,"/",outputname,"_var.txt", sep="")
scree_plot_file_name <- paste(outputname,"/",outputname,"_scree_plot.png", sep="")
scree_plot_name <- paste("Scree plot for ", outputname, sep="")
loadings_file_name <- paste(outputname,"/",outputname,"_loadings.txt", sep="")
pca_matrix_file_name <- paste(outputname,"/",outputname,"_pca_matrix_plot.png", sep="")
pca_plot_file_name <- paste(outputname,"/",outputname,"_PC1vPC2_plot.pdf", sep="")
pca_plot_title <- paste(outputname, ": PC1 vs PC2", sep="")
pca_plot_file_name_2 <- paste(outputname,"/",outputname,"_PC3vPC2_plot.pdf", sep="")
pca_plot_title_2 <- paste(outputname, ": PC3 vs PC2", sep="")

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

#Returns log-counts
log.counts <- counts.selected
log.counts[,-1] <- lapply(log.counts[,-1], function(x) log(as.numeric(x)+1))
write.table(data.frame(lapply(log.counts, as.character), stringsAsFactors=FALSE, row.names = row.names(log.counts)), file=logcounts_file_name, sep="\t")
log.counts$Group <- lapply(log.counts$Group, function(x) toString(x))

#Performs pca on your log-counts table
counts.pca <- prcomp(log.counts[,-1],
                     center = TRUE,
                     scale. = TRUE)

#Outputs summary of PCA
x <- summary(counts.pca)
vars <- x$sdev^2
vars <- vars/sum(vars)
write.table(rbind("Standard deviation" = x$sdev, "Proportion of
                  Variance" = vars,
                  "Cumulative Proportion" = cumsum(vars)), 
            file=variance_summary_file, sep="\t")

#Scree plot
png(scree_plot_file_name)
plot(counts.pca, type="l", main=scree_plot_name)
dev.off()

#Outputs the loadings
write.table(counts.pca$rotation, file=loadings_file_name, sep="\t")

#Plots the results

#Choose a color palette
cols <- colorRampPalette(brewer.pal(12, "Paired"))
#flexiblepal <- cols(length(unique(counts.groups))) #Will generate a palette based on the number of groups you have (may be ugly)

Philcb <- c("#D55E00", "#E69F00","#0072B2","#009E73", "#CC79A7", "#56B4E9","#F0E442","#000000", "#999999")
Phil2 <- c("firebrick3", "chocolate2", "blue4","chartreuse4","grey39","black","saddlebrown","darkgoldenrod1","blueviolet","#D55E00", "#E69F00","#0072B2")
FuNien <- c("#0409B2","#B20005","#096000","#CC7B1F", "#7225A6", "#56B4E9","#F0E442","#000000", "#999999")

myPal <- FuNien  #Assign which palette you want to use here

###Simple plot of two specified principal components###

#set up data for plot
percentVar <- round(100*counts.pca$sdev^2/sum(counts.pca$sdev^2),1)
dfPCA = data.frame(PC1 = counts.pca$x[,1], PC2 = counts.pca$x[,2], PC3 = counts.pca$x[,3], condition = counts.selected$Group)

#dfPCA$PC2 <- dfPCA$PC2*-1


#create plot and output to .png file
CairoPDF(pca_plot_file_name,height=8,width=8, bg = "transparent")
(qplot(PC1, PC2, data = dfPCA, color = condition,
       main = pca_plot_title, size = I(6))
+ labs(x = paste0("PC1, Variance Explained: ", round(percentVar[1],4), "%"),
       y = paste0("PC2, Variance Explained: ", round(percentVar[2],4), "%"))
+ scale_colour_manual(values=myPal)
+ theme(aspect.ratio = 1)
)
dev.off()

#create plot and output to .png file
CairoPDF(pca_plot_file_name_2,height=8,width=8, bg = "white")

(qplot(PC3, PC2, data = dfPCA, color = condition,
       main = pca_plot_title_2, size = I(6))
+ labs(x = paste0("PC3, Variance Explained: ", round(percentVar[3],4), "%"),
       y = paste0("PC2, Variance Explained: ", round(percentVar[2],4), "%"))
+ scale_colour_manual(values=myPal)
+ theme(aspect.ratio = 1)
)
dev.off()

#Matrix plot of specified number of principal components
group.factor <- factor(log.counts$Group, group_list, ordered=TRUE)
png(pca_matrix_file_name, width = 750, height = 700)
par(oma = c(4, 1, 1, 1))
pairs(counts.pca$x[,1:5], pch=19, cex=2, col=myPal[group.factor])
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
#legend("bottom", unique((counts.groups)), xpd = TRUE, horiz = TRUE, 
#       inset = c(0, 0), bty = "n", pch = 19, cex = 1.5, col = myPal[unique(as.factor(counts.groups))])
dev.off()



#----------------------------------------------------------------
#
#pdf("Casp8_C8flx_D14 no Anova.pdf",width=6,height=6)
#(qplot(PC1, PC2, data = dfPCA, color = condition, 
#       main = pca_plot_title, size = I(6))
#+ labs(x = paste0("PC1, Variance Explained: ", round(percentVar[1],4), "%"),
#      y = paste0("PC2, Variance Explained: ", round(percentVar[2],4), "%"))
#+ scale_colour_manual(values=myPal)
#+ theme(aspect.ratio = 1)
#)
#dev.off()