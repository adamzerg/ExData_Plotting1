
install.packages("data.table")
library("data.table")
#Plot 4
data1 = fread(file = "Household_Power_Consumption.txt", na.strings = "?")
Housedata <-subset(data1, data1$Date %in% c("1/2/2007", "2/2/2007"))
xdate <-strptime(Housedata$Date, "%d/%m/%Y")
#Format date for axis and plotting
datetime <-as.POSIXct(paste(as.Date(xdate), Housedata$Time))
#Format variables for plotting
Voltage <-as.numeric(Housedata$Voltage)
GAP <-as.numeric(Housedata$Global_active_power)
GRP <-as.numeric(Housedata$Global_reactive_power)
Sub_metering_1 <- as.numeric(Housedata$Sub_metering_1)
Sub_metering_2 <- as.numeric(Housedata$Sub_metering_2)
Sub_metering_3 <- as.numeric(Housedata$Sub_metering_3)
#Set up screen device
png("plot4.png", width = 480, height = 480)
#Set up 2 by 2 matrix for plots
par(mfrow = c(2, 2))
#Plot Top Left
plot(datetime,GAP, type = "l", xlab = "", ylab = "Global Active Power")
#Plot Top Right
plot(datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#Plot Bottom Left
plot(datetime, Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(datetime,Sub_metering_2, type = "l", col = "red")
lines(datetime,Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), bty = "n", lty = 1,
       lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Plot Bottom Right
plot(datetime,GRP, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()