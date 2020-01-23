help(data.frame)
EPI_data <- read.csv(file.choose())
attach(EPI_data)
EPI_data
View(EPI_data)
view(EPI_data) #View must be capitalized

help(fix)
fix(EPI_data) #case sepcific...fix =/ Fix
View(EPI_data)

head(EPI_data)
EPI_data2 <- read.csv(file.choose(), header = F)
head(EPI_data2)

EPI_data3 <-read.csv(file.choose(), header = F, skip = 1)
attach(EPI_data3)

EPI_data4 <-read.csv(file.choose(), skip = 1)
attach(EPI_data4)
EPI
View(EPI_data4)
EPI <- EPI_data4$EPI

help("is.na")
help("$")
tf <- (EPI)
E <-EPI[!tf]
View(tf)
View(E)
help("!")

EPI_data5 <- read.csv(2010EPI all countries_data""
)
