plot2 <- function () {
  
  ## Check if file "household_1-2-022007.txt" exists
  ## If it does not download, unzip and read the dataset
  ## then extract only data for 1/2/2007 and 2/2/2007
  ## to create household_1-2-022007.txt
  
  if (!file.exists("./household_1-2-022007.txt")) {
    zipfileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(zipfileURL, destfile="./household_power_consumption.zip", method = "auto")
    unzip("./household_power_consumption.zip")
    
    # Read dataset file and extract data for "1/2/2007" and "2/2/2007"
    datasetfile <- "./household_power_consumption.txt"
    dataset <- read.table(datasetfile, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
    dataset <- dataset[((dataset$Date == "1/2/2007") | (dataset$Date == "2/2/2007")),]

    # Write the extracted data for re-use in other Plotx functions
    write.table(dataset, file="./household_1-2-022007.txt", quote = FALSE, sep=";", na = "?", row.names = FALSE)
  }

  ## if file "household_1-2-022007.txt" exists
  ## read directly from that file

  else {
    datasetfile <- "./household_1-2-022007.txt"
    dataset <- read.table(datasetfile, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
  }
  
  dataset$DateTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")
  
  # Open the file graphic device
  png(filename = "./plot2.png", width = 480, height = 480, units = "px")
  
  # Write plot
  plot(dataset$DateTime, dataset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  # Close graphic device
  dev.off()
}