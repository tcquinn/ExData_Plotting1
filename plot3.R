
## Read the data from a local version of the file

## We keep everything as strings initially because read.table can't handle the 
## "?" symbols directly and it will be harder to convert to numeric later if we
## read as factors.

data <- read.table(file="household_power_consumption.txt",
                       sep=";", header=TRUE,stringsAsFactors=FALSE)

## Convert all numeric columns to numeric class, converting "?" to NA

data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Create a new variable which combines the date and time columns and converts
## to a convenient internal format

data$Date_Time <- as.POSIXct(strptime(paste(data$Date, data$Time,sep=" "),
                                      "%d/%m/%Y %H:%M:%S"))

## Subset the data as specified by the assignment

data.subset <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

## Make plot 3

png(filename="plot3.png")
plot(data.subset$Date_Time,data.subset$Sub_metering_1,type="l",
     xlab="", ylab="Energy sub metering")
points(data.subset$Date_Time,data.subset$Sub_metering_2,type="l",
     col="red")
points(data.subset$Date_Time,data.subset$Sub_metering_3,type="l",
       col="blue")
legend("topright", lty=1, col= c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

