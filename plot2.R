# Plot 2: Generation Code 
setwd("./Documents/DSU Projects/Exploratory Data Analysis")


# Read in data from dates 2007-02-01 and 2007-02-02.
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
setwd("./data")
download.file(fileUrl,destfile ="./data.zip",method = "curl")
unzip("data.zip",exdir="./")
dateDownloaded <- date()
household_power_consumption <- read.table("./household_power_consumption.txt",header = TRUE,sep=";")


# Convert Date and Time to Date/Time [strptime(),as.Date()]
hpc_target <- household_power_consumption
household_power_consumption$Date <- as.Date( as.character(household_power_consumption$Date), format = "%d/%m/20%y")
findRanges <- function(x,y){household_power_consumption[household_power_consumption$Date >= x & household_power_consumption$Date <= y,]}
hpc_target <- findRanges(as.Date("2007-02-01"),as.Date("2007-02-02"))
hpc_target$DateTime <- format(as.POSIXct(paste(hpc_target$Date, hpc_target$Time)), "%Y/%m/%d %H:%M:%S")

rm("household_power_consumption","hpc_test")


# Construct plot, saved to plot1.png with 
# width = 480 pixels, height = 480 pixels
# Location of save: top-level folder of git repository 
globalactivepower <- gsub("?", "", hpc_target$Global_active_power)   
globalactivepower <- as.numeric(globalactivepower) 
dateandtime <-gsub("?", "", hpc_target$DateTime)  
dateandtime <- as.Date(hpc_target$DateTime)
x<-as.POSIXct(hpc_target$DateTime)


png('plot2.png',width = 480, height = 480)
plot(x, hpc_target$Global_active_power, type="n",ylab="Global Active Power (kilowatts)",xlab = "")
lines(x,hpc_target$Global_active_power)
dev.off()
