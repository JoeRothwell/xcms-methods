#XCMS processing of Pekka's fibre data
#first converted to NetCDF with ProteoWizard
#some XCMS settings found at
#http://eln.iarc.fr/edmandsw/2014-02-19/metmsline-step-by-step-guide-general-instructions/

#ppm=10, snthresh=10, CPWmin=2, CPWmax=20, bw=2, minfrac=0.5, mzwid=0.015, eicmax=150000, 
#eicwidth=60, method="centWave"(xcmsSet), method="obiwarp”(retcor)

library(xcms)
setwd("D:/Pekka fibre")
#list files in directory 
xmlfiles <- list.files(recursive=TRUE, full.names=TRUE)
#extract peaks
rawpeaks <- xcmsSet(xmlfiles, ppm=10, method="centWave", peakwidth = c(5,15), fitgauss = TRUE,
      noise = 5000, verbose.columns = TRUE, snthresh = 10, integrate = 1, nSlaves=2)

#group peaks
xset <- group(rawpeaks, bw=2, minfrac=0.5, mzwid=0.025)
#retention time correction
xset1 <- retcor(xset, method="obiwarp", plottype = c("deviation"))
#regroup data
xset2 <- group(xset1, bw = 2, minfrac = 0.5, mzwid = 0.025)
#fill in with original data where peaks were not detected initially
xset3 <- fillPeaks(xset2)
dr <- diffreport(xset3, filebase="Group1_vs_Group2", eicmax=100, mzdec=3)

library(CAMERA)
#create an xsAnnotate object
xsa <- xsAnnotate(xset3)
#group based on RT
xsaF <- groupFWHM(xsa, perfwhm=0.6)
#verify grouping
xsaC <- groupCorr(xsaF)
#Annotate isotopes, could be done before groupCorr
xsaFI <- findIsotopes(xsaC)
xsaFI2 <- findIsotopes(xsaC, isotopeMatrix=mat, filter=F)  #Using some custom isotope matrices
xsaFI3 <- findIsotopes(xsaC, isotopeMatrix=mat2, filter=F)
xsaFI4 <- findIsotopes(xsaC, isotopeMatrix=mat3, filter=F)
#Annotate adducts
xsaFA <- findAdducts(xsaFI, polarity="positive")

#Get final peak table and write to file
write.csv(getPeaklist(xsaFI3), file="result_CAMERA_Agneta1.csv")

#plot EICs for pseudospectrum 2
plotEICs(xsaFA, pspec=2, maxlabel=5)

#subset intensity data, replace 0s with 1s, transpose, log, remove sd=0
ints <- t(dr[, 14:ncol(dr)])
ints[ints==0] <- 1
logints <- log2(ints)
filter <- logints[, apply(logints, 2, sd) != 0]
colnames(filter) <- dr$name
write.csv(filter, "Intensity data fibre study colnames.csv")

#apply pareto scaling and do pca
library(MetabolAnalyze)
library(car)
scaling(filter, type="pareto")
pca <- prcomp(filter, scale.=F)
scatter3d(pca$x[, 1], pca$x[, 2], pca$x[, 3], surface=F, id.n=rownames(pca$x))
plot(pca$x[, 1], pca$x[, 2], pch=19, col=2)
