
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


# plot the line and copy it to a png
with(hpc, plot(DateTime, Global_active_power, type="l",
               xlab="",
               ylab="Global Active Power (kilowatts)"))
dev.copy(png,"plot2.png")
dev.off()

