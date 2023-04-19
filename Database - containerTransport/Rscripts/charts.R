# Get library.
install.packages("plotrix")
library(plotrix)

#Create data frame
setwd("C:/C/github/code/projects/containerTransport/Rscripts")
print(getwd())
data <- read.csv(file = "pieChartData.csv", header = FALSE, sep=",")
data

#Defining variables
x <- c(as.numeric(data$V2))
labels <- c(data$V1)
percent <- round(100*x/sum(x), 1)

#Plots
pie(x, labels = percent, main = "Enviromental class distribution in %", col = rainbow(length(x)))
legend("topright", c(data$V1), cex = 0.8,
       fill = rainbow(length(x)))

pie3D(x, labels = labels,explode = 0.1, main = "Enviromental class distribution ")


