## This first line will likely take a few seconds. Be patient!
## Not completed!
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

df<-data.frame(Year=numeric(),City=character(),Emissions=numeric())
df<-rbind(df,data.frame...)
png("plot6.png",height=480,width=480)
plot(names(per_year),per_year,
     main="Emissions per year for motor vehicle",
     xlab="Year",
     ylab="Emissions",
     
     #Set range to maximum of Baltimore and LA
     ylim=range(max(per_year,per_year_LA),min(per_year,per_year_LA)),
     type="n")

#Plot lines for Baltimore
lines(names(per_year),per_year,col=1,type="b")

#Plot lines for LA
lines(names(per_year_LA),per_year_LA,col=2,type="b")
legend("top",legend=c("Baltimore","Los Angeles"),lty=1,col=c(1,2),ncol=2)
dev.off()