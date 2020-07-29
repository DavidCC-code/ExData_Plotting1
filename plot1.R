# Exploratory Data Analysis  course - Project 1
# Plot1.R
# 
# David Contreras Carretero
library(sqldf)

pngfile ="plot1.png"

#Download and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data.zip"
download.file(fileUrl,zipfile)
unzip(zipfile)

#Read pertinent data
txtfile <- "./household_power_consumption.txt"
hhpc <- read.csv.sql(txtfile,sql= "select Global_active_power from file where Date='1/2/2007' or Date='2/2/2007'", sep=";")
closeAllConnections()

#set device to png file
png(pngfile, width=480, height=480, units="px")

#plot histogram
hist(hhpc$Global_active_power, col="red", xlab ="Global Active Power(kilowatts)", main="Global Active Power")


#close device
dev.off()

#clean up
rm(fileUrl, hhpc,pngfile,txtfile,zipfile)
gc()

