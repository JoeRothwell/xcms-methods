#XCMS processing of Q Exactive samples
setwd("D:/SIGExposome")
#list files in directory
xmlfiles <- list.files(recursive = TRUE, full.names = TRUE)

#extract peaks. Method found at
#http://metabolomics-forum.com/viewtopic.php?f=8&t=875&p=2621&hilit=Q+exactive+xcmsset&sid=4a2988ae4e1b3ee3b925314dd9d18077#p2621

library(xcms)
rawpeaks <- xcmsSet(xmlfiles, ppm=1, method="centWave", # from Patti et al., 2012
  peakwidth =c(5,15), # max lowered from Patti et al., 2012,
  #visual inspection of sample data in Excalibur
  fitgauss = TRUE, noise = 5000, verbose.columns = TRUE, snthresh = 10, integrate = 1,
  prefilter = c(3,10000), nSlaves=8 #3,5000k possibly too low
  )

#group peaks with arguments changed from Patti et al 2012 paper: (default method is density)
xset <- group(rawpeaks, bw = 2, minfrac = 0.5, mzwid = 0.015)

#retention time correction
xset1 <- retcor(xset, method="obiwarp", plottype = c("deviation"))
#regroup data
xset2 <- group(xset1, bw = 2, minfrac = 0.5, mzwid = 0.015)
#fill in with original data where peaks were not detected initially
xset3 <- fillPeaks(xset2)
dr <- diffreport(xset3, filebase="Others_vs_Samples", eicmax=10, mzdec=5)

library(CAMERA)
#create an xsAnnotate object
xsa <- xsAnnotate(xset3)
#group based on RT
xsaF <- groupFWHM(xsa, perfwhm=0.6)
#verify grouping
xsaC <- groupCorr(xsaF)
#Annotate isotopes, could be done before groupCorr
xsaFI <- findIsotopes(xsaC)
#Annotate adducts
xsaFA <- findAdducts(xsaFI, polarity="positive")

#Get final peak table and write to file
write.csv(getPeaklist(xsaFA), file="SIGMAExposome_CAMERA.csv")

#plot EICs for pseudospectrum 2
plotEICs(xsaFA, pspec=2, maxlabel=5)

#--------------------------------------------------------------------------------------------------

#test on faahKO dataset, 
#find raw data files in faahKO package (to move to working directory?)
cdfpath <- file.path(find.package("faahKO"), "cdf")
list.files(cdfpath, recursive=T)

#load the files and find peaks
xset <- xcmsSet(cdfpath)
xset #check loaded data

#group peaks
xset2 <- group(xset)

#retention time correction (calculate retention time deviations for all samples)
xset3 <- retcor(xset2, family="s", plottype="m")

#regroup data
xset3 <- group(xset3, bw=10)

#fill in with original data where peaks were not detected initially
xset4 <- fillPeaks(xset3)
#get peak table and 10 EICs
reporttab <- diffreport(xset4, "WT", "KO", "example", 10, metlin=0.15)
