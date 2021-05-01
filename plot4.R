# install.packages("dplyr")

library(dplyr)
library(datasets)

## 1. Download source data

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
              , 'household_power_consumption.zip'
              , method='curl' )

unzip("household_power_consumption.zip", files = NULL, exdir=".")
getwd()
dir()

## 2. Load Data

power_consumption <- read.table(header = TRUE,sep = ";","household_power_consumption.txt")

## 3. Explore data set

nrow(power_consumption)
head(power_consumption)
# View(power_consumption)

## 4. Format data type

power_consumption <- read.table(header = TRUE,sep = ";","household_power_consumption.txt")
power_consumption$Date <- as.Date(power_consumption$Date,"%d/%m/%Y")
dt <- filter(power_consumption, Date >= '2007-02-01' & Date <= '2007-02-02')
dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))
dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))
dt$Voltage <- as.numeric(as.character(dt$Voltage))
dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))
dt$DateTime <- strptime(paste(dt$Date,dt$Time), format="%Y-%m-%d %H:%M:%S")


## 5. Plotting

png(file="plot4.png")
par(mfrow=c(2,2))
plot(dt$DateTime, type="l", dt$Global_active_power, xlab = NA, ylab="Global Active Power")
plot(dt$DateTime, type="l", dt$Voltage, xlab = "datetime", ylab="Voltage")
plot(dt$DateTime, dt$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
lines(dt$DateTime, dt$Sub_metering_2, col = "red")
lines(dt$DateTime, dt$Sub_metering_3, col = "blue")
legend("topright",cex=0.8,lwd=c(1,1,1),bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(dt$DateTime, type="l", dt$Global_reactive_power, xlab = "datetime")
dev.off()