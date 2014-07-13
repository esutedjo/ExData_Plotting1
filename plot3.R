
# Requires Lubridate
library(lubridate)

# Reading data
data <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

# Converting date and append timestamp and day
data$Date <- as.Date(data$Date, format ="%d/%m/%Y")
timestamp <- as.POSIXct(paste(data$Date, data$Time))
data <- cbind(data, timestamp)

# Subsetting data for 1FEB2007 to 2FEB2007
start <- as.POSIXct("2007-02-01 00:00:00")
end <- as.POSIXct("2007-02-02 23:59:00")
int <- new_interval(start, end)
sub.data <- data[data$timestamp %within% int,]

# Plot Graph
plot(sub.data$Sub_metering_1, type ="l", ylab ="Energy sub metering", xaxt="n", xlab="", col="black")
points(sub.data$Sub_metering_2, type ="l", col="red")
points(sub.data$Sub_metering_3, type ="l", col="blue")
axis(1, at=c(0,1440,2880), label=c("Thu","Fri","Sat"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Create png file
dev.copy(png, file="plot3.png")
dev.off()