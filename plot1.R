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

hist(Data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", cex.sub=0.8)
dev.copy(png, file="./ExploratoryDataAnalysis/plot1.png", height=480, width=480)
dev.off()

