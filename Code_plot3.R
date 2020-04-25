library(dplyr)
library(lubridate)
# c("character","character",rep("double",7))

household_data <- read.table("",header = TRUE,sep = ";",
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

# Plot 3

png("plot3.png",width = 480,height = 480)
with(household_data,plot(household_time,Sub_metering_1,type = "l",xlab = "",ylab= "Energy sub metering"))
with(household_data, points(household_time,Sub_metering_2,col = "red",type = "l"))
with(household_data, points(household_time,Sub_metering_3,col = "blue",type = "l"))
legend("topright",lty = 1, col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

