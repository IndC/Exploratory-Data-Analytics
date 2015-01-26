# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor  
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(reshape2)
library(ggplot2)

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

SMV <- SCC[grep("highway", SCC$SCC.Level.Two, ignore.case = TRUE), c(1,4)]
SMV$EI.Sector <- factor(SMV$EI.Sector)
a <- NEI[NEI$SCC %in% SMV$SCC & (NEI$fips == "24510"|NEI$fips == "06037"),c(2,1,4,6)]
b <- merge(a, SMV, by = "SCC")
b$fips <- replace(b$fips, b$fips=="24510", "Baltimore")
b$fips <- replace(b$fips, b$fips=="06037", "LosAngeles")

y <- with(b, tapply(Emissions, list("City" = fips,"Sector" = EI.Sector, "Year" = year),sum, na.rm = TRUE))
y <- melt(y, id = c("Year", "City", "Sector"), na.rm = TRUE)

png("./Exploratory-Data-Analytics/plot6.png", width=800,height=400)
  g <- ggplot(y, aes(x = Year, y = value, fill = City)) +scale_color_identity()
  g <- g + geom_bar(stat = "identity", position = position_dodge())  + geom_smooth(method = "lm", se = FALSE)
  g + labs(title = "PM2.5 Emissions from Motor Vehicles \nin Baltimore and Los Angeles by year.") + labs(x = "Year", y = "PM2.5 Emission")
dev.off()



