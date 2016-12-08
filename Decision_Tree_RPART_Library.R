install.packages("rpart")
library(rpart)
x <- cbind(x_train,y_train)

# x_train represents independent variable
# y_train represents dependent variable

fit <- rpart(y_train ~ ., data = x,method="class")

summary(fit)

# Predict the output on training data

predicted = predict(fit,x_test)

##########################################################################################################

# Random Forest using "randomForest" library
install.packages("randomForest")
library(randomForest)

x <- cbind(x_train,y_train)

# Fit the model
fit <- randomForest(Species ~ ., x,ntree=500)

summary(fit)

predicted= predict(fit,x_test)

#########################################################################################################

######## Different Boosting Methods######################################################################

#########################################################################################################

#######Gradient Boosting Method (GBM) ###################################################################

install.packages("caret")
library(caret)

## Set the tuning parameters
fitControl = trainControl(method = "cv", number = 10)
tune_Grid <-  expand.grid(interaction.depth = 2, n.trees = 500, shrinkage = 0.1, n.minobsinnode = 10)
set.seed(825)

## Build and predict the model
fit <- train(y_train ~ ., data = train,method = "gbm", trControl = fitControl, verbose = FALSE, tuneGrid = gbmGrid)
predicted= predict(fit,test,type= "prob")[,2] 

#########################################################################################################
