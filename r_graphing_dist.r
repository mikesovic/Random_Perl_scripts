setwd("C:/Users/fries/Desktop/perl_scripts")

data<-read.table('r_patgeo_dist.txt', sep="\t", header=T)

 jitpat<-jitter(data$patristic, amount=0.05)
 jitdist<-jitter(data$distance, amount=50)
 plot(jitdist, jitpat)
 pdf('np_pat_v_geo_allOSU.pdf')
 plot(jitdist, jitpat)
 dev.off()