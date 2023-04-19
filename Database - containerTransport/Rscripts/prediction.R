#Create data frame
setwd("C:/C/github/code/projects/containerTransport/Rscripts")
print(getwd())
dataS <- read.csv(file = "emPredictionData.csv", header = FALSE, sep=",")
data <- head(dataS,-1)
data

df <- data.frame(
  X2 = as.numeric(c(data$V3)),
  X1 = as.numeric(c(data$V2)),
  Y = c(c(as.numeric(data$V4)) / c(as.numeric(data$V5)))
)

#fit multiple linear regression model
model <- lm(Y ~ X2 / X1, data = df)
summary(model)

#prediction
new <- data.frame(X1 = 164, X2 = 3)
prePerKM <- predict(model, newdata = new)
prePerKM * 6582

##### -- Plots -- ######
#goods amount X1
plot(df$X1, xlab = "route #", ylab = "amount of goods in tons", main = "goods_amount",
     pch = 16, cex = 2)

#estimated emmision X2
plot(df$X2, xlab = "route #", ylab = "emmision pr. km", main = "Estimated emmision",
     pch = 16, cex = 2)
abline(h = c(3, 4.5, 6, 7.5 , 9), lty = 2)

#real emmsion Y
plot(df$Y, xlab = "route #", ylab = "emmision pr. km", main = "Real emmision",
     pch = 16, cex = 2)
abline(h = c(3, 4.5, 6, 7.5 , 9), lty = 2)



