source("./loadData.R") 

png(file="./results/plot1.png")

# emissions from all sources by year
byYear <- group_by(NEI, year)
e <- summarise(byYear, TotalEmissions=sum(as.numeric(Emissions)))

plot(e$year, e$TotalEmissions, type="o", ylim=c(0, max(e$TotalEmissions)), xlab="year", ylab="Total Emissions by Year")

dev.off()