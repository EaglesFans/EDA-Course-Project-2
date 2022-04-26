## EDA Course Project 2 - Peer-Graded Assignment

## Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path(getwd(), "NEI_data.zip")
download.file(fileUrl, f, method = "curl")
unzip(zipfile = "NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

## Load ggplot2 
library(ggplot2)

## Subsetting Baltimore, Maryland, out of the total NEI dataset.
NEI_Baltimore <- subset(NEI, fips == "24510")

## Plot bar charts by source type with ggplot and save them into a png file
png(filename = "EDA Plot 3.png", width = 480, height = 480)
ggplot(NEI_Baltimore, aes(factor(year), Emissions, fill = type)) + geom_bar(stat = "identity") +  ## stat = "identity" brings the actual value
  facet_grid(type~., scales = "free") + labs(x = "Year", y = "Total PM2.5 Emission (Tons)",
                            title = "Total Emissons from 1999 to 2008 by Source Type in Baltimore, MD") 
dev.off()
