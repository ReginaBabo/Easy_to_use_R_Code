install.packages("foreign")
library(foreign)

ml <- read.dta("http://www.ats.ucla.edu/stat/data/hsbdemo.dta")
head(ml)

summary(ml)

ml$prog2 <- relevel(ml$prog, ref = "academic")

install.packages("nnet")
library(nnet)

test <- multinom(prog2 ~ ses + write, data = ml)

summary(test)

z <- summary(test)$coefficients/summary(test)$standard.errors

z

p <- (1 - pnorm(abs(z), 0, 1))*2

p

exp(coef(test))

test <- multinom(prog2 ~ ., data = ml[,-c(1,5,13)])

summary(test)

head(fitted(test))

expanded=expand.grid(female=c("female", "male", "male", "male"),
                     ses=c("low","low","middle", "high"),
                     schtyp=c("public", "public", "private", "private"),
                     read=c(20,50,60,70),
                     write=c(23,45,55,65),
                     math=c(30,46,76,54),
                     science=c(25,45,68,51),
                     socst=c(30, 35, 67, 61),
                     honors=c("not enrolled", "not enrolled", "enrolled","not enrolled"),
                     awards=c(0,0,3,0,6) )

head(expanded)

predicted=predict(test,expanded,type="probs")

head(predicted)

