##############################################################################
#This file is set up to take distance matrices from different programs and run mantel and partial.mantel tests in R
#############################################################################


setwd("C:/Users/fries/Desktop/Tony/Influenza Genomics/OSU_Surveillance_Analysis/86-11_MP_Ohio_Analysis")
time<-read.table('86-11_MP_time.txt',sep="\t", header=F)

x<-dist(time, method="maximum")
y<-as.matrix(x)

write.table(y, "dist_matrix.txt", sep="\t")

##############################################################################

time_dist<-read.table('extracted_iso_data_time_calculated_MP.txt', sep="\t", header=TRUE, row.names=1)
geo_dist<-read.table('extracted_iso_data_geo_calculated_MP.txt', sep="\t", header=TRUE, row.names=1)
gene_dist<-read.table('86-11_MP_genetic_dist.txt', sep="\t", header=TRUE, row.names=1)

time_dist<-as.matrix(time_dist)
geo_dist<-as.matrix(geo_dist)
gene_dist<-as.matrix(gene_dist)

