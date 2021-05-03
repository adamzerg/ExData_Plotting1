#set working directory
setwd(
    "Your WD"
)

#import the file
epc <-
    read.delim("household_power_consumption.txt",
               header = TRUE,
               sep = ";")

#cleaning data
library(lubridate)
epc$Date <- dmy(epc$Date)

#subset dates to dates that is required
epcsubset <-
    subset(epc, epc$Date == "2007-02-01" | epc$Date == "2007-02-02")

#creating date time column
epcsubset$DateTime <-
    as_datetime(paste(epcsubset$Date, epcsubset$Time))

#change columns to numeric
epcsubset$Global_active_power <-
    as.numeric(epcsubset$Global_active_power)
epcsubset$Global_reactive_power <-
    as.numeric(epcsubset$Global_reactive_power)
epcsubset$Voltage <- as.numeric(epcsubset$Voltage)
epcsubset$Global_intensity <- as.numeric(epcsubset$Global_intensity)
epcsubset$Sub_metering_1 <- as.numeric(epcsubset$Sub_metering_1)
epcsubset$Sub_metering_2 <- as.numeric(epcsubset$Sub_metering_2)

# #set up plotting are with 2 rows and 2 columns
# par(mfrow = c(2, 2))

#plotting data
png("plot4.png")

#set up plotting are with 2 rows and 2 columns
par(mfrow = c(2, 2))

#top left graph----
plot(
    epcsubset$DateTime,
    epcsubset$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power"
)
#top right graph----
plot(
    epcsubset$DateTime,
    epcsubset$Voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
)
#bottom left graph----
plot(
    epcsubset$DateTime,
    epcsubset$Sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy sub metering"
)
lines(
    epcsubset$DateTime,
    epcsubset$Sub_metering_2,
    xlab = "",
    ylab = "Energy sub metering",
    col = "red"
)
lines(
    epcsubset$DateTime,
    epcsubset$Sub_metering_3,
    xlab = "",
    ylab = "Energy sub metering",
    col = "blue"
)
legend(
    "topright",
    bty = "n",
    lty = 1,
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
#bottom right graph----
plot(
    epcsubset$DateTime,
    epcsubset$Global_reactive_power,
    type = "l",
    xlab = "datetime",
    ylab = "Globa_reactive_power"
)

dev.off()