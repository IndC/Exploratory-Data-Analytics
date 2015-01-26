# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

y <- with(NEI, tapply(Emissions, year, sum))
x <- as.numeric(names(y))

png("./Exploratory-Data-Analytics/plot1.png", width=400,height=400)
  plot(x,y, xlab = "Year", ylab = "Total PM2.5 emission (Tons)", main = "Total PM2.5 emission \nfrom all sources by year")

  w <- lm(y ~ x)
  abline(w, lwd = 2, col = "red")
  legend("topright", pch = c(1, NA), col = c("black", "red"),legend = c("PM2.5 Emission", "Trend Line"), lty = c(0,1), lwd = c(1,2))

dev.off()