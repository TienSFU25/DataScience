source("./loadData.R")

png(file="./results/plot5.png")

# filter only Emissions Data related to motor sources
mobileSCCs <- SCC[grep("[Vv]ehicle", SCC$Short.Name),]
uniqueMobileSCCs <- unique(as.character(mobileSCCs$SCC))
baltimoreByYear <- NEI %>%
  filter(SCC %in% uniqueMobileSCCs & fips == "24510") %>%
  group_by(year)

summary <- summarise(baltimoreByYear, TotalEmissions=sum(Emissions))

g <- ggplot(summary, aes(as.factor(year), TotalEmissions))
print(g +
        geom_bar(stat="identity") +
        coord_cartesian(ylim = c(0, max(summary$TotalEmissions))) +
        labs(x="Year", y="Total Emissions from motor vehicle sources in Baltimore City")
      )

dev.off()