install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
data()
data("AirPassengers")
View(AirPassengers)

install.packages("nycflights13")
library(nycflights13)
data("flights")
dim(flights)
View(flights)

## Filtering or subsetting the rows
filter(flights,month == 1, day == 1) 

filter(flights, month == 1 | month == 2)

filter(flights, month ==1 & month == 2)

##slicing the rows
slice(flights, 1:10)

## Arranging the rows

arrange(flights, year, desc(month), desc(day))
## Here month will start from 12 and day will start from 31

arrange(flights, year, desc(month, day))
## Here month will be descending but day will be ascending

arrange(flights, desc(year, month, day))
## Here year will be descending where as month and dat will be ascending


## Selecting columns in a data set by name
select(flights, year, month, day)

## Selecting all columns between year and day inclusive
select(flights, year:day)

## selecting other columns expect between year and day
select(flights, -(year:day))

## Extract unique rows 

distinct(flights)
distinct(flights, year, month)

## Adding new columns

mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)

dim(flights)

## if yopu want to keep only newly created columns then use transmute()
transmute(flights,
          gain = arr_delay - dep_delay,
          gain_per_hour = gain / (air_time / 60)
)

## Summarize operations

summarise(flights, delay = mean(dep_delay,na.rm = T))

## Random sampling using sample_n and sample_frac()
## sample_n is used for fixed set of rows
## sample_frac is used for fixed fraction/percentage of rows

sample_n(flights, 10)
sample_frac(flights, 0.001)

## replace = TRUE can be used for bootstrap sampling and and weight the sample using "weight" argument

################## Grouped Operations ################################################################

by_tailnum = group_by(flights, tailnum)

by_month = group_by(flights,year, month)
by_month

delay_monthly = summarise(by_month, count = n(), delay = mean(arr_delay, na.rm = T))
delay_monthly

delay = filter(delay_monthly, delay > 4)
delay

by_tailnum

delay = summarise(by_tailnum, count = n(), dist = mean(distance, na.rm = T), delay = mean(arr_delay, na.rm = T))

delay = filter(delay, count > 20, dist < 2000)


ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()

## find out number of planes and number of planes that go to each possible destination

destinations = group_by(flights, dest)

destinations

distinct(flights, dest)

View(flights)

summarise(destinations, planes = n_distinct(tailnum), flights = n())

## Progressive rollup of a data set
## first group by day, then by month and then by year

daily <- group_by(flights, year, month, day)
daily

per_day = summarise(daily, flights = n())
per_day

per_month = summarise(per_day, flights = sum(flights))
per_month

per_year = summarise(per_month, flights = sum(flights))
per_year

############### Genomic Data analysis ###########################################################################################

library(dplyr)

install.packages("downloader")
library(downloader)

url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"

filename <- "msleep_ggplot2.csv"
filename
msleep <- read.csv("msleep_ggplot2.csv")

## download.file() take url link and destination file name
msleep = download.file(url,filename)

head(msleep)

str(msleep)

class(msleep)

sleepdata = select(.data = msleep, name, sleep_total)

head(sleepdata)

##To select all the columns except a specific column, use the "-" (subtraction) operator (also known as negative indexing)
head(select(msleep,-name))

##To select a range of columns by name, use the ":" (colon) operator
head(select(msleep,name:order))

##To select all columns that start with the character string "sl", use the function starts_with()
head(select(msleep,starts_with("sl")))

##ends_with() = Select columns that end with a character string

##contains() = Select columns that contain a character string

##matches() = Select columns that match a regular expression

##one_of() = Select columns names that are from a group of names

## Selecting rows using filter()

filter(msleep,sleep_total >= 16)

filter(msleep, sleep_total >= 16, bodywt >= 1)

filter(msleep, order %in% c("Perissodactyla", "Primates"))

## Using pipe "%>%" operator #################

msleep %>% 
  select(name, sleep_total) %>% 
  head

msleep %>% arrange(order) %>% head

msleep %>% head %>% arrange(order)

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  head

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  filter(sleep_total >= 16)

msleep %>% arrange(-order) %>% head

head(arrange(msleep,order,sleep_total))

## Create new columns using mutate()

msleep %>% 
  mutate(rem_proportion = sleep_rem / sleep_total) %>%
  head

msleep %>% 
  mutate(rem_proportion = sleep_rem / sleep_total, 
         bodywt_grams = bodywt * 1000) %>%
  head

## Create summaries of the data frame using summarise()

msleep %>% summarise(avg_sleep = mean(sleep_total))

msleep %>% summarise(avg_sleep = mean(sleep_total),min_sleep = min(sleep_total),max_sleep = max(sleep_total),total_rows = n())

## group_by function

msleep %>%
  group_by(order) %>%
  summarise(avg_sleep = mean(sleep_total),min_sleep = min(sleep_total),max_sleep = max(sleep_total),total_rows = n())