install.packages("mlr")
library(mlr)

################################################################################################################

####### Missing Value Imputation ###############################################################################

################################################################################################################

imp = impute(train, classes = list(factor = imputeMode(), integer = imputeMean()), dummy.classes = c("integer","factor"), dummy.type = "numeric")
imp1 = impute(test, classes = list(factor = imputeMode(), integer = imputeMean()), dummy.classes = c("integer","factor"), dummy.type = "numeric")

imp_train = imp$data
imp_test = imp$data


summarizeColumns(imp_train)
summarizeColumns(imp_test)

################################################################################################################

