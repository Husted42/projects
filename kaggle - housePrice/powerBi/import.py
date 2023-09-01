##### --- Imports --- #####
import sklearn
import pandas as pd

import matplotlib.pyplot as plt
import numpy as np

from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split #Data split
from sklearn.ensemble import GradientBoostingRegressor
import warnings
from sklearn.metrics import r2_score
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import median_absolute_error
from sklearn.metrics import max_error
from sklearn.metrics import PredictionErrorDisplay

from sklearn.neural_network import MLPRegressor

##### --- Functions --- #####
#Drop sleceted columns
def drop(f):
    dropCol = ["EnclosedPorch", "3SsnPorch", "ScreenPorch", "PoolArea", "MiscVal", "MoSold", "YrSold", "KitchenAbvGr", "LowQualFinSF"]
    for elm in dropCol:
        f.drop([elm], axis = 1, inplace=True)
    return f

#Replace the missing values
def replaceNa(f):
    f['LotFrontage'] = f['LotFrontage'].fillna(f['LotFrontage'].mean())
    f['MasVnrArea'] = f['MasVnrArea'].fillna(f['MasVnrArea'].mean())
    f['GarageYrBlt'] = f['GarageYrBlt'].fillna(f['GarageYrBlt'].mean())
    return f

#Convert datatypes
def convertData(f):
    f.astype({'MSSubClass': 'object'})
    f.astype({'BsmtHalfBath': 'object'})
    return f

#Log transformation
def logTransform(f):
    x = f.select_dtypes(include = ['float64', 'int64'])
    if 'SalePrice' in x:
        x.drop(['SalePrice'], axis = 1, inplace=True)
    for col in x:
        f[col] = np.log1p(f[col])
    return f

#Convert categorical data into dummy variables
def dummy(f):
    f = pd.get_dummies(f)
    return f

#Data scaling for nural network
def scale(f):
    scalerData = []
    x = f.select_dtypes(include = ['float64', 'int64'])
    if 'SalePrice' in x:
        x.drop(['SalePrice'], axis = 1, inplace=True)
    for col in x: scalerData.append(col)
    scaler = MinMaxScaler(feature_range=(0, 1))
    scaler.fit(f[scalerData])
    f[scalerData] = scaler.transform(f[scalerData])
    return f

#Drop features with little to no importance
def drop1(f):
    dropCol = ["LotFrontage", "MasVnrArea", "TotRmsAbvGrd", "BedroomAbvGr", "MSSubClass", "FullBath", "BsmtFinSF2", "HalfBath", "BsmtHalfBath"]
    for elm in dropCol:
        f.drop([elm], axis = 1, inplace=True)
    return f

##### --- Import data --- #####
dataset = pd.read_csv('C:/Users/alx/Documents/GitHub/projects/kaggle - housePrice/train.csv')
dataset.drop(['Id'], axis = 1, inplace=True)
print(dataset.head())


dataset = drop(dataset)
dataset = replaceNa(dataset)
dataset = convertData(dataset)
dataset = logTransform(dataset)
dataset['SalePrice'] = np.log1p(dataset['SalePrice'])
dataset = dummy(dataset)
print(dataset.head())