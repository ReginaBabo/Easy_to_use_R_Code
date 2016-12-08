library(MASS)
library(ISLR)

data("Boston")
View(Boston)

lm.fit = lm(medv ~ lstat, data = Boston)
lm.fit

summary(lm.fit)
names(lm.fit)

coef(lm.fit)
coefficients(lm.fit)

confint(lm.fit)

## Confidence interval
predict(lm.fit,interval = "confidence")

## Prediction interval
predict(lm.fit,interval = "prediction")


