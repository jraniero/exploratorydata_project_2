## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total Emissions per year
per_year<-with(NEI,tapply(Emissions,year,sum))

png("plot1.png",height=480,width=480)

#We divide the data/1000 to have readable axis labels
per_year<-per_year/1000

plot(names(per_year),per_year,
     main="Total emissions per year",
     xlab="Year",
     ylab="Emissions (thousands)",
     type="n")

#Line plot of the Emissions evolution per year
lines(names(per_year),per_year,type="b")
dev.off()