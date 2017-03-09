
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

cols.num <- c("Global_active_power","Global_reactive_power","Voltage","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata[cols.num] <- sapply(subdata[cols.num],as.numeric)

# check after to make sure it worked 
sapply(subdata, class)

# setup for the simple multi-paneled plot 2 x 2
par(mfrow = c(2, 2)) 

# plot the Global Active Power
plot(datetime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# plot the Voltage 
plot(datetime, subdata$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot the Sebmeter1, add 2 and 3
plot(datetime, subdata$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subdata$Sub_metering_2, type="l", col="red")
lines(datetime, subdata$Sub_metering_3, type="l", col="blue")

# setup all the legends wanted 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

# last add the Global Reactive Power line plot
plot(datetime, subdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# once all is displayed on the screen, capture into a png file
png("plot4.png", width=480, height=480)

dev.copy(png,'plot4.png', width=480, height=480)

dev.off()

