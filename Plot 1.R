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

png("plot1.png", width=720, height=720)
par(mfrow=c(1,1))
hist(as.numeric(df$Global_active_power),
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
