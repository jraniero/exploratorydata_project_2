## This first line will likely take a few seconds. Be patient!
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset to Baltimore
NEI<-subset(NEI,fips=="24510")

#Calculate Emissions aggregated sum over year and type dimensions
per_year_type<-with(NEI,tapply(Emissions,list(year,type),sum,simplify=FALSE))

#Tapply yields a matrix, we will flatten it to a data frame, it is easier for ggplot
df<-data.frame(Year=integer(),Type=character(),Emissions=numeric())
for(i in colnames(per_year_type))
{
  for(j in rownames(per_year_type))
  {
    df<-rbind(df,data.frame(Year=j,Type=i,Emissions=as.numeric(per_year_type[j,i])))
  }
}

#Plot the Emissions per year and Type, add connecting line per Type
png("plot3.png")
print(qplot(Year,Emissions,data=df,color=Type)+geom_line(aes(group=Type))+ggtitle("Emissions per Type and Year in Baltimore"))
dev.off()