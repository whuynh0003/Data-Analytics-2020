library(rpart)
library(rpart.plot)
library(titanic)

data("titanic_train")
T_train <- titanic_train

T_train <- titanic_train[,c(2, 3, 5, 6)]
head(T_train)

#rpart
Titanic_rpart <- rpart(Survived~., T_train, method = "class")
rpart.plot(Titanic_rpart)

#ctree
require(party)

T_train$Sex <- as.numeric(as.factor(T_train$Sex))

str(T_train)

Titanic_ctree <- ctree(Survived~., T_train)
plot(Titanic_ctree)

#hclust
library(stats)
set.seed(12345)

titanic_dist <- dist(T_train)
titanic_hclust <- hclust(titanic_dist, method ="complete")

plot(titanic_hclust)
rect.hclust(titanic_hclust, k = 5, border = 2:6)

#random forest
library(randomForest)

titanic_RandForest <- cforest(Survived~., T_train)
titanic_RandForest
