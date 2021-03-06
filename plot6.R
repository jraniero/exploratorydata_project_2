## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create subset for Onroad related SCC only

SCC_OnRoad<-SCC[SCC$Data.Category=="Onroad",]

#Create subset of NEI for Baltimore and Onroad Emissions
NEI_Baltimore<-subset(NEI,fips=="24510" & NEI$SCC %in% SCC_OnRoad$SCC)

#Create subset of NEI for LA and Onroad Emissions
NEI_LA<-subset(NEI,fips=="06037" & NEI$SCC %in% SCC_OnRoad$SCC)

#Calculate total per year for Baltimore
per_year<-with(NEI_Baltimore,tapply(Emissions,year,sum))

#Calculate total per year for LA
per_year_LA<-with(NEI_LA,tapply(Emissions,year,sum))

png("plot6.png",height=480,width=960)

#We need to compare the absolute differences between the two files
#We'll create a side by side plot, with different scales to highlight
#which of the two cities has more differences
par(mfrow=c(1,2))


#Plot Baltimore
plot(names(per_year),per_year,
     main="Baltimore",
     xlab="Year",
     ylab="Emissions",
     xlim=range(1999,2008),
     #Set range to maximum of Baltimore and LA
     type="l")

#Plot LA
plot(names(per_year_LA),per_year_LA,
     main="Los Angeles",
     xlab="Year",
     ylab="Emissions",
     xlim=range(1999,2008),
     type="l")

#Add a main title
mtext("Emissions per year for motor vehicle",outer=TRUE)

dev.off()