source("./helpers.R")

# read data to memory
if (is.null(householdData)) {
  householdData <- load_data_for_a1()
}

png(file="./results/plot1.png")
par(mfrow = c(1, 1))

# actual plotting
hist(householdData$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()