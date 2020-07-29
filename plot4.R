# Exploratory Data Analysis  course - Project 1
# Plot4.R
# 
# David Contreras Carretero
library(sqldf)

pngfile ="plot4.png"

#Download and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data.zip"
download.file(fileUrl,zipfile)
unzip(zipfile)

#Read pertinent data
txtfile <- "./household_power_consumption.txt"
hhpc <- read.csv.sql(txtfile,sql= "select Date, Time, Global_active_power, Global_reactive_power, Voltage, 
                      Sub_metering_1, Sub_metering_2, Sub_metering_3  from file
                      where Date='1/2/2007' or Date='2/2/2007'", sep=";")
closeAllConnections()

#get date ant time of measurment together
dateTime <- strptime(paste(hhpc$Date , hhpc$Time, sep=""),"%d/%m/%Y %H:%M:%S")
submeterings <- hhpc[,grep("Sub_", names(hhpc))]


#set device to png file
png(pngfile, width=480, height=480, units="px")

#set the plot lay out
par(mfrow = c(2,2))

#plot as type line Global activ power over time
plot(dateTime,hhpc$Global_active_power, type="l", ylab ="Global Active Power", xlab="")

#plot as type line voltage time
plot(dateTime,hhpc$Voltage, type="l", ylab ="Voltage", xlab="datetime")


#plot 3 submettering variables as lines by date time
colrs <- c("black","red","blue")
plot(dateTime,submeterings$Sub_metering_1, type="l", ylab ="Energy sub metering", xlab="", col=colrs[1])
lines(dateTime,submeterings$Sub_metering_2, type="l", col=colrs[2])
lines(dateTime, submeterings$Sub_metering_3, type="l", col=colrs[3])
legend("topright", legend=names(submeterings), col=colrs, lty=1, bty="n")

#plot as type line global reactive power time
plot(dateTime,hhpc$Global_reactive_power, type="l", ylab ="Global_reactive_power", xlab="datetime")


#close device
dev.off()

#clean up
rm(fileUrl,colrs,hhpc,submeterings,pngfile,txtfile,zipfile,dateTime)
gc()

