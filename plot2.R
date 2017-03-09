
# 4 - plot2.png

# Exploratory Data week 1 Assingment Peer Graded

getwd()

# 1 - Download and UnZip the File

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url)
unzip("exdata_data_household_power_consumption.zip")

# load all the data
mydata <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, dec=".")
summary(mydata)

# 2 - Subset only the data we need

# subset to these dates only: 2007-02-01 and 2007-02-02, since read.table stored the Date as Factor do:
library(dplyr)
subdata <- filter(mydata, (Date %in% c("1/2/2007","2/2/2007") ))

summary(subdata)


# select the columns that I need 

?strptime

# convert Date and Time into proper format seperated by a space and the Cast it to object class "POSIXlt"
datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# verify the class
class(datetime)

# convert the columns we need to number in one shot using 
# check class before to make sure the sapply is doing its job right 
sapply(subdata, class)

cols.num <- c("Global_active_power")
subdata[cols.num] <- sapply(subdata[cols.num],as.numeric)

sapply(subdata, class)


# generate a line plot by type
plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

png("plot2.png", width=480, height=480)

dev.off()

