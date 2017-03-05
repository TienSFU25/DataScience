source("./helpers.R")

if (is.null(householdData)) {
  householdData <- load_data_for_a1()
}

png(file="./results/plot3.png")
par(mfrow = c(1, 1))

# actual plotting
plot(householdData$dateTime, householdData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", xaxt="n")
addXAxis(householdData$dateTime)
lines(householdData$dateTime, householdData$Sub_metering_1)
lines(householdData$dateTime, householdData$Sub_metering_2, col="red", pch=22)
lines(householdData$dateTime, householdData$Sub_metering_3, col="blue", pch=22)
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))

dev.off()