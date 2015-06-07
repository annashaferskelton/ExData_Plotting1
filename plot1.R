# Un-comment next line to load data first time. Comment it to run faster when data is loaded.
bigData <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

# Format data how I want.
bigData$Date <- as.Date(bigData$Date,'%d/%m/%Y')
dates <- bigData$Date
datesIWant <- dates == "2007-02-01" | dates == "2007-02-02"
twoDayTable <- bigData[datesIWant,]

# Make plot.
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(twoDayTable$Global_active_power)), main = "Global Active Power",xlab="Global Active Power (kilowatts)",col="orange")
dev.off()

