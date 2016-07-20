## read in the raw data
##By by Neal Hayden
NEI <- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")




## sum the emissions by year for Baltimore City (24510)
NEI <- NEI[(NEI$fips=="24510"), ]
totalEmissions <- aggregate(NEI$Emissions, by=list(Year=NEI$year, type=NEI$type), FUN=sum, na.rm=TRUE)

##create the line plots facets for each type and save it as plot3.png
png("plot3_ex.png", width = 480, height = 480)
ggplot(totalEmissions, aes(x=Year, y=x, color=type))+geom_line()+geom_point() + facet_grid(type~.) + 
  theme_bw()+ labs(y="Total Emissions (tons)", title = expression("Baltimore City PM"[2.5]))

dev.off()