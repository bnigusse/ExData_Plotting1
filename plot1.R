plotprj <- function() {
        
        # Get the data using read.csv.sql function 
        library(sqldf)   # load the library first
        ds <- read.csv.sql("household_power_consumption.txt", sql = "select * from file WHERE Date in ('1/2/2007', '2/2/2007') ", 
                           header = TRUE, sep = ";")
        
        ds[ds %in% "?"] = "NA" 
        ds$DateTime <- as.POSIXct(paste(ds$Date, ds$Time), format="%d/%m/%Y %H:%M:%S") 
        
        ds <- na.omit(ds)

        # Create Plot 1 
        windows.options(width = 480, height = 480)
        par(cex.axis = 0.8, cex.lab = 0.8, cex.main = 1.2, cex.sub = 1)
        par(mar = c(5.1, 4.1, 4.1, 2.1), oma = c(0, 1, 1, 0))
       
        with(ds, hist(Global_active_power, main = "Global Active Power", 
                       xlab = "Global Active Power (kilowatts)", col="red"))
        
        # Copy my plot to a PNG file
        dev.copy(png, file = "plot1.png", width = 480, height = 480)
        
        # Don't forget to close the PNG device!
        dev.off()        
        windows.options(reset = TRUE)
}