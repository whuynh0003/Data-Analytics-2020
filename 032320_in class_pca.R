data('iris')
head(iris)

irisdata1 <- iris[,1:4]
head(irisdata1)

principal_component <- princomp(irisdata1, cor = T, score = T)
summary(principal_component)

plot(principal_component)
plot(principal_component, type = 'l')
biplot(principal_component)

###############################
library(MASS)
data(Boston, package = "MASS")

summary(Boston)
str(Boston)
head(Boston)

pca_out <- prcomp(Boston, scale = T)
pca_out
summary(pca_out)
plot(pca_out)
biplot(pca_out, scale = 0)

View(pca_out)
View(pca_out$x)

boston_pc <- pca_out$x
boston_pc
head(boston_pc)
summary(boston_pc)

############################

data("USArrests")
View(USArrests)

states = row.names(USArrests)
states
names(USArrests)

summary(USArrests)
apply(USArrests, 2, mean) #1 = row, 2 = col.
apply(USArrests, 2, var)

pr.out = prcomp(USArrests, scale = T)
names(pr.out)
summary(pr.out)

#center & scale show mean & sd variable prior
#to implement in pca
pr.out$center
pr.out$scale

#rotation matrix gives princ comp. loadings
#each col contains corresponding comp. loading vector
#here we see 4 distinct components
pr.out$rotation

dim(pr.out$x)

biplot(pr.out, scale = 0)

#variance explained by each princ. comp
#by squaring sdev
pr.var = pr.out$sdev^2
pr.var

#get proportion vari. explained by each 
#principal comp., we divide variance
#by each princ. comp. by total variance
#explained by all 4 princ. comp.
pve <-pr.var/sum(pr.var)
pve

