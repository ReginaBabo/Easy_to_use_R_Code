library(ggplot2)
install.packages("GGally")
library(GGally)
install.packages("CCA")
library(CCA)

mm <- read.csv("http://www.ats.ucla.edu/stat/data/mmreg.csv")
head(mm)
colnames(mm) <- c("Control", "Concept", "Motivation", "Read", "Write", "Math", "Science", "Sex")
summary(mm)

xtabs(~Sex, data = mm)
table(mm$Sex)

psych = mm[,1:3]
acad = mm[,4:8]

ggpairs(psych)
ggpairs(acad)

matcor(psych, acad)

cc1 <- cc(psych, acad)

cc1$cor

cc1[3:4]

