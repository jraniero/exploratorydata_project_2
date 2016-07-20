## read in the raw data
NEI <- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

## filter the data to just Baltimore City and Los Angeles
NEI <- NEI[NEI$fips=="24510" | NEI$fips == "06037", ]

## recode fips to correspond to the city
NEI$fips[NEI$fips=="24510"] <- "Baltimore City"
NEI$fips[NEI$fips=="06037"] <- "Los Angeles"


## look in  SCC$EI.Sector for the motor vehicle categories
#table(SCC$EI.Sector)

## extract SCC for the motor vehicle categories
mvSCC <- SCC$SCC[SCC$EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - 
                                      
                                      On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - 
                                      
                                      On-Road Gasoline Light Duty Vehicles")]

## Filter NEI for the motor vehicle sources
NEI <- NEI[NEI$SCC %in% mvSCC, ]

## sum the emissions to get motor vehicle totals per year and City
totalEmissions <- aggregate(NEI$Emissions, by=list(Year=NEI$year, City = NEI$fips), FUN=sum, 
                            
                            na.rm=TRUE)

##create the line plot and save it as plot6.png
png("plot6_H.png", width = 480, height = 480)
ggplot(totalEmissions, aes(x=Year, y=x, color=City))+geom_line()+geom_point() + 
  labs(y="Total Emissions (tons)", title = expression("Motor Vehicle PM"[2.5])) + facet_grid(.~City)
dev.off()