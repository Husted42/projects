if(!require(ggplot2)){install.packages('ggplot2')}

library(tidyverse)

#Denmark Norway and Sweden
#GDP per capita (current US$) - https://data.worldbank.org/indicator/NY.GDP.PCAP.CD
df_original <- read.csv('path/data/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_5447781.csv', 
                        header = TRUE, sep = ',', na.strings = c("NA"))
df_original

##### -- Clean -- #####
keep <- c("Denmark", "Norway", "Sweden")
df_clean <- df_original[df_original$"Country.Name" %in% keep, ] #Keep Denmark, Norway and Sweden

reqd = c()
for (i in 0:9){
  reqd[i+1] = paste("X", as.character(2012 + i), sep="")
}
df_clean <- subset(df_clean, select = reqd) #Keep only last 10 years

colnames(df_clean) <- c(1:10)
years <- seq(2012, 2021)
df_clean <- rbind(years, df_clean) #Add years to top
df_clean <- data.frame(t(df_clean[-1])) #Transpose
colnames(df_clean) <- c("year", keep) 



##### -- ggPlot (lm) -- #####
df <- df_clean %>%
  gather(key = "country", value = "value", -year) #From wide to long

df["value"] <- df["value"] / 1000

df %>%
  ggplot(aes(x = year, y = value, color = country)) +
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dotted") +
  labs(title = "GDP per capita",
       x = "Year",
       y = "current US$ (Thousands)",
       color = "Country") +
  scale_x_continuous(breaks = seq(min(df$year), max(df$year), by = 1)) +
  theme_light()
