## EDA Course Project 2 - Peer-Graded Assignment

## Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path(getwd(), "NEI_data.zip")
download.file(fileUrl, f, method = "curl")
unzip(zipfile = "NEI_data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510" ) from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

## Subsetting Baltimore, Maryland, out of the total NEI dataset.
NEI_Baltimore <- subset(NEI, fips == "24510")

## Calculating the total emissioin values per each year
split_by_year <- split(NEI_Baltimore, NEI_Baltimore$year)
sum_by_year <- sapply(split_by_year, function(x){
  sum(x[, "Emissions"])
  }
)

## Plot a bar chart and save the chart into a png file.
png(filename = "EDA Plot 2.png", width = 480, height = 480)
barplot(sum_by_year, ylim = c(0, 3500), xlab = "Year", ylab = "Total PM2.5 emission from all sources (Tons)", 
        main = "Emissons over the Years in Baltimore, MD", col = "BLUE")
dev.off()
