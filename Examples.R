## Examples from week one "Getting and Cleaning Data"
if (!file.exists("WeekOne")) {
  dir.create("WeekOne")
}
if (!file.exists("WeekOne/data")) {
  dir.create("WeekOne/data")
}
flUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(flUrl, destfile="./WeekOne/data/cameras.csv", method="curl")
list.files("./WeekOne/data")
dateDownloaded <- date()
dateDownloaded

## Reading data in to R use either read.table or read.csv; read.table is more versitle. It takes more parameters
cameraData <- read.table("./WeekOne/data/cameras.csv", sep=",", header = TRUE)  #read.tables have to specify separation (sep=).
head(cameraData)
cameraData <- read.csv("./WeekOne/data/cameras.csv")
head(cameraData)

## Week one examples getting and reading xlsx files
if (!file.exists("WeekOne/data")) {
  dir.create("WeekOne/data")
}
flUrl2 <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(flUrl2, destfile = "./WeekOne/data/cameras.xlsx", method = "curl")
dataDownloaded2 <- (date)
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)

## Week one examples getting and reading xml files
## http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf
install.packages("XML")
library(XML)
flUrl3 <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(flUrl3, useInternal=TRUE)
rootNode <- xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)
xmlSApply(rootNode, xmlValue)

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)  # This did not work, why not because of changes to the website?
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue) # This did not work, why not because of changes to the website?
scores
teams
# Examples mentioned in the discussion board. The class can be found by viewing the source at the web page 
# and figuring out which tags represent the data points of interest.
wins <- xpathSApply(doc,"//div[@class='game-result win']",xmlValue)
losses <- xpathSApply(doc,"//div[@class='game-result loss']",xmlValue)
game.info <- xpathSApply(doc,"//div[@class='game-meta']",xmlValue)
wins
losses
game.info


## Examples from week one reading JSON files
## www.wikipedia.org/wiki/JASON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)

## Examples from week one data.table packages
install.packages("data.table")
library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
data.table(DT,3)
## to see all of the tables in memory
tables()
DT[2,]
DT[DT$y=="a",]
# subset rows
DT[c(2,3)]
DT[,c(2,3)]
# writting expressions
{
x = 1
y = 2
}
k = {print(10); 5}
print(k)
DT[,list(mean(x),sum(z))]
DT[,table(y)]
# add new columns
DT[,w:=z^2]
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
DT
#plyr like operation
DT[,a:=x>0]
DT
DT[,b:=mean(x+w), by=a]
DT
# this section of code did not produce the expected output--per the lecture video
set.seed(123);
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]
DT

DT <- data.table(x=rep(c("a","b","c"), each=100), y=rnorm(300))
setkey(DT, x)
DT["a"]

################# VERY IMPORTANT ###########
# This is an example that shows how to join/merge tables using keys
DT1 <- data.table(x=c('a','a','b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a','b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

## test to show how long it takes to read data into a data table
## benchmark against a data frame
## This website show the differences between data frames and data tables
## http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table
big_df <-  data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep='\t', quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))

