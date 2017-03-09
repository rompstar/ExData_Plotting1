
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


# convert Date and Time into proper format seperated by a space and the Cast it to object class "POSIXlt"
datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

class(datetime)

#convert the columns we need to number in one shot using 
# check class before to make sure the sapply is doing its job right 
sapply(subdata, class)

cols.num <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata[cols.num] <- sapply(subdata[cols.num],as.numeric)

sapply(subdata, class)

# setup the plot, lines and legend
plot(datetime, subdata$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(datetime, subdata$Sub_metering_2, type="l", col="red")
lines(datetime, subdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.copy(png,'plot3.png', width=480, height=480)

dev.off()

