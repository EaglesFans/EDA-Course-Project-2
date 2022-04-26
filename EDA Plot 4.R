## EDA Course Project 2 - Peer-Graded Assignment

## Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path(getwd(), "NEI_data.zip")
download.file(fileUrl, f, method = "curl")
unzip(zipfile = "NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## Load ggplot2 
library(ggplot2)

## Filter "Coal Combustion-related sources" in SCC EI Sector
fuel_comp_coal <- grep("Coal", SCC$EI.Sector)
fuel_comp_coal_df <- data.frame(SCC$EI.Sector[fuel_comp_coal])
names(fuel_comp_coal_df) <- c("EI.Sector") 

## Subsetting "Coal Combustion-Related Sources" out of SCC dataset
coal_comb_sources <- subset(SCC, EI.Sector %in% fuel_comp_coal_df$EI.Sector)

## Filtering "Coal Combustion-Related Sources" from NEI dataset with SCC in "coal_comb_sources" dataset
coal_comb_dataset <- subset(NEI, SCC %in% coal_comb_sources$SCC)

## Plot a graph with ggplot and save it into a png file
png(filename = "EDA Plot 4.png", width = 512, height = 512)
ggplot(coal_comb_dataset, aes(factor(year), Emissions/10^5)) + geom_bar(stat = "identity", fill = "red") +
  labs(x = "Year", y = "Total PM2.5 Emission (10^5 Tons)", 
       title = "PM2.5 Coal Combustion-related Source Emissions Across US from 1999–2008")
dev.off()
