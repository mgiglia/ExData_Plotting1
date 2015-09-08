## read in the csv file (note that the size is large, and will take up 2GB of RAM) (note that the file must be in your working directory to execute)
?read.csv
epc <- read.csv2(file="household_power_consumption.txt", header=TRUE, stringsAsFactors = FALSE, na.strings="?")
head(epc)

## check the classes for the Date and Time variables
class(c(epc$Date,epc$Time))
## Date is currently a charater formatted variable

## we will only be using records from the dates 2007-02-01 and 2007-02-02, subset to make smaller for memory
epc <- subset(epc, Date %in% c("1/2/2007","2/2/2007"))

## change Date and Time to date/time formats using lubridate library:
library(lubridate)
?lubridate
epc$Date <- dmy(epc$Date)
epc$Time <- hms(epc$Time)

## convert the other columns to numeric
epc[, 3:9] <- sapply(epc[,3:9], as.numeric)

## create a date/time variable from the Date variable and the Time variable for use in the timesseries plots
epc$DateTime <- ymd_hms(paste(epc$Date, hour(epc$Time), minute(epc$Time), second(epc$Time)))

## plot 4 is four plots in 1, in the top left we have the plot from plot 2, in the top right we have a Voltage time series plot, in the bottom left we have the plot from plot 3, and in the bottom right we have a time series for global reactive power

png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(epc, {
      plot(DateTime
           ,Global_active_power
           ,ylab = "Global Active Power"
           ,xlab = ""
           ,type="l")
      plot(DateTime
           ,Voltage
           ,ylab = "Voltage"
           ,xlab = "datetime"
           ,type="l")
      plot(DateTime
           ,Sub_metering_1
           ,type = "l"
           ,col = "black"
           ,ylab = "Energy sub metering"
           ,xlab = "")
      lines(DateTime
            ,Sub_metering_2
            ,col = "red")
      lines(DateTime
            ,Sub_metering_3
            ,col = "blue")
      legend(
            "topright"
            ##ymd_hms("20070202 23:59:59")
            ##,40
            ,col = c("black","red","blue")
            ,lty = 1
            ,bty="n"
            ,cex = .9
            ##,xjust = 1.4
            ##,y.intersp = 1.3
            ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(DateTime
           ,Global_reactive_power
           ,ylab = "Global_reactive_power"
           ,xlab = "datetime"
           ,type="l")
})
dev.off()
