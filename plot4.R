
# Creating a Directory for saving the downloaded zip file
dir.create("ExploratoryAssignment1")

# Downloading the zip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "ExploratoryAssignment1/exdata-data-household_power_consumption.zip")
setwd("ExploratoryAssignment1")

# Unziping the file
unzip("exdata-data-household_power_consumption.zip")

# Reading the file
Data.in <- read.table("household_power_consumption.txt", sep = ";", header = T)

# Changing the date and the time column to respective formats and subsetting the Data
Data.in$Date <- as.Date(Data.in$Date, "%d/%m/%Y")
Data.sub <- subset(Data.in, "2007-02-01"<=Date & Date<="2007-02-02")
Data.sub$DateAndTime <- paste(as.character(Data.sub$Date), Data.sub$Time, sep = " ")
Data.sub$DateAndTime <- strptime(Data.sub$DateAndTime, "%Y-%m-%d %H:%M:%S")
Data.sub$Global_active_power <- as.numeric(as.character(Data.sub$Global_active_power))
Data.sub$Sub_metering_1 <- as.numeric(as.character(Data.sub$Sub_metering_1))
Data.sub$Sub_metering_2 <- as.numeric(as.character(Data.sub$Sub_metering_2))
Data.sub$Sub_metering_3 <- as.numeric(as.character(Data.sub$Sub_metering_3))
Data.sub$Voltage <- as.numeric(as.factor(Data.sub$Voltage))

# Making Plot 4
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow= c(2,2), mar=c(4,4,0.5,0.5))

plot(Data.sub$DateAndTime, Data.sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(Data.sub$DateAndTime, Data.sub$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(Data.sub$DateAndTime, Data.sub$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering", col= "grey")
lines(Data.sub$DateAndTime, Data.sub$Sub_metering_2, col="red")
lines(Data.sub$DateAndTime, Data.sub$Sub_metering_3, col="blue")
legend("topright",lty = c(1,1,1), col = c("grey", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5, bty = "n")

plot(Data.sub$DateAndTime, Data.sub$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
