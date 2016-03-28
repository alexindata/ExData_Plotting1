## download file, unzip file, locate file
if(!dir.exists("./webData")) {dir.create("./webData")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./webData/ori.zip", method="curl")
unzip("./webData/ori.zip", exdir="./webData")
dir("./webData")

## data download time stamp
Sys.time()
## [1] "2016-03-27

## estimate file size in MB (file contains 2,075,259 rows and 9 columns)
file.size("./webData/household_power_consumption.txt")

## tidy data
library(data.table)
library(lubridate)
pwrData <- fread("./webData/household_power_consumption.txt", na.strings="?")
pwrData$datetime <- paste(pwrData$Date, pwrData$Time, sep=" ")
pwrData$datetime <- dmy_hms(pwrData$datetime)

## subset data according to time period
start <- ymd_hms("2007-02-01 00:00:00")
end <- ymd_hms("2007-02-02 23:59:59")
pwr <- pwrData[(pwrData$datetime >= start & pwrData$datetime <= end), ]

## plot 1 to a png file
quartz()
hist(pwr$Global_active_power, xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", col="red", main="Global Active Power")
mtext(side=3, line=-1, text="Plot 1", font=2, adj=0, outer=TRUE) 
dev.copy(png, "./ExData_Plotting1/plot1.png", width = 480, height = 480,
         units = "px")
dev.off()
