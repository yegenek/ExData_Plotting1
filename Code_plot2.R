library(dplyr)
library(lubridate)
# c("character","character",rep("double",7))
household_data <- read.table("data/exdata_data_household/household_power_consumption.txt",header = TRUE,sep = ";",
                             colClasses = "character")
class(household_data$Date)

# Converting columns 3:9 to a numeric format from character
for (i in names(household_data)[3:7]){
  household_data[i][,1] <- as.numeric(household_data[i][,1])
}

# Converting Date to a convenient time format with lubridate package function dmy()
household_data$Date <- dmy(household_data$Date)
head(household_data$Date)
household_data <- filter(household_data, Date == "2007-02-01" | Date == " 2007-02-02")
dim(household_data)
household_data <- mutate(household_data,household_time = paste(household_data$Date,household_data$Time))


# Plot 2
png("plot2.png",width = 480,height = 480)

class(household_data$household_time)
household_data$household_time <- ymd_hms(household_data$household_time)

with(household_data, plot(household_time,Global_active_power, type = "line",
                          xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.off()

