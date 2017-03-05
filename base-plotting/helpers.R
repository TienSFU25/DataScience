load_data_for_a1 <- function() {
  dataDir <- "household_power_consumption.txt"
  
  householdData <- read_delim(delim=";", file=dataDir, col_names=TRUE, na=c("?", "", " "))
  # only dates between 2007-02-01 and 2007-02-2
  start <- "1/2/2007"
  end <- "2/2/2007"
  
  householdData <- filter(householdData, Date == start | Date == end)
  householdData <- mutate(householdData, dateTime=as.numeric(strptime(paste(Date), "%d/%m/%Y")) + Time)
  return(householdData)
}

addXAxis <- function(dateTime) {
  minTime <- min(dateTime)
  maxTime <- max(dateTime)
  midTime <- (minTime + maxTime) / 2
  
  marks <- c(minTime, midTime, maxTime)
  
  # we can get fancy with wday but not important
  axis(side=1, at=marks, labels=c("Thu", "Fri", "Sat"))
}
