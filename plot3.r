## download file, unzip file, locate file
if(!dir.exists("./webData")) {dir.create("./webData")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./webData/ori.zip", method="curl")
unzip("./webData/ori.zip", exdir="./webData")
dir("./webData")

## data download time stamp
Sys.time()

## estimate file size in MB (file contains 2,075,259 rows and 9 columns)
file.size("./webData/household_power_consumption.txt")

## tidy data
library(data.table)
library(lubridate)
pwrData <- fread("./webData/household_power_consumption.txt", na.strings="?")
pwrData$datetime <- paste(pwrData$Date, pwrData$Time, sep=" ")
pwrData$datetime <- dmy_hms(pwrData$datetime)

## subset data according to time period
start <- ymd_hms("2007-02-01 00:00:00") ## works
end <- ymd_hms("2007-02-02 23:59:59") ## works
pwr <- pwrData[(pwrData$datetime >= start & pwrData$datetime <= end), ]

## plot 3
quartz()
with(pwr, plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", 
               type="n"))
points(pwr$datetime, pwr$Sub_metering_1, type="l", col="Black")
points(pwr$datetime, pwr$Sub_metering_2, type="l", col="Red")
points(pwr$datetime, pwr$Sub_metering_3, type="l", col="Blue")
mtext(side=3, line=-1, text="Plot 3", font=2, adj=0, outer=TRUE)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       pch="-", pt.cex=3, col=c("Black", "Red", "Blue"))
dev.copy(png, "./ExData_Plotting1/plot3.png", width = 480, height = 480,
         units = "px")
dev.off()
