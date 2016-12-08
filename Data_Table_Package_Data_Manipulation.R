install.packages("data.table")
library(data.table)

## Reading the csv file using fread() function
train = fread("train_ver2.csv")
summary(test)
DT <- fread("GB_full.csv")

## SUbsetting rows and columns

## rows subsetting
sub_rows <- DT[V4 == "England" & V3 == "Beswick"]

## columns subsetting
sub_columns <- DT[,.(V2,V3,V4)]

## Ordering variables in ascending or descending order
dt_order <- DT[order(V4, -V8)]
## '-' sign is for descending order

## Add a new column
DT[, V_New := V10 + V11]
## Result is not stored back in DT

## update row values
DT[V8 == "Aberdeen City", V8 := "Abr City"]

## Delete a column
DT [,c("V6","V7") := NULL ]

## Performing all commands in one command
DT[V8 == "Aberdeen City", V8 := "Abr City"][, V_New := V10 + V11][,c("V6","V7") := NULL]

## Computing functions on variables like aggregation using column grouping

## compute the average
DT[, .(average = mean(V1o)), by = V4]

## Compute the count
DT[,.N,by = V4]

## Using keys for subsetting the data
## Key reorders the column values in ascending order

setkey(DT, V4)

##subsetting value from the key
DT[.("England")]

##subsetting multiple columns using key
setkey(DT, V3, V4)

##simultaneously subsetting value from both columns
DT[.("Shetland South Ward","Scotland")]


