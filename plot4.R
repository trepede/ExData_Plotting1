
#  download and unzip the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "epc.zip")
unzip("epc.zip")

# read it into a data frame
# install.packages("sqldf")  # uncomment only if you don't have sqldf installed
library(sqldf)
hpc <- read.csv.sql("household_power_consumption.txt", 
                    sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", 
                    header = TRUE, sep=';')

#create a DateTime column
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%OS")


# plot the lines and copy to a png
par(mfrow = c(2,2))
with(hpc, plot(DateTime, Global_active_power, type="l", xlab="",
               ylab="Global Active Power"))

with(hpc, plot(DateTime, Voltage, type="l", xlab="datetime",
               ylab="Voltage"))

with(hpc, plot(DateTime, Sub_metering_1, type="l", xlab="",
        ylab="Energy sub metering"))
with(hpc, points(DateTime, Sub_metering_2, type="l",col="red"))
with(hpc, points(DateTime, Sub_metering_3, type="l",col="blue"))
legend("topright", lwd=c(1,1,1), col = c("black", "red", "blue"), 
       bty="n",
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(hpc, plot(DateTime, Global_reactive_power, type="l", xlab="datetime",
               ylab="Global_reactive_power"))

dev.copy(png,"plot4.png",width=900, height=680)
dev.off()

