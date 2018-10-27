# Exercise 4

# Import libraries
library(readr)
library(dplyr)

# Import data
yDat <- read_csv('../data/brauer2007_tidy.csv')

## 4.1 Which 10 biological process annotations have the most genes
##      associated with them? What about molecular functions?
ex4.1.1 <-
    yDat %>%
    group_by(bp) %>%
    summarize(n = n_distinct(symbol)) %>%
    arrange(desc(n)) %>%
    head(10)
ex4.1.1
ex4.1.2 <-
    yDat %>%
    group_by(mf) %>%
    summarize(n = n_distinct(symbol)) %>%
    arrange(desc(n)) %>%
    head(10)
ex4.1.2

## 4.2 How many distinct genes are there where we know what process
##      the gene is involved in but we don't know what it does?
ex4.2.1 <-
    yDat %>%
    filter(bp != "biological process unknown" &
               mf == "molecular function unknown") %>%
    select(symbol, bp) %>%
    distinct()
ex4.2.1
# Instructor's Answer: 737
# Is that correct? What if the same gene has two biological processes?
ex4.2.2 <-
    yDat %>%
    filter(bp != "biological process unknown" &
               mf == "molecular function unknown") %>%
    summarize(n_distinct(symbol))
ex4.2.2
# Correct Answer: 709

## 4.3 When the growth rate is restricted to 0.05 by limiting Glucose,
##      which biological processes are the most upregulated?
##      Show a sorted list with the most upregulated BPs on top,
##      displaying the biological process and the average expression
##      of all genes in that process rounded to two digits.
ex4.3 <-
    yDat %>%
    filter(nutrient == 'Glucose', rate == 0.05) %>%
    group_by(bp) %>%
    summarise(meanexp = mean(expression)) %>%
    mutate(meanexp = round(meanexp, 2)) %>%
    arrange(desc(meanexp))
ex4.3

## 4.4 Group the data by limiting nutrient (primarily) then by
##      biological process. Get the average expression for all genes
##      annotated with each process, separately for each limiting
##      nutrient, where the growth rate is restricted to 0.05.
##      Arrange the result to show the most upregulated processes
##      on top.
ex4.4 <-
    yDat %>%
    filter(rate == 0.05) %>%
    group_by(nutrient, bp) %>%
    summarise(meanexp = mean(expression)) %>%
    arrange(desc(meanexp))
ex4.4

## 4.5 Get only the top three most upregulated biological processes
##      for each limiting nutrient.
ex4.5 <-
    ex4.4 %>%
    filter(row_number() <= 3)
ex4.5
?row_number

## 4.6 For the same groupings by limiting nutrient (primarily) then by
##      biological process, summarize the correlation between rate
##      and expression. Show the number of distinct genes within
##      each grouping.
ex4.6 <-
    yDat %>%
    group_by(nutrient, bp) %>%
    summarize(r = cor(rate, expression), ngenes = n_distinct(symbol))
ex4.6
# What do the results from 1 distinct gene represent?

## 4.7 Continue to process the result to show only results where
##      the process has at least 5 genes. Add a column corresponding
##      to the absolute value of the correlation coefficient, and
##      show for each nutrient the singular process with the highest
##      correlation between rate and expression, regardless of
##      direction
ex4.7 <-
    ex4.6 %>%
    filter(ngenes >= 5) %>%
    mutate(absr = abs(r)) %>%
    arrange(desc(absr)) %>%
    filter(row_number() == 1)
ex4.7
