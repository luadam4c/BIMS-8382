# Exercise 2

# Import libraries
library(readr)
library(dplyr)

# Import data
yDat <- read_csv('../data/brauer2007_tidy.csv')

## 2.1: Extract data where the gene ontology was "leucine biosynthesis"
#   and the limiting nutrient was "Leucine"
ex2.1 <- filter(yDat, bp == 'leucine biosynthesis'
                & nutrient == 'Leucine')

## 2.2: Arrange above by gene symbol
arrange(ex2.1, symbol)

## 2.3: View the result
View(arrange(ex2.1, symbol))
