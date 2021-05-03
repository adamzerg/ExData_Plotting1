### The purpose of this code file is to create 4 charts in one plot
### (and saved as a PNG) of data from 2007-02-01 and 2007-02-02
### from file: household_power_consumption.txt
install.packages("lubridate")
# Load the needed packages
library(lubridate)
library(datasets)

# Read the data (from the working directory)
power <- data.table::fread(input = "household_power_consumption.txt",
                           na.strings = "?")

# Change the date format from dd/mm/yyyy to yyyy-mm-dd 
power$Date <- parse_date_time(power$Date, c('dmy', 'ymd'))

# Subset 'power' to just input from 2007-02-01 and 2007-02-02 (Happy Groundhog's Day!)
power_feb07 <- power[(Date >= "2007-01-31") & (Date <= "2007-02-02")]

# Create a new column in 'power_feb07' that is the combined date and time
datetime <- paste(as.Date(power_feb07$Date), power_feb07$Time)
power_feb07$Datetime <- as.POSIXct(datetime)

# Create a 4 charts of data versus time and save as a PNG
dev.copy(png, "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,2))
with(power_feb07, {
    plot(Global_active_power~Datetime, ### the upper left plot
         ylab = "Global Active Power", xlab = "",
         type = "l")
    plot(Voltage~Datetime, ### the upper right plot
         ylab = "Voltage", xlab = "datetime",
         type = "l")
    plot(Sub_metering_1~Datetime, ### the lower left plot
         ylab = "Energy sub metering", xlab = "", type = "l")
    lines(Sub_metering_2~Datetime,
          col = 'Red')
    lines(Sub_metering_3~Datetime,
          col = 'Blue')
    legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 2,
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, ### the lower right plot
         ylab = "Global_reactive_power", xlab = "datetime", type = "l")
})
dev.off()