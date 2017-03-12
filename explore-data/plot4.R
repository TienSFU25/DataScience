source("./loadData.R")
png(file="./results/plot4.png")

coalCombustionSccs <- filter(SCC, grepl("Coal", SCC$EI.Sector) & grepl("Combustion", SCC$SCC.Level.One))

uniqueSccs <- unique(as.character(coalCombustionSccs$SCC))
neis <- filter(NEI, SCC %in% uniqueSccs)

byYear <- group_by(neis, year)
summary <- summarise(byYear, TotalEmissions=sum(Emissions))

g <- ggplot(summary, aes(year, TotalEmissions))
print(g +
        geom_line() +
        coord_cartesian(ylim = c(0, max(summary$TotalEmissions))) + 
        labs(y="Total coal combustion-related emissions (tons)"))

dev.off()