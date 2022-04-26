## EDA Course Project 2 - Peer-Graded Assignment

## Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path(getwd(), "NEI_data.zip")
download.file(fileUrl, f, method = "curl")
unzip(zipfile = "NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
## in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

## Load ggplot2 
library(ggplot2)

## Filtering "mobile vehicle sources" out of SCC dataset
mobile_vehicle <- grep("Vehicle", SCC$SCC.Level.Two)
mobile_vehicle_df <- data.frame(SCC$SCC.Level.Two[mobile_vehicle])
names(mobile_vehicle_df) <- c("SCC.Level.Two")

## Subsetting "mobile vehicle sources" out of SCC datadset
mobile_vehicles_sources <- subset(SCC, SCC.Level.Two %in% mobile_vehicle_df$SCC.Level.Two)

## Filtering "mobile vehicle sources" in Baltimore and one in LA out of NEI dataset with SCC in "mobile_vehicle_sources" 
mo_ve_Bal_LA <- subset(NEI, fips == "24510" & SCC %in% mobile_vehicles_sources$SCC | 
                         fips == "06037" & SCC %in% mobile_vehicles_sources$SCC)

## Change the zip codes with the city name
mo_ve_Bal_LA[mo_ve_Bal_LA == "24510"] <- "Baltimore"
mo_ve_Bal_LA[mo_ve_Bal_LA == "06037"] <- "Los Angeles"
names(mo_ve_Bal_LA)[names(mo_ve_Bal_LA) == "fips"] <- "City"

## Plot graphs by cities with ggplot and save them into a png file
png(filename = "EDA Plot 6.png", width = 512, height = 512)
ggplot(mo_ve_Bal_LA, aes(factor(year), Emissions, fill = City)) + 
  facet_grid(City~., scales = "free") + geom_bar(stat = "identity") +
  labs(x = "Year", y = " Total PM2.5 Emission (Tons)", title = "PM2.5 Motor Vehicle Source Emissions in Baltimore and in LA from 1999–2008")
dev.off()
