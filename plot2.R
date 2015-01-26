# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

y <- with(subset(NEI, fips == "24510"), tapply(Emissions, year, sum))
x <- as.numeric(names(y))

png("./Exploratory-Data-Analytics/plot2.png", width=400,height=400)
  plot(x,y, xlab = "Year", ylab = "Total PM2.5 emission (Tons)", main = "Total PM2.5 emission from all sources \nby year in Baltimore")
  w <- lm(y ~ x)
  abline(w, lwd = 2, col = "red")
  legend("topright", pch = c(1, NA), col = c("black", "red"),legend = c("PM2.5 Emission", "Trend Line"), lty = c(0,1), lwd = c(1,2))

dev.off()

