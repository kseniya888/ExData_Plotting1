#Read table and convert the 
power_data <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
power_data[, "Date"] <- as.Date(power_data[, "Date"], "%d/%m/%Y")
#power_data[, "Date"] <- format(power_data[, "Date"], "%d/%m/%Y")

#match dataset to specific dates
date1 <- as.Date("2007/02/02")
date2 <- as.Date("2007/02/01")

date1_match <- power_data[, "Date"] == date1
date2_match <- power_data[, "Date"] == date2

date1_sub <- power_data[date1_match, ]
date2_sub <- power_data[date2_match, ]
date_sub <- rbind(date2_sub, date1_sub)

#create first graph
library(datasets)
hist(date_sub$Global_active_power)
title(main = "Global Active Power")


hist(date_sub$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")
dev.copy(png, file = "./Data/EA_Assignment_1/Plot1.png")
dev.off()