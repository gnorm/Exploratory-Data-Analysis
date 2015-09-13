if (!file.exists("data")) {
   dir.create("data")
}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "./data/household_power_consumption.zip"
download.file(url, destination, method = "curl")    ##don't forget to use method="curl" when you use a mac
list.files("./data")
dateDownloaded <- date()
dateDownloaded
##  data <- read.table(unz(destination, "file.txt"))  ## you can set your parameters like sep=";" or header=TRUE
##  unlink(destination)
part3 <- read.table(unz(destination, "household_power_consumption.txt"), stringsAsFactors = FALSE, header = TRUE, sep = ";", na.strings = "?") ## Getting the dataset
unlink(destination)

part3$Date <- as.Date(part3$Date, "%d/%m/%Y") ## Changing the date variable from class char to class date
part3 <- part3[part3$Date >= "2007-02-01" & part3$Date <= "2007-02-02",] ##  Subsetting to get the period of interest
part3$Time <- paste(part3$Date, part3$Time) 
part3$Time <- as.POSIXct(part3$Time)  ## Changing the time variable from class char to class POSIXct (date format)
str(part3)
## subsetting the data to get the period of interest
with(part3, plot(Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(part3, points(Time, Sub_metering_2, type="l", col="red"))
with(part3, points(Time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red"), "blue", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="WeekOne/plot3.png", width=480, height=480, units="px") ##   copying plot to png file
dev.off() ##    closing the png device