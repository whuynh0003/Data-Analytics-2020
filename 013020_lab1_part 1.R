multivariate <- read.csv(file.choose())
attach(multivariate)

help(lm)
mm <- lm(Homeowners~Immigrant) #lm(Dependent Var (Y) ~ Independent Var (X))
mm
summary(mm)
summary(mm)$coefficients
View(mm)
#Y = 107494 -6656(Immigrant)

plot(Homeowners~Immigrant) #plot(Dependent Var (Y) ~ Independent Var (X))

help(abline) #add straight lines to a plot
abline(mm)
abline(mm, col=2, lw=4)
abline(mm, col="blue", lw = 10)

plot(mtcars$wt, mtcars$mpg)
library(ggplot2)

qplot(mtcars$wt, mtcars$mpg)
qplot(wt, mpg, data=mtcars) #data="dataframe" - allows for plot names without $

help(qplot)
help(ggplot)

ggplot(mtcars, aes(x=wt, y=mpg))#creates axes; no points
ggplot(mtcars, aes(x=wt, y=mpg))+geom_point() #...+geom_point() - adds the points

plot(pressure$temperature, pressure$pressure, type='p')
#type = p_points, l_lines, b_both, there's more use help
help(plot)
lines(pressure$temperature, pressure$pressure) #creates the line only
points(pressure$temperature, pressure$pressure)
plot(pressure$temperature, pressure$pressure)

ggplot(pressure, aes(x=temperature, y=pressure))+geom_point()+geom_line()
help(geom_point)

qplot(temperature, pressure, data=pressure)+geom_line(col='red')+geom_point(col='blue')
help(geom_point)

View(BOD)
barplot(BOD$demand, names.arg = BOD$Time)
barplot(BOD$Time, names.arg = BOD$demand) #names.arg gives x axis values to use
barplot(BOD$Time)

hist(table(mtcars$cyl))
