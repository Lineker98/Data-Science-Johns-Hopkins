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

## How we'll just work with the data from 1/2/2007 and 2/2/2007,
## let's carry out the following code
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## As we can see, the Date columns is character class, and to facility the code
## we'll convert to date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

##### First plot #####
## As required, we need to make a histogram on global active power, which is now a character column
## So, we need convert it to a double values column
data$Global_active_power <- as.double(data$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()