plot4 <- function () {
  
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
  png(filename = "./plot4.png", width = 480, height = 480, units = "px")
  
  # 4 plots on 2 rows and 2 columns
  par(mfrow=c(2,2))
  
  # Create first plot, Global Active Power
  plot(dataset$DateTime,dataset$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power")
  
  # Create second plot, Voltage
  plot(dataset$DateTime, dataset$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  # Create third plot, Energy Sub Metering
  plot(dataset$DateTime, dataset$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering", col="Black")
  lines(dataset$DateTime, dataset$Sub_metering_2, type="l", col="Red")
  lines(dataset$DateTime, dataset$Sub_metering_3, type="l", col="Blue")
  legend("topright", bty="n", lty=1, lwd=1, col=c("Black","Red","Blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # Create fourth plot, Global_reactive_power
  plot(dataset$DateTime, dataset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  # Close graphic device
  dev.off()
}