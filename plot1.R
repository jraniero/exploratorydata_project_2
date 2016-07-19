## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
per_year<-with(NEI,tapply(Emissions,year,sum))
lines(names(per_year),per_year)
dev.copy(png,"plot1.png")