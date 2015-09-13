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
part2 <- read.table(unz(destination, "household_power_consumption.txt"), stringsAsFactors = FALSE, header = TRUE, sep = ";", na.strings = "?") ## Getting the dataset
unlink(destination)

part2$Date <- as.Date(part2$Date, "%d/%m/%Y") ## Changing the date variable from class char to class date
part2 <- part2[part2$Date >= "2007-02-01" & part2$Date <= "2007-02-02",] ##  Subsetting to get the period of interest
part2$Time <- paste(part2$Date, part2$Time) 
part2$Time <- as.POSIXct(part2$Time)  ## Changing the time variable from class char to class POSIXct (date format)
str(part2)
## subsetting the data to get the period of interest
plot(part2$Time, part2$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file="WeekOne/plot2.png", width=480, height=480, units="px") ##   copying plot to png file
dev.off() ##    closing the png device