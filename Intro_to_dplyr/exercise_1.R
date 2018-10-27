# Exercise 1

# Import libraries
library(readr)
library(dplyr)

# Import data
yDat <- read_csv('../data/brauer2007_tidy.csv')

## 1.1: Extract data where the gene ontology was "leucine biosynthesis"
#   and the limiting nutrient was "Leucine"
ex1.1 <- filter(yDat, bp == 'leucine biosynthesis'
       & nutrient == 'Leucine')

## 1.2 Extract the genes with an expression in the top 1%
# Get the 99% quantile for expression value
expressionQ99 <- quantile(yDat$expression, probs = 0.99)

# Extract the genes with expression greater than the 99th quantile
ex1.2 <- filter(yDat, expression > expressionQ99)
View(ex1.2)

# These genes seem to have to do with metabolism
#   or the response to stress
