bigData <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
library(lubridate)

# Make twoDayTable, format it how I want it.
bigData$Date <- as.Date(bigData$Date,'%d/%m/%Y')
dates <- bigData$Date
datesIWant <- dates == "2007-02-01" | dates == "2007-02-02"
twoDayTable <- bigData[datesIWant,]
twoDayTable$dateTime <- NA
twoDayTable$dateTime <- ymd_hms(paste(twoDayTable$Date,twoDayTable$Time))
twoDayTable$Sub_metering_1 <- as.numeric(as.character(twoDayTable$Sub_metering_1))
twoDayTable$Sub_metering_2 <- as.numeric(as.character(twoDayTable$Sub_metering_2))
twoDayTable$Sub_metering_3 <- as.numeric(as.character(twoDayTable$Sub_metering_3))

# Plot.
png(filename = "plot3.png", width = 480, height = 480)
plot(twoDayTable$dateTime, twoDayTable$Sub_metering_1,type='l',col="orange",ylab="Energy sub metering",xlab="datetime",main="Energy sub metering over time")
# lines(as.numeric(twoDayTable$Sub_metering_1))
lines(twoDayTable$dateTime, as.numeric(twoDayTable$Sub_metering_2),col="green")
lines(twoDayTable$dateTime, as.numeric(twoDayTable$Sub_metering_3),col="magenta")
legend("topright", col=c("orange","green","magenta"),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,lw=2)
dev.off()
