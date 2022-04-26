## EDA Course Project 2 - Peer-Graded Assignment

## Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path(getwd(), "NEI_data.zip")
download.file(fileUrl, f, method = "curl")
unzip(zipfile = "NEI_data.zip")

## Load the two files in the zip file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

## Split the data by year
split_by_year <- split(NEI, NEI$year)

## Calcuate the total emissions per each year
sum_by_year <- sapply(split_by_year, function(x){
  sum(x[, "Emissions"]/10^6)
  }
)

## Draw a plot and save it in PNG file
png(filename = "EDA Plot 1.png", width = 480, height = 480)
barplot(sum_by_year, xlab = "Year", ylab = "Total PM2.5 emission from all sources (10^6 Tons)", main = "Emissons over the Years", 
        col = "blue")
dev.off()
