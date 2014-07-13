# Requires Lubridate
library(lubridate)

# Reading data
data <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

# Converting date and time columns
data$Date <- as.Date(data$Date, format ="%d/%m/%Y")
timestamp <- as.POSIXct(paste(data$Date, data$Time))
data <- cbind(data, timestamp)

# Subsetting data for 1FEB2007 to 2FEB2007
start <- as.POSIXct("2007-02-01 00:00:00")
end <- as.POSIXct("2007-02-02 23:59:00")
int <- new_interval(start, end)
sub.data <- data[data$timestamp %within% int,]

# Plot Histogram
hist(sub.data$Global_active_power, col = "RED", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Create png file
dev.copy(png, file="plot1.png")
dev.off()