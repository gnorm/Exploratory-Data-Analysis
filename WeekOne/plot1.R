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
part1 <- read.table(unz(destination, "./data/household_power_consumption.txt"), stringsAsFactors = FALSE, header = TRUE, sep = ";", na.strings = "?") ## Getting the dataset
unlink(destination)
part1$Date <- as.Date(part1$Date, "%d/%m/%Y") ## Changing the date variable from class char to class date
part1 <- part1[part1$Date >= "2007-02-01" & part1$Date <= "2007-02-02",] ## subsetting the data to get the period of interest
hist(part1$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.copy(png, file="WeekOne/plot1.png", width=480, height=480, units="px") ##   copying plot to png file
dev.off() ##    closing the png device