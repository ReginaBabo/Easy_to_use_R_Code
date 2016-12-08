install.packages("randomForest")
library(randomForest)

install.packages("Metrics")
library(Metrics)

set.seed(101)

data = read.csv("stock_data.csv", stringsAsFactors = T)

summary(data)

dim(data)

data = data.frame(data)

data$Y = as.factor(data$Y)

typeof(data)

View(data)

train = data[1:2000,]
test = data[2001:3000,]

str(test)
summary(test)
View(train)

test$Y = NULL

## Build RandomForest Model
attach(train)
model_rf<-randomForest(Y~.,data=train)
summary(model_rf)

preds<-predict(object=model_rf,newdata = test,type = "response")



table(preds)

auc(preds,test$Y)

### Now clustering the data set and add the cluster as a predictor variable

#combing test and train
all<-rbind(train,test)

#creating 5 clusters using K- means clustering

Cluster <- kmeans(all[,-101], 5)

## Add cluster as independent variable to the data set

all$cluster<-as.factor(Cluster$cluster)

#dividing the dataset into train and test
train<-all[1:2000,]
test<-all[2001:3000,]


#applying randomforest
model_rf<-randomForest(Y~.,data=train)


preds2<-predict(object=model_rf,test[,-101])

table(preds2)

auc(preds2,test$Y)
