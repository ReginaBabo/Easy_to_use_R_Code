install.packages("ISLR")
library(ISLR)

install.packages("tree")
library(tree)


attach(Carseats)
High = ifelse(Sales <= 8, "No","Yes")

Carseats = data.frame(Carseats,High)
View(Carseats)

## Building classification tree using tree() function
tree.carseats = tree(High ~. -Sales, Carseats)

## Results of tree function

summary(tree.carseats)

## Residual Mean Deviation = mean deviation/(n-to) where to is the number of terminal nodes

######### Plot the Classification Tree ###################################################################

plot(tree.carseats)
text(tree.carseats,pretty = 0)

tree.carseats
## "*" indicates the terminal nodes #####################################################################


set.seed(2)
train = sample(1:nrow(Carseats),200)
Carseats.test = Carseats[-train,]
High.test = High[-train]
tree.carseats = tree(High ~. -Sales, Carseats, subset = train)
tree.pred = predict(tree.carseats, Carseats.test, type = "class")
table(tree.pred, High.test)
(86+57)/200
