source("./loadData.R")

png(file="./results/plot2.png")

# emissions from Baltimore City by year
baltimoreByYear <- NEI %>% filter(fips == "24510") %>% group_by(year)
b <- summarise(baltimoreByYear, TotalEmissions=sum(as.numeric(Emissions)))

plot(b$year, b$TotalEmissions, type="o", ylim=c(0, max(b$TotalEmissions)), xlab="year", ylab="Total Emissions in Baltimore by Year (tons)")

dev.off()