
############# Data Transformation using DPLYR package #######################################################

library(tidyverse)
library(nycflights13)

flights

## int - integer; chr- characted vector or strings; dttm - date - times; lgl - logical true or false; fctr - factor; date - date

## Filter rows with filter() function
## Select rows for January 1st

filter(flights, month == 1, day == 1)

Jan1 = filter(flights, month == 1, day == 1)

## Assign and print the results on console
(dec25 = filter(flights, month == 12, day ==25))

## Problem with "==" operator

sqrt(2) ^ 2 == 2
1/49 * 49 == 1

## Use near() function

near(sqrt(2) ^ 2,2)
near(1/49 * 49, 1)

filter(flights, month == 11 | month == 12)

filter(flights, month == 11|12)

## x %in% y operator

nov_dec <- filter(flights, month %in% c(11, 12))

filter(nov_dec, month == 1)

filter(flights, !(arr_delay > 120 | dep_delay > 120))

filter(flights, (arr_delay <= 120 & dep_delay <= 120))

##### Missing Values ###################################################

is.na()

df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)

## Here filter() ignored the NA values

## to include NA values in the output use below format

filter(df, is.na(x)|x>1)

############### Arrange rows with arrange() function ###################

arrange(flights, year, month, day)

arrange(flights, year, desc(month), desc(day))

arrange(flights, desc(month, year), desc(day))

##### Sorting the missing values #######################################

#### missing values are sorted at the end #####################

df <- tibble(x = c(5, 2, NA))

arrange(df, x)

arrange(df, desc(x))

############ Selecting columns with select() functions ################

# Select columns by name
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
select(flights, year:day)

# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

select(flights, -c(year, month, day))

## Helper functions in select() function

##starts_with("abc"): matches names that begin with "abc".

select(flights, starts_with("arr"))

##ends_with("xyz"): matches names that end with "xyz".

select(flights, ends_with("lay"))

##contains("ijk"): matches names that contain "ijk".

select(flights, contains("_"))

##matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters.

##num_range("x", 1:3) matches x1, x2 and x3

######## Renaming a variable/column using rename() function #########################################

rename(flights, tail_num = tailnum)


## everything() helper function in select() is useful if you have a handful of variables you'd like to move to the start of the data frame.

select(flights, time_hour, air_time, everything())

select(flights, everything())

select(flights, year, month, year)

######################## Adding new variables using mutate() function ###############################

flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

str(flights_sml)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

## If you only want to keep the new variables, use transmute():

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)


transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

transmute(flights, dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %%100)

## Log functions log(), log2(), log10()
## offset functions lead() and lag()

## Cumulative and rolling aggregate functions in R

## cumsum(), cumprod(), cummin(), cummax(); and dplyr provides cummean() for cumulative means. If you need rolling aggregates (i.e. a sum computed over a rolling window), try the RcppRoll package.

x = c(1,2,3,4,5,6,7,8,9,10)

cumsum(x)

cummean(x)

cummin(x)

cummax(x)

## Ranking functions in R

y <- c(1, 2, 2, NA, 3, 4,5)

min_rank(y)

min_rank(desc(y))

row_number(y)

dense_rank(y)

percent_rank(y)

cume_dist(y)

####################### Grouping with summarise() function ############################################

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day = group_by(flights, year, month, day)

summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

##### Combining multiple operators using pipe #########################################

by_dest <- group_by(flights, dest)

(delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)))

(delay <- filter(delay, count > 20, dest != "HNL"))

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

####### Using %>% operator #######################

(delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
filter(count > 20, dest != "HNL"))

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))


flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled <- flights %>% 
  filter((!is.na(dep_delay) &!is.na(arr_delay)))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

(delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  ))

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

################ USeful Summary Functions ##################################

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time)))%>% 
  filter(r %in% range(r))

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

not_cancelled %>% 
  count(dest)

not_cancelled %>% 
  count(tailnum, wt = distance)

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))

################ Grouping by multiple variables ########################################

(daily <- group_by(flights, year, month, day))

(per_day   <- summarise(daily, flights = n()))

(per_month <- summarise(per_day, flights = sum(flights)))

(per_year  <- summarise(per_month, flights = sum(flights)))

yearly = group_by(flights, year)

(per_yearly = summarise(yearly, flights = n()))

############# Ungrouping operations ###################################################

daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n())  # all flights

################# Grouping operations on Mutate and filters ###########################

flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

(popular_dests = flights %>% 
  group_by(dest) %>%
  filter(n()>365))

popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)


