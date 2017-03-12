source("./loadData.R")

png(file="./results/plot3.png")

# emissions by year and type
byYearAndType <- NEI %>% filter(fips == "24510") %>% group_by(year, type)
summary <- summarise(byYearAndType, TotalEmissions=sum(as.numeric(Emissions)))

g <- ggplot(summary, aes(as.factor(year), TotalEmissions))
wholeplot <- g + 
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  labs(x = "Year", y="Baltimore emissions by type (tons)")

print(wholeplot)

dev.off()