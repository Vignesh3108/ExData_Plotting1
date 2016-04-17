
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

# Making Plot 2
png(filename = "plot2.png", width = 480, height = 480)

plot(Data.sub$DateAndTime, Data.sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatt)")

dev.off()
