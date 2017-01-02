data("AirPassengers")
class(AirPassengers)
## This tells you that the data series is in a time series format

start(AirPassengers)
#This is the start of the time series

end(AirPassengers)
#This is the end of the time series

frequency(AirPassengers)
#The cycle of this time series is 12months in a year

View(AirPassengers)

summary(AirPassengers)

## Detailed Metrics

#The number of passengers are distributed across the spectrum

plot(AirPassengers)

## This will give the time series plot

abline(reg=lm(AirPassengers~time(AirPassengers)))

time(AirPassengers)

str(AirPassengers)

cycle(AirPassengers)

plot(aggregate(AirPassengers,FUN=median))

boxplot(AirPassengers~cycle(AirPassengers))

#Box plot across months will give us a sense on seasonal effect


