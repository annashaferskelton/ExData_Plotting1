# Un-comment next line to load data first time. Comment it to run faster when data is loaded.
bigData <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
library(lubridate)

# Get data into format I want.
bigData$Date <- as.Date(bigData$Date,'%d/%m/%Y')
dates <- bigData$Date
datesIWant <- dates == "2007-02-01" | dates == "2007-02-02"
twoDayTable <- bigData[datesIWant,]
twoDayTable$dateTime <- NA
twoDayTable$dateTime <- ymd_hms(paste(twoDayTable$Date,twoDayTable$Time))
twoDayTable$Global_active_power <- as.numeric(as.character(twoDayTable$Global_active_power))
twoDayTable$Sub_metering_1 <- as.numeric(as.character(twoDayTable$Sub_metering_1))
twoDayTable$Sub_metering_2 <- as.numeric(as.character(twoDayTable$Sub_metering_2))
twoDayTable$Sub_metering_3 <- as.numeric(as.character(twoDayTable$Sub_metering_3))
twoDayTable$Voltage <- as.numeric(as.character(twoDayTable$Voltage))
twoDayTable$Global_reactive_power <- as.numeric(as.character(twoDayTable$Global_reactive_power))

# Make plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(twoDayTable$dateTime,twoDayTable$Global_active_power,type='l', ylab="Global active power", xlab="datetime", main="Global Active Power Over Time")
plot(twoDayTable$dateTime,twoDayTable$Voltage,type='l', ylab="Voltage", xlab="datetime", main="Global Active Power Over Time")
plot(twoDayTable$dateTime, twoDayTable$Sub_metering_1,type='l',col="orange",ylab="Energy sub metering",xlab="datetime",main="Energy sub metering over time")
# lines(as.numeric(twoDayTable$Sub_metering_1))
lines(twoDayTable$dateTime, as.numeric(twoDayTable$Sub_metering_2),col="green")
lines(twoDayTable$dateTime, as.numeric(twoDayTable$Sub_metering_3),col="magenta")
legend("topright", col=c("orange","green","magenta"),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,lw=2)
plot(twoDayTable$dateTime,twoDayTable$Global_reactive_power,type='l', ylab="Global_reactive_power", xlab="datetime", main="Global Reactive Power Over Time")

dev.off()


