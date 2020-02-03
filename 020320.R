library(ggplot2)
library(dplyr)
library(gcookbook)

df_mtcars <- mtcars
head(df_mtcars)

#nesting
filter(df_mtcars, mpg > 20)
sample_n(filter(df_mtcars, mpg >20), 10)
arrange(sample_n(filter(df_mtcars, mpg>20), 5), mpg)
#arrange default = ascending order => desc() for descending

#multiple assignments
a1 <- filter(df_mtcars, mpg>20)
a2 <- sample_n(a1, 5)
a3 <- arrange(a2, wt)
a3

#pipe operator
df_mtcars %>% filter(mpg>20) %>% sample_n(5) %>% arrange(mpg)
df_mtcars %>% filter(mpg >20) %>% sample_n(5) %>% arrange(desc(hp))

#multivariate
df_multi <- read.csv(file.choose())
attach(df_multi)

HP <- Homeowners/Population
PD <- Population/area
mm <- lm(formula = Immigrant ~ Income + Population +HP + DP )
mm
summary(mm)

cm <- coef(mm)
cm


attach(read.csv(file.choose()))

df_EPI <- attach(read.csv(file.choose(), skip=1))

View(df_EPI)

m_DALY <- df_EPI %>% filter(DALY, na.rm = T) %>% filter(EPI, na.rm = T) %>% 
  arrange(DALY, desc(EPI))

m_DALY <- filter(DALY, na.rm=T)
