
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

# plot the histogram and copy it to a png
hist(hpc$Global_active_power, main="Global Active Power", 
        xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png")
dev.off()
