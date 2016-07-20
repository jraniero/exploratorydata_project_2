## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset to Baltimore
NEI<-subset(NEI,fips=="24510")

#Calculate total per year
per_year<-with(NEI,tapply(Emissions,year,sum))

png("plot2.png",height=480,width=480)
plot(names(per_year),per_year,
     main="Emissions per year in Baltimore",
     xlab="Year",
     ylab="Emissions",
     xlim=range(1999,2008),
     type="n")

#Line plot of Emissions evolution per year
lines(names(per_year),per_year)
dev.off()