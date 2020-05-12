
data <- read.csv("./household_power_consumption.txt", sep = ";", header = TRUE)
data <- transform(data, Date = as.Date(data$Date, "%d/%m/%Y"))
df <- data[data$Date %in% c(as.Date("2007-02-01","%Y-%m-%d"), as.Date("2007-02-02","%Y-%m-%d")),]

df[3:9] <- as.data.frame(apply(df[,3:9], 2, as.numeric))
df$DateTime <- paste(df$Date, df$Time)
df$Time2 <- strptime(df$DateTime, format = "%Y-%m-%d %H:%M:%S")

with(df, hist(Global_active_power, main = "Global Active Power", col = "Red", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency"))
dev.copy(png, "plot_1.png", width = 480, height = 480, units = "px")
dev.off()