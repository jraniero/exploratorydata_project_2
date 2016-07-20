## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create subset of SCC for road related sources
SCC_OnRoad<-SCC[SCC$Data.Category=="Onroad",]

#Subset NEI only to Emissions in Baltimore related to road sources
NEI<-subset(NEI,fips=="24510" & NEI$SCC %in% SCC_OnRoad$SCC)

#Calculate aggregate per year
per_year<-with(NEI,tapply(Emissions,year,sum))
png("plot5.png",height=480,width=480)
plot(names(per_year),per_year,
     main="Emissions per year in Baltimore for motor vehicle",
     xlab="Year",
     ylab="Emissions",
     xlim=range(1999,2008),
     type="n")

#Add line to show evolution
lines(names(per_year),per_year,type="b")
dev.off()