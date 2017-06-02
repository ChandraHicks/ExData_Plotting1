##############################################################################################

#This code reads in energy usage data and creates a plot of Frequency vs. Global Active Power
#  over the time period of 2/1/07-2/2/07

#The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

##############################################################################################
#Macro inputs

#setwd("~/Documents/DataScientistsToolBox/WDforCoursera/C4W1HW")
Startdate <- as.Date("2007-02-01")
Enddate <- as.Date("2007-02-02")


##############################################################################################
#Step 1: Read in data

txtfile = "household_power_consumption.txt"


alldata <- read.table(txtfile, 
                      header = TRUE,
                      sep = ";",
                      na.strings = "?",
                      stringsAsFactors = FALSE)

alldata$MeasurementDate <- as.POSIXct(paste(alldata$Date,alldata$Time),format = "%d/%m/%Y %H:%M:%S")
alldata$Date <- as.Date(alldata$Date,"%d/%m/%Y")

FebData <- alldata[(alldata$Date>=Startdate&alldata$Date<=Enddate),]


##############################################################################################
#Step 2: Create Plot

plot(FebData$MeasurementDate,FebData$Sub_metering_1,type="l",
     xlab= NA,
     ylab= "Energy sub metering")
lines(FebData$MeasurementDate,FebData$Sub_metering_2,type = "l",col="red")
lines(FebData$MeasurementDate,FebData$Sub_metering_3,type = "l",col="blue")
legend(x="topright",
       lty=c(1,1,1), 
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"))

##############################################################################################
#Step 3: Create PNG file
dev.copy(png,'plot3.png')
dev.off()

