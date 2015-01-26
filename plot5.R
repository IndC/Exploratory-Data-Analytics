# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(reshape2)
library(ggplot2)

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

SMV <- SCC[grep("highway", SCC$SCC.Level.Two, ignore.case = TRUE), c(1,4)]
SMV$EI.Sector <- factor(SMV$EI.Sector)
a <- NEI[NEI$SCC %in% SMV$SCC & NEI$fips == "24510",c(2,4,6)]
b <- merge(a, SMV, by = "SCC")

y <- with(b, tapply(Emissions, list("Sector" = EI.Sector, "Year" = year),sum, na.rm = TRUE))
y <- melt(y, id = c("Year", "Sector"), na.rm = TRUE)

png("./Exploratory-Data-Analytics/plot5.png", width=800,height=400)
  g <- ggplot(y, aes(Year, value))
  g <- g + geom_point() + facet_grid(. ~ Sector) + geom_smooth(method = "lm", se = FALSE)
  g + labs(title = "PM2.5 Emissions from Motor Vehicles by year.") + labs(x = "Year", y = "PM2.5 Emission")
dev.off()