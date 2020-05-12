
data <- read.csv("./household_power_consumption.txt", sep = ";", header = TRUE)
data <- transform(data, Date = as.Date(data$Date, "%d/%m/%Y"))
df <- data[data$Date %in% c(as.Date("2007-02-01","%Y-%m-%d"), as.Date("2007-02-02","%Y-%m-%d")),]

df[3:9] <- as.data.frame(apply(df[,3:9], 2, as.numeric))
df$DateTime <- paste(df$Date, df$Time)
df$Time2 <- strptime(df$DateTime, format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2,2))
with (df, {
        plot(Time, Global_active_power, ylab = "Global Active Power (Kilowatts)", axes = FALSE)
        axis(2)
        axis(1, at = c(0,1440,2880),labels = c("Thurs","Fri","Sat"), tick = TRUE)
        plot(Time, Voltage, ylab = "Voltage", xlab = "datetime" , axes = FALSE)
        axis(2)
        axis(1, at = c(0,1440,2880),labels = c("Thurs","Fri","Sat"), tick = TRUE)
        plot(Time, df$Sub_metering_1, ylab = "Energy Sub metering", axes = FALSE )
        axis(2)
        axis(1, at = c(0,1440,2880),labels = c("Thurs","Fri","Sat"), tick = TRUE)
        lines(df$Time, df$Sub_metering_2, col="red")
        lines(df$Time, df$Sub_metering_3, col="blue")
        legend("topright",pch = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        plot(Time, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", axes = FALSE)
        axis(2)
        axis(1, at = c(0,1440,2880),labels = c("Thurs","Fri","Sat"), tick = TRUE)
})
dev.copy(png, "plot_4.png",  width = 480, height = 480, units = "px")
dev.off()