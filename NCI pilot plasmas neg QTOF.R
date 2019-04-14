#test on HILIC neg dataset from 11/11/2014

#http://eln.iarc.fr/edmandsw/2014-02-19/metmsline-step-by-step-guide-general-instructions/

#ppm=10, snthresh=10, CPWmin=2, CPWmax=20, bw=2, minfrac=0.5, mzwid=0.015, eicmax=150000, 
#eicwidth=60, method="centWave"(xcmsSet), method="obiwarp”(retcor)

library(xcms)
setwd("D:/HILIC neg dataset converted")
#list files in directory 
xmlfiles <- list.files(recursive=TRUE, full.names=TRUE)
#extract peaks
rawpeaks <- xcmsSet(xmlfiles, ppm=10, method="centWave", peakwidth = c(5,15), fitgauss = TRUE,
  noise = 3000, verbose.columns = TRUE, snthresh = 10, integrate = 1, nSlaves=2)

#group peaks
xset <- group(rawpeaks, bw=2, minfrac=0.5, mzwid=0.025)
#retention time correction
xset1 <- retcor(xset, method="obiwarp", plottype = c("deviation"))
#regroup data
xset2 <- group(xset1, bw = 2, minfrac = 0.5, mzwid = 0.025)
#fill in with original data where peaks were not detected initially
xset3 <- fillPeaks(xset2)
dr <- diffreport(xset3, filebase="firstrep_vs_secondrep", eicmax=100, mzdec=5)

#PCA of replicates
library(dplyr)
ints <- t(dr[, 14:ncol(dr)])
ints[ints==0] <- 1
logints <- log2(ints)
filter <- logints[, apply(logints, 2, sd) != 0]

#apply pareto scaling and do pca
library(MetabolAnalyze)
scaling(filter, type="pareto")
pca <- prcomp(filter, scale.=F)
plot(pca$x[, 1], pca$x[, 2], pch=19, col=2)
