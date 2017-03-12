source("./loadData.R")

png(file="./results/plot6.png")

# filter only by motor vehicle
mobileSCCs <- SCC[grep("[Vv]ehicle", SCC$Short.Name),]
uniqueMobileSCCs <- unique(as.character(mobileSCCs$SCC))
mobileNEI <- filter(NEI, SCC %in% uniqueMobileSCCs)

# emissions from Baltimore City vs LA by year
cityByYear <- mobileNEI %>% filter(fips == "24510" | fips == "06037")

# stick in the city name (for facet label) and group by year
cityByYear <- cityByYear %>%
  mutate(City = ifelse(fips == "24510", "Baltimore City", "Los Angeles")) %>%
  group_by(City, year)

summary <- summarise(cityByYear, TotalEmissions=sum(as.numeric(Emissions)))

g <- ggplot(summary, aes(as.factor(year), TotalEmissions))
print(g +
        geom_bar(stat="identity") +
        facet_grid(. ~ City) +
        coord_cartesian(ylim = c(0, max(summary$TotalEmissions))) +
        labs(x = "Year", y="Emissions from Baltimore City vs LA (tons)")
      )

dev.off()