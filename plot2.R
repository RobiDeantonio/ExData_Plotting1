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

#plot2
plot(Data$DateTime, Data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="./ExploratoryDataAnalysis/plot2.png", height=480, width=480)
dev.off()
