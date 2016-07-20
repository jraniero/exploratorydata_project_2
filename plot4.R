## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Create Subset of SCC only with Coal
SCC_Coal<-SCC[grep("coal",SCC$Short.Name,ignore.case=TRUE,value=FALSE),]

#Subset NEI to coal related sources of Emissions
NEI<-subset(NEI,NEI$SCC %in% SCC_Coal$SCC)

#Calculate aggregate per year

per_year<-with(NEI,tapply(Emissions,year,sum))
png("plot4.png",height=480,width=480)
plot(names(per_year),per_year,
     main="Emissions per year related to Coal",
     xlab="Year",
     ylab="Emissions",
     xlim=range(1999,2008),
     type="n")

#Plot line to show evolution of Emissions per year
lines(names(per_year),per_year,type="b",col=3)
dev.off()