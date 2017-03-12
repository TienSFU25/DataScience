source("./loadData.R")

png(file="./results/plot3.png")

# emissions by year and type
byYearAndType <- group_by(NEI, year, type)
summary <- summarise(byYearAndType, TotalEmissions=sum(as.numeric(Emissions)))

g <- ggplot(summary, aes(year, TotalEmissions))
wholeplot <- g + geom_line() + facet_grid(. ~ type) + labs(y="Emissions by type (tons)")

print(wholeplot)

dev.off()