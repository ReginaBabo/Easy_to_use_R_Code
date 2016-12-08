## Adding more observations
## Structured data set

house <- merge(house,house_extra,all=TRUE,sort=FALSE)

## Adding unstructured data to the data frame
house <- rbind(house,data.frame(House=c("Redwyne"),Region=c("The Reach")))

## Dropping observations #################################
## removing top two observations

candidates=candidates[-c(1:2),]

## Dropping rows based on conditions

candidates[which(candidates$Name!="Robb Stark"),]

## Adding Columns Horizontally

house=cbind(house,military)

house <- merge(candidates,house,by='House',all.x=TRUE,sort=FALSE)

## all.x is a left join
## all.y is a right join  

house <- merge(candidates,house,by="House",all.y=TRUE,sort=FALSE)