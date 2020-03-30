data("iris")

head(iris)
str(iris)

library(ggplot2)
library(e1071)

attach(iris)

qplot(Petal.Length, Petal.Width, data = iris, color = Species)

help(svm)

#Model 1
svm_model1 <- svm(Species~., data = iris)
summary(svm_model1)

plot(svm_model1, data = iris, Petal.Width~Petal.Length, 
     slice = list(Sepal.Width = 3, Sepal.Length = 4))

pred1 <- predict(svm_model1, iris)
table1 <- table(Predicted = pred1, Actual = iris$Species)
table1 

model1_accuracy <- sum(diag(table1))/sum(table1)
model1_accuracy

model1_misclassfication <- 1 - model1_accuracy
model1_misclassfication

#Model 2
svm_model2 <- svm(Species~., data = iris, 
                  kernel = "linear")
summary(svm_model2)

pred2 <- predict(svm_model2, iris)
table2 <- table(Predicted = pred2, Actual = Species)
table2

model2_acc <- sum(diag(table2))/sum(table2)
model2_acc

model2_misclass <- 1 - model2_acc
model2_misclass

#Model3
svm_model3 <- svm(Species~., data = iris, 
                  kernel = 'polynomial')

plot(svm_model3, data = iris, Petal.Length~Petal.Width, 
     slice = list(Sepal.Width = 3, Sepal.Length = 4))

pred3 <- predict(svm_model3, iris)
table3 <- table(Predicted = pred3, Actual = Species)
table3

model3_acc <- sum(diag(table3))/sum(table3)
model3_acc

model3_misclass <- 1 - model3_acc
model3_misclass
