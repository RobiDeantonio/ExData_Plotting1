if (!file.exists("ExploratoryDataAnalysis")) {
  dir.create("ExploratoryDataAnalysis")
}

#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="data.zip", method="curl")
unzip ("data.zip", exdir = "./ExploratoryDataAnalysis/")

PowerData <- read.table("./ExploratoryDataAnalysis/household_power_consumption.txt", sep = ";",
                        header = T, stringsAsFactors = F)
head(PowerData)
class(PowerData$Date)
PowerData$Date <- as.Date(PowerData$Date, "%d/%m/%Y")

library(dplyr)
Data <- filter(PowerData, between(PowerData$Date,as.Date("2007-02-01"),
                                  as.Date("2007-02-02")) )

class(PowerData$Global_active_power)
Data$Global_active_power <- as.numeric(Data$Global_active_power)

library(lubridate)
Data$DateTime <- paste(Data$Date, Data$Time)
Data$DateTime <- strptime(Data$DateTime, "%Y-%m-%d %H:%M:%S")
class(Data$DateTime)

#plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(Data, {
  
  plot(DateTime, Global_active_power, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  
  plot(DateTime, Voltage, type="l", 
       ylab="Voltage (volt)", xlab="", cex=0.8)
  
  plot(DateTime, Sub_metering_1, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(DateTime, Sub_metering_2,col='Red')
  lines(DateTime, Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
  
  plot(DateTime, Global_reactive_power, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="", cex=0.8)
})
dev.copy(png, file="./ExploratoryDataAnalysis//plot4.png", height=480, width=480)
dev.off()
