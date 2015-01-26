# Across the United States, how have emissions from  
# coal combustion-related sources changed from 1999-2008?

library(reshape2)
library(ggplot2)

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

SCCoal <- SCC[grep("coal", SCC$EI.Sector, ignore.case=TRUE), c(1,4)]
SCCoal$EI.Sector <- factor(SCCoal$EI.Sector)
a <- NEI[NEI$SCC %in% SCCoal$SCC,c(2,4,6)]
b <- merge(a, SCCoal, by = "SCC")

y <- with(b, tapply(Emissions, list("Sector" = EI.Sector, "Year" = year),sum, na.rm = TRUE))
y <- melt(y, id = c("Year", "Sector"))

png("./Exploratory-Data-Analytics/plot4.png", width=800,height=400)
  g <- ggplot(y, aes(Year, value))
  g <- g + geom_point() + facet_grid(. ~ Sector) + geom_smooth(method = "lm", se = FALSE)
  g + labs(title = "PM2.5 Emissions from coal combustion-related sources by year.") + labs(x = "Year", y = "PM2.5 Emission")
dev.off()