
##### -- Packages -- #####
#install.packages("ggplot2")
#install.packages("map")
#install.packages("tidyverse")

##### -- Libaries -- #####
if(!require(ggplot2)){install.packages('ggplot2')}
if(!require(tidyverse)){install.packages('tidyverse')}

##### -- Load data -- #####
#GDP per capita (current US$) - https://data.worldbank.org/indicator/NY.GDP.PCAP.CD
df_original <- read.csv('path/data/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_5447781.csv', 
                        header = TRUE, sep = ',', na.strings = c("NA"))
df_original

##### -- Clean data -- #####
colnames(df_original)
reqd <- c("Country.Name", "X2017", "X2021")
reqd
df_clean <- subset(df_original, select = reqd) #
df_clean <- na.omit(df_clean) #Remove rows with NA
df_clean

##### -- Calculate increase -- #####
vec2017 <- df_clean$"X2017" #Turn col into vectors
vec2021 <- df_clean$"X2021"

vec_increase <- (vec2021 - vec2017) / vec2021 * 100 #Calculate increase in pct 
df_increase <- subset(df_clean, select = ("Country.Name")) 
df_increase$increase <- vec_increase #Add vector to dataframe
# - View(df_increase)

##### -- Map -- #####
mapData <- map_data("world") #ggplot2


#Fit names manually
countyNames1 <- (unique(mapData["region"]))
countyNames2 <- (unique(df_increase["Country.Name"]))

#write.csv(countyNames1, "C:/C/gitHub/code/R/visual/mapDataRegion.csv", row.names=FALSE)
#write.csv(countyNames2, "C:/C/gitHub/code/R/visual/df_increaseCountryName.csv", row.names=FALSE)

df_increase[df_increase$"Country.Name" == "United Kingdom", "Country.Name"] <- "UK"
df_increase[df_increase$"Country.Name" == "United States", "Country.Name"] <- "USA"
df_increase[df_increase$"Country.Name" == "Bahamas, The", "Country.Name"] <- "Bahamas"
df_increase[df_increase$"Country.Name" == "Brunei Darussalam", "Country.Name"] <- "Brunei"
df_increase[df_increase$"Country.Name" == "Cote d'Ivoire", "Country.Name"] <- "Ivory Coast"
df_increase[df_increase$"Country.Name" == "Russian Federation", "Country.Name"] <- "Russia"

df_increase <- df_increase[df_increase$"Country.Name" %in% mapData$"region", ] #Remove rows where country.name != region
df_increase

colnames(df_increase)[colnames(df_increase) == "Country.Name"] ="region" #Rename to make left_join work
mapData <- left_join(mapData, df_increase, by="region")

mapData$increase <- ifelse(mapData$increase < -50, -50, mapData$increase) #Fit min value to -50 or under
mapData$increase <- ifelse(mapData$increase > 50, 50, mapData$increase) #Fit max value to -50 or over

map1 <- ggplot(mapData, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = increase), color = "black") #Create map

map2 <- map1 + scale_fill_gradient(name = "Increase", low = "red", high =  "green", na.value = "grey50")+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        rect = element_blank())
print(map2 + ggtitle("Increase in GDP per capita from 2017 to 2021 \nFrom -50 or under to 50 or over"))



