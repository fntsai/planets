#go to file from your folder
setwd("/Users/FuNien/Documents/2016_RNA_seq/20170415_POP3/Naive/heatmap")
#read table
table.name <- read.csv(file="histogram.txt", header = T, sep = "")

#limit the table to only show values > 1
cut.off <- 1.0
table.col <- (table.name$M03.ColonMP.Naive.WT.03)
table.col.2 <- table.col[table.col > cut.off]



#count the frequency of interval of gene expression
for (i in 0:18)
{
  
  str1 <- "range ("
  str2 <- ", "
  str3 <- ") with size = "
  
  val1 <- i
  val2 <- i + 0.5
  val3 <- length(subset(table.col, table.col >= i & table.col < i + 0.5))
  
  big.str <- paste(str1, val1, str2, val2, str3, val3)
  
  message(big.str)
}


#plot hitogram using "hist"
hist(table.col.2, 
     freq = NULL, 
     breaks = c(seq(0, 18, by = 0.5)),
     xlim = c(0, 18),
     labels = T, axes = F)
axis (2)
axis (1, at=seq(0,18,1))


#plot hitogram using "ggplot2"
library(ggplot2)
#ggplot(table.name, aes(table.name$MP.WT)) 
p <- qplot(table.col.2)
p + scale_x_continuous(name ="gene expression", 
                     breaks=seq(0,18,1))




table.name.2 <- cbind(table.name, table.name)
colnames(table.name.2) <- c("COL1", "COL2")
head(table.name.2)
table.name.2$COL1 == table.name.2[1:nrow(table.name.2), "COL1"] == table.name.2[, 1]






