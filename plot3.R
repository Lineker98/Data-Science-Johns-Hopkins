## Loading the necessary libraries
library(dplyr)
library(data.table)

## Downloading the dataset
file_name <- "Eletric_power_consumption.zip"

## Checking if the data has already been downloaded
if(!file.exists(file_name)){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = url, destfile = file_name)
}

## checking if the data has already been unzip
if(!file.exists("household_power_consumption.txt")){
    unzip(file_name)
}

## reading data
data <- fread(file = "household_power_consumption.txt", header = TRUE)

## getting some intuition of data
str(data)
head(data)

## How we'll just work with the data from 1/2/2007 and 2/2/2007,
## let's carry out the following code
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## As we can see, the Date columns is character class, and to facility the code
## we'll convert to date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## As required, we need to make a histogram on global active power, which is now a character column
## So, we need convert it to a double values column
data$Global_active_power <- as.double(data$Global_active_power)

## Here we'll create a new variable, datatime, and storage the Time column as POSIXlt
datatime <- strptime(data$Time, format = "%H:%M:%S")
datatime[1:1440] <- format(datatime[1:1440], "2007-02-01 %H:%M:%S")
datatime[1441:2880] <- format(datatime[1441:2880], "2007-02-02 %H:%M:%S")

## First, we will convert all the metering column from character to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Now we can start our plot
png("plot3.png", width = 480, height = 480)
plot(datatime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
points(datatime, data$Sub_metering_2, type = "l", col = "red")
points(datatime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()