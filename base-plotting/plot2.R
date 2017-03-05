source("./helpers.R")

# read data to memory
if (is.null(householdData)) {
  householdData <- load_data_for_a1()
}

png(file="./results/plot2.png")
par(mfrow = c(1, 1))

# actual plotting
plot(householdData$dateTime, householdData$Global_active_power, type="l", xlab="", ylab="Global Active Power(kilowatts)", xaxt="n")
addXAxis(householdData$dateTime)

dev.off()