# Exploratory Data Analysis  course - Project 1
# Plot3.R
# 
# David Contreras Carretero
library(sqldf)

pngfile ="plot3.png"

#Download and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data.zip"
download.file(fileUrl,zipfile)
unzip(zipfile)

#Read pertinent data
txtfile <- "./household_power_consumption.txt"
hhpc <- read.csv.sql(txtfile,sql= "select Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3 from file where Date='1/2/2007' or Date='2/2/2007'", sep=";")
closeAllConnections()

#get date ant time of measurment together
dateTime <- strptime(paste(hhpc$Date , hhpc$Time, sep=""),"%d/%m/%Y %H:%M:%S")
submeterings <- hhpc[,grep("Sub_", names(hhpc))]
rm(hhpc)
#set device to png file
png(pngfile, width=480, height=480, units="px")

#plot 3 submettering variables as lines by date time
colrs <- c("black","red","blue")
plot(dateTime,submeterings$Sub_metering_1, type="l", ylab ="Energy sub metering", xlab="", col=colrs[1])
lines(dateTime,submeterings$Sub_metering_2, type="l", col=colrs[2])
lines(dateTime, submeterings$Sub_metering_3, type="l", col=colrs[3])
legend("topright", legend=names(submeterings), col=colrs, lty=1)


#close device
dev.off()

#clean up
rm(fileUrl,colrs,submeterings,pngfile,txtfile,zipfile,dateTime)
gc()

