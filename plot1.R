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

## plot 1 -- histogram of Global Active Power with a title: Global Active Power, and a label for the x-axis:  "Global Active Power (kilowatts)", color = red
?hist
par(mfrow = c(1,1))
with(epc, hist(Global_active_power
               ,col="red"
               ,main="Global Active Power"
               ,xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()