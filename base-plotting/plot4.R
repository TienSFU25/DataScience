source("./helpers.R")

if (is.null(householdData)) {
  householdData <- load_data_for_a1()
}

png(file="./results/plot4.png")

par(mfrow = c(2, 2))
plot(householdData$dateTime, householdData$Global_active_power, type="l", xlab="", ylab="Global Active Power", xaxt="n")
addXAxis(householdData$dateTime)

plot(householdData$dateTime, householdData$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
addXAxis(householdData$dateTime)

plot(householdData$dateTime, householdData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", xaxt="n")
addXAxis(householdData$dateTime)
lines(householdData$dateTime, householdData$Sub_metering_1)
lines(householdData$dateTime, householdData$Sub_metering_2, col="red", pch=22)
lines(householdData$dateTime, householdData$Sub_metering_3, col="blue", pch=22)
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))

plot(householdData$dateTime, householdData$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power", xaxt="n")
addXAxis(householdData$dateTime)  

dev.off()