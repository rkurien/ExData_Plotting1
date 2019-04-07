zip_file <- "epcdata.zip"

## Download the dataset
if (!file.exists(zip_file)) {
  fileUrl <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, zip_file, mode = "wb")
  
}
# unzip the downloaded file
if (!file.exists("household_power_consumption")) {
  unzip(zip_file)
}

#read 1st row - only column headings - from file
columnHead = read.table("household_power_consumption.txt", nrows = 1, header = TRUE)
colNamesStr <- names(columnHead)
#split all column names from string
colNames <-unlist(strsplit(colNamesStr, ".", fixed = TRUE))

# using setClass to use myDate class for conversion to date format
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))

#use colclass to declare Class type of columns
colclass <- c("myDate", "character", rep("numeric",7))

#read data from file, set column headings and class
data_min <- read.table("household_power_consumption.txt", skip = 1, header = FALSE, sep = ";", col.names = colNames, colClasses = colclass, na.strings = "?")
#subset for required dates
data_min <- data_min[(data_min$Date >= "2007-02-01" & data_min$Date <= "2007-02-02"),]

#plot 1
png(file = "plot1.png", width = 480, height = 480)
hist(data_min$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()