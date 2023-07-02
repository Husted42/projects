##### -- Setup -- #####
if(!require(ggplot2)){install.packages('ggplot2')}
library(ggplot2)

#GDP per capita (current US$) - https://data.worldbank.org/indicator/NY.GDP.PCAP.CD
df_original <- read.csv('C:/C/gitHub/code/R/visual/data/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_5447781.csv', 
                        header = TRUE, sep = ',', na.strings = c("NA"))

keep <- c("USA", "DEU", "SWE", "GBR", "NOR") #Keep contries
df_clean <- df_original[df_original$"Country.Code" %in% keep, ]
df_clean <- df_clean[c("Country.Name", "X2021")]

rownames(df_clean) <- NULL
seq(0, max(df_clean$X2021), by = 10000)

#Info
dim(df_clean)
names(df_clean)
sapply(df_clean, mode)

#plot barchart
ggplot(data = df_clean, aes(x=X2021, y=reorder(Country.Name, X2021))) +
  geom_bar(stat="identity", aes(fill = X2021)) +
  labs(title = "GDP Per Capita in Denmark's top export countries", x = "Counrty", y = "GDP per capita") +
  scale_fill_gradient(name = "GDP Per Capita") +
  scale_x_continuous(breaks = seq(0, max(df_clean$X2021), by = 10000)) +
  theme_light() +
  theme(legend.position = "none")

