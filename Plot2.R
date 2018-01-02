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
plot(Global_active_power ~ Date_Time, data=date_sub, type="l", col="black", xlab = "", ylab="Global Active Power (kilowatts)")


dev.copy(png, file = "./Data/EA_Assignment_1/Plot2.png")
dev.off()