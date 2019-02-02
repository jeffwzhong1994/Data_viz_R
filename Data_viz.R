#hw6, Wenlue Zhong, 3/4/17
dataset <- read.table(file.choose(),header=TRUE, sep=",",colClasses = c('character','numeric','numeric','numeric','numeric'))
fips_countyname <- read.fwf(file= url("http://www.cse.lehigh.edu/%7Ebrian/census/FIPS_CountyName.txt"), widths=c(5,50), colClasses = c('character'))
colnames(fips_countyname) <- c("fips", "countyname")
fips_countyname1 <- read.csv(text = as.character(fips_countyname$county), na.strings=c("", "NA"), header = FALSE)
colnames(fips_countyname1) <- c("countyname", "State")
fips_countyname1["fips"] <- NA
fips_countyname1$fips <- fips_countyname$fips
newdataset <- merge(dataset, fips_countyname1, by = "fips", all = TRUE, incomparables =NULL)
keep <- c("fips","PST045213","EDU685212","countyname","State")
newdataset1 <- newdataset[keep]
newdataset1[complete.cases(newdataset1),]
install.packages("ggplot2")
library(ggplot2)
newdataset1$PST045213 <- newdataset1$PST045213/10000000
P <- qplot(data=newdataset1, y=EDU685212, x=PST045213, facets=~State)+ geom_smooth(method="lm", se= FALSE)
P

