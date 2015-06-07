bigData <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

library(lubridate)

# Make twoDayTable, format it how I want.
bigData$Date <- as.Date(bigData$Date,'%d/%m/%Y')
dates <- bigData$Date
datesIWant <- dates == "2007-02-01" | dates == "2007-02-02"
twoDayTable <- bigData[datesIWant,]
twoDayTable$dateTime <- NA
twoDayTable$dateTime <- ymd_hms(paste(twoDayTable$Date,twoDayTable$Time))

# Make plot.
png(filename = "plot2.png", width = 480, height = 480)
plot(twoDayTable$dateTime,as.numeric(as.character(twoDayTable$Global_active_power)),type='l', ylab="Global active power (kilowatts)", xlab="datetime", main="Global Active Power Over Time", ylim = range(as.numeric(as.character(twoDayTable$Global_active_power))))
lines(twoDayTable$dateTime,as.numeric(as.character(twoDayTable$Global_active_power)), lw=2)
dev.off()