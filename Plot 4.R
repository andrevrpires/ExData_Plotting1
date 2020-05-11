url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
unzippedfile <- "household_power_consumption.txt"
if (!file.exists(unzippedfile))
{
  destfile <- "household_power_consumption.txt.zip"
  if (!file.exists(destfile))
  {
    download.file(url, destfile = destfile, method = "curl")
    downloadtime <- date()
  }
  unzip(destfile)
}

initial<-read.table("household_power_consumption.txt",
                    header=TRUE,sep=";", nrows=5)

df <- read.table(unzippedfile,
                 header = TRUE,
                 sep = ";",
                 stringsAsFactors = F,
                 col.names=names(initial))

df <- df[(df$Date == "1/2/2007" | df$Date == "2/2/2007"),]
df$datetime <- paste(df$Date, df$Time)
df$datetime <- as.POSIXct(df$datetime, format = "%d/%m/%Y %H:%M:%S")
df <- df[,3:10]

png("plot4.png", width=720, height=720)
par(mfcol=c(2,2))
plot(df$datetime,
     df$Global_active_power,
     ylab="Global Active Power", 
     xlab="", pch =".", type="l")

plot(df$datetime,
     df$Sub_metering_1,
     ylab="Energy sub metering",
     xlab="", type="l", col="black")
points(df$datetime,
       df$Sub_metering_2,
       col="red", type="l")
points(df$datetime,
       df$Sub_metering_3,
       col="blue", type="l")
legend("topright",
       lwd=1,
       col=c("black", "red", "blue"),
       legend=names(df[,5:7]))

plot(df$datetime,
     df$Voltage,
     ylab="Voltage",
     xlab="datetime",
     type="l")

plot(df$datetime,
     df$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="datetime", type="l")
dev.off()