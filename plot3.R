# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(ggplot2)

y <- with(subset(NEI, fips == "24510"), tapply(Emissions, list("Type" = type, "Year" = year),sum))

y <- melt(y, id = c("Year", "Type"))

png("./Exploratory-Data-Analytics/plot3.png", width=800,height=400)
  g <- ggplot(y, aes(Year, value))
  g <- g + geom_point() + facet_grid(. ~ Type) + geom_smooth(method = "lm", se = FALSE)
  g + labs(title = "PM2.5 Emissions by type and year for Baltimore") + labs(x = "Year", y = "PM2.5 Emission")

dev.off()