## EDA Course Project 2 - Peer-Graded Assignment

## Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path(getwd(), "NEI_data.zip")
download.file(fileUrl, f, method = "curl")
unzip(zipfile = "NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## Load ggplot2 
library(ggplot2)

## Subsetting Baltimore, Maryland, out of the total NEI dataset.
NEI_Baltimore <- subset(NEI, fips == "24510")

## Filtering "mobile vehicle sources" in "SCC.Level.Two" out of SCC dataset
mobile_vehicle <- grep("Vehicle", SCC$SCC.Level.Two)
mobile_vehicle_df <- data.frame(SCC$SCC.Level.Two[mobile_vehicle])
names(mobile_vehicle_df) <- c("SCC.Level.Two")

## Subsetting "mobile vehicle sources" out of SCC datadset with "mobile_vehicle_df"
mobile_vehicles_sources <- subset(SCC, SCC.Level.Two %in% mobile_vehicle_df$SCC.Level.Two)

## Filtering "mobile vehicle sources" from NEI_Baltimre dataset with SCC in "mobile_vehicles_sources" dataset
mo_ve_bal_dataset <- subset(NEI_Baltimore, SCC %in% mobile_vehicles_sources$SCC)

## Plot a graph with ggplot and save it into a png file
png(filename = "EDA Plot 5.png", width = 512, height = 512)
ggplot(mo_ve_bal_dataset, aes(factor(year), Emissions)) + geom_bar(stat = "identity", fill = "blue") +
  labs(x = "Year", y = "Total PM2.5 Emission (Tons)", title = "PM2.5 Motor vehicle source Emissions in Baltimore, MD from 1999–2008")
dev.off()
