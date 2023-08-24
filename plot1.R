# Download and unzip data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip", "household_power_consumption.txt")
file.remove("household_power_consumption.zip")

# Load data frame
library(dplyr)
df_raw <- read.table("household_power_consumption.txt", sep = ";", 
                     header = TRUE)
format(object.size(df_raw), units = "MB")
df_raw$Date <- as.Date(df_raw$Date, "%d/%m/%Y")
df <- subset(df_raw, Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(Date_Time = paste(Date, Time)) %>%
  select(-c(Time))
df$Date_Time <- strptime(df$Date_Time, format = "%Y-%m-%d %H:%M:%S")
format(object.size(df), units = "MB")
df[, 2:8] <- lapply(df[, 2:8], as.numeric, na.rm = TRUE)
rm(df_raw)
str(df)

# Plot 1: Global Active Power
png("plot1.png", height = 480, width = 480)
with(df, hist(Global_active_power, 
              xlab = "Global Active Power (kilowatts)", 
              main = "Global Active Power", col = "red"))
dev.off()