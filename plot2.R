# Exploratory Data Analysis  course - Project 1
# Plot2.R
# 
# David Contreras Carretero
library(sqldf)
Sys.setlocale("LC_ALL","English")

pngfile ="plot2.png"

#Download and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data.zip"
download.file(fileUrl,zipfile)
unzip(zipfile)

#Read pertinent data
txtfile <- "./household_power_consumption.txt"
hhpc <- read.csv.sql(txtfile,sql= "select Date, Time, Global_active_power from file where Date='1/2/2007' or Date='2/2/2007'", sep=";")
closeAllConnections()

#get date ant time of measurment together
dateTime <- strptime(paste(hhpc$Date , hhpc$Time, sep=""),"%d/%m/%Y %H:%M:%S")

#set device to png file
png(pngfile, width=480, height=480, units="px")

#plot as type line
plot(dateTime,hhpc$Global_active_power, type="l", ylab ="Global Active Power(kilowatts)", xlab="")

#close device
dev.off()

#clean up
rm(fileUrl, hhpc,pngfile,txtfile,zipfile, dateTime )
gc()

