#go to file from your folder
setwd("/Users/FuNien/Documents/2016_RNA_seq/20170415_POP3/M17-24/FDR")
#read table
table.name <- read.table(file="3. noM22.log.trimmed.M17-M24.htseq.normCounts.txt", header = T, sep ="")
View(table.name)

#pvalue calculation
p.values <- vector(mode = "numeric", length = nrow(table.name))



for (i in 1:nrow(table.name))
{
  ttest=t.test(table.name[i,1:4], table.name[i,5:7])
  
  names(ttest)
  p.values[i]<-ttest$p.value
}

table.name$pvalues <-p.values



#qvalue calculation
source("http://bioconductor.org/biocLite.R")
biocLite("qvalue")
library(qvalue)

#q.values <- vector(mode = "numeric", length = nrow(table.name))


#for (i in 1:nrow(table.name))
#{
#  q = qvalue(table.name[i,8:8])
#  q.values[i]<-q
#}

#table.name$qvalues <- q.values
####################################
q <- qvalue(table.name[1:nrow(table.name) ,8])
qobj <- q$qvalues
max(qobj[q$qvalues <= 0.01])
table.name$qvalues <- qq

# BGN TEST
#length(table.name$pvalues)

#data <- table.name$pvalues
#data <- sort(data)
#min(data)

#p.adjust(c(0.01, 0.02, 0.03, 0.4998, 1), "hochberg")

              #, method = p.adjust.methods
               
#, n= nrow(table.name)
              #)

#(table.name$pvalues)

# END TEST

#calculating logFC

WT.mean <- rowMeans(table.name[,1:4])
POP3.mean <- rowMeans(table.name[,5:7])
table.name$WT.mean <- WT.mean
table.name$POP3.mean <- POP3.mean


logFC <- table.name$POP3.mean - table.name$WT.mean
table.name$logFC <- logFC 
#export file
write.csv(table.name, file = "DSSMP.csv")
