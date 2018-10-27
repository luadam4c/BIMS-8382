# Exercise 3

# Import libraries
library(readr)
library(dplyr)

# Import data
yDat <- read_csv('../data/brauer2007_tidy.csv')

## 3.1 Show the limiting nutrient and expression values for the gene ADH2
##      when the growth rate is restricted to 0.05
ex3.1 <-
    yDat %>%
    filter(symbol == 'ADH2' & rate == 0.05) %>%
    select(nutrient, expression)
ex3.1

## 3.2 What are the four most highly expressed genes when the growth rate
##      is restricted to 0.05 by restricting glucose?
ex3.2 <-
    yDat %>%
    filter(nutrient == 'Glucose', rate == 0.05) %>%
    arrange(desc(expression)) %>%
    head(4) %>%
    select(symbol, expression, bp, mf)
ex3.2

## 3.3 When the growth rate is restricted to 0.05,
##      what is the average expression level across all genes
##      in the "response to stress" biological process,
##      separately for each limiting nutrient?
##      What about genes in the "protein biosynthesis"
##      biological process?
ex3.3.1 <-
    yDat %>%
    filter(rate == 0.05 & bp == "response to stress") %>%
    group_by(nutrient) %>%
    summarise(meanexp = mean(expression))
ex3.3.1

ex3.3.2 <-
    yDat %>%
    filter(rate == 0.05 & bp == "protein biosynthesis") %>%
    group_by(nutrient) %>%
    summarise(meanexp = mean(expression))
ex3.3.2
# Note: These answers are wrong because they disregard entries
#   with an asterisk after

# ex3.3.3 <-
#     yDat %>%
#     filter(rate == 0.05 & bp == "^response to stress") %>%
#     group_by(nutrient) %>%
#     summarise(meanexp = mean(expression))
# ex3.3.3
