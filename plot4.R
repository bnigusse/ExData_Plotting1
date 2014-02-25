plotprj <- function() {

        # Get the data using read.csv.sql function 
        library(sqldf)   # load the library first
        ds <- read.csv.sql("household_power_consumption.txt", sql = "select * from file WHERE Date in ('1/2/2007', '2/2/2007') ", 
                           header = TRUE, sep = ";")
        
        ds[ds %in% "?"] = "NA" 
        ds$DateTime <- as.POSIXct(paste(ds$Date, ds$Time), format="%d/%m/%Y %H:%M:%S") 
        
        ds <- na.omit(ds)

        # Create Plot 4 
        windows.options(width = 480, height = 480)
        par(cex.axis = 0.8, cex.lab = 0.8, cex.main = 1.2, cex.sub = 1)
        par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(2, 2, 2, 0))
        with(ds, {plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)",  
                       type = "l", lty = 1, lwd = 1)
                 
                  plot(DateTime, Voltage, ylab = "Voltage", type = "l", lty = 1, lwd = 1)
                 
                  plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
                  lines(DateTime, Sub_metering_1, type = "l", lty = 1, lwd = 1)
                  lines(DateTime, Sub_metering_2, type = "l", lty = 1, col = "red", lwd = 1)
                  lines(DateTime, Sub_metering_3, type = "l", lty = 1, col = "blue", lwd = 1)
                  legend("topright", lty = 1, lwd = 1.5, cex = 0.5, col = c("black", "red", "blue"), 
                         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                 
                  plot(DateTime, Global_reactive_power, type = "l", lty = 1, lwd = 1)
                  
                 })

        # Copy my plot to a PNG file
        dev.copy(png, file = "plot4.png", width = 480, height = 480)
        
        # Don't forget to close the PNG device!
        dev.off()        
        windows.options(reset = TRUE)
}