#Read table and convert the 
power_data <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
power_data[, "Date"] <- as.Date(power_data[, "Date"], "%d/%m/%Y")

#match dataset to specific dates
date1 <- as.Date("2007/02/01")
date2 <- as.Date("2007/02/02")

date1_match <- power_data[, "Date"] == date1
date2_match <- power_data[, "Date"] == date2

date1_sub <- power_data[date1_match, ]
date2_sub <- power_data[date2_match, ]
date_sub <- rbind(date1_sub, date2_sub)

#combine date and time
date_sub[, "Date_Time"] <- paste(date_sub[, "Date"],date_sub[, "Time"])
date_sub[, "Date_Time"] <- format(strptime(date_sub[, "Date_Time"], format="%Y-%m-%d %H:%M:%S"), "%Y-%m-%d %H:%M:%S")
date_sub[, "Date_Time"] <- as.POSIXct(date_sub[, "Date_Time2"],format="%Y-%m-%d %H:%M")


#create first graph
library(datasets)

par(mfrow = c(2,2), mar = c(4, 4, 3, 1))
with(date_sub, {
    #plot 1
    plot(Global_active_power ~ Date_Time, data=date_sub, type="l", col="black", xlab = "", ylab="Global Active Power (kilowatts)")
  
    #plot 2
    plot(Voltage ~ Date_Time, data=date_sub, type="l", col="black", xlab = "datetime", ylab="Voltage")
    
    #plot 3
    plot(Sub_metering_1 ~ Date_Time, data=date_sub, type="l", col="black", xlab = "", ylab="Energy sub metering")
    with(date_sub, lines(Date_Time, Sub_metering_2 ,col="red"))
    with(date_sub, lines(Date_Time, Sub_metering_3 ,col="blue"))
    legend("topright", inset=0, xjust= 1, yjust=1, lty="solid", col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp=0.35,x.intersp=0.5)
    
    #plot 4
    plot(Global_reactive_power ~ Date_Time, data=date_sub, type="l", col="black", xlab = "datetime", ylab="Global_reactive_power")
    
    
})

dev.copy(png, file = "./Data/EA_Assignment_1/Plot4.png")
dev.off()