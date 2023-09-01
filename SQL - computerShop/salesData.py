##### --- Imports --- #####
import pandas as pd
import random


##### --- Variables --- #####
#Set max modelnumber values
maxLaptop = 1008
maxPC = 2010
maxKeyboard = 3006
maxMouse = 4004

# List of model numbers
laptopLst = list(range(1001, maxLaptop+1))
pcLst = list(range(2001, maxPC+1))
keyboardlst = list(range(3001, maxKeyboard+1))
mouseLst = list(range(4001, maxMouse+1))
samples = laptopLst + pcLst + keyboardlst + mouseLst

# Generate random possibility weights
weightList = random.sample(range(1,100), len(samples))

# Create empty dataframe
''' id(1, 2, 3....) model(2001, 2002...) orderDate(YYYY-MM-DD) '''
df = pd.DataFrame(columns = ['id', 'model', 'orderDate'])

#Generate random list of sales
salesList = random.choices(samples, weights = weightList, k = 1000)


##### --- Functions --- #####
''' Returns a random date '''
def genRandomDate():
    year = random.randint(2010, 2023)
    month = random.randint(1, 12)
    if month < 10: 
        month = '0' + str(month)
    day = random.randint(1,28)
    if day < 10: 
        day = '0' + str(day)
    year, month, day = str(year), str(month), str(day)
    return year + '-' + month + '-' + day 


##### --- Calls --- #####
#Append random sales to dataframe
for i in range(len(salesList)):
    df = df._append({'id' : i+1, 'model' : salesList[i], 'orderDate' : genRandomDate()}, ignore_index=True)

df.to_csv('salesData.csv', index=False)



