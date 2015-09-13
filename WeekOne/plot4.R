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
part4 <- read.table(unz(destination, "household_power_consumption.txt"), stringsAsFactors = FALSE, header = TRUE, sep = ";", na.strings = "?") ## Getting the dataset
unlink(destination)

part4$Date <- as.Date(part4$Date, "%d/%m/%Y") ## Changing the date variable from class char to class date
part4 <- part4[part4$Date >= "2007-02-01" & part4$Date <= "2007-02-02",] ##  Subsetting to get the period of interest
part4$Time <- paste(part4$Date, part4$Time) 
part4$Time <- as.POSIXct(part4$Time)  ## Changing the time variable from class char to class POSIXct (date format)

par(mfrow = c(2,2)) ##  Creating a 2X2 grid and plotting four plots to the grid.
with(part4, {
   plot(part4$Time, part4$Global_active_power, type="l", cex.lab=1, ylab = "Global Active Power (kilowatts)", xlab = "")
   
   plot(part4$Time, part4$Voltage, type="l", ylab = "Voltage", xlab = "datetime")
   
   with(part4, plot(Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
   with(part4, points(Time, Sub_metering_2, type="l", col="red"))
   with(part4, points(Time, Sub_metering_3, type="l", col="blue"))
   legend("topright", lwd=0, cex=.70, bty="n", col=c("black", "red"), "blue", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
   
   plot(part4$Time, part4$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = "datetime")
})
dev.copy(png, file="WeekOne/plot4.png", width=480, height=480, units="px") ##   copying plot to png file
dev.off() ##    closing the png device