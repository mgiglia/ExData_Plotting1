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

## plot 3 -- multiple times-series for sub-metering 1, 2, and 3.  no title, legend in top right corner. colors are black, red and blue for the sub meters respectively
?legend
png(file = "plot3.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
with(epc, plot(DateTime
               ,Sub_metering_1
               ,type = "l"
               ,col = "black"
               ,ylab = "Energy sub metering"
               ,xlab = ""))
with(epc, lines(DateTime
                ,Sub_metering_2
                ,col = "red"))
with(epc, lines(DateTime
                ,Sub_metering_3
                ,col = "blue"))
legend("topright"
       ,col = c("black","red","blue")
       ,lty = 1
       ,xjust = .5
       ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()