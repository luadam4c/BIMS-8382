# Exercise 1

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import National Health and Nutrition Examination Survey data
#   https://www.cdc.gov/nchs/nhanes/index.htm
nh <- read_csv("../data/nhanes.csv")

# 1. What’s the mean 60-second pulse rate for all participants
#       in the data?
mean(nh$Pulse, na.rm = TRUE)

# 2. What’s the range of values for diastolic blood pressure in
#       all participants? (Hint: see help for  min(), max(),
#       and range() functions, e.g., enter ?range without the
#       parentheses to get help).
range(nh$BPDia, na.rm = TRUE)
min(nh$BPDia, na.rm = TRUE)
max(nh$BPDia, na.rm = TRUE)

# 3. What are the median, lower, and upper quartiles for the age
#       of all participants? (Hint: see help for median,
#       or better yet, quantile)
median(nh$Age, na.rm = TRUE)
?quantile
quantile(nh$Age, probs = seq(0, 1, 0.25), na.rm = TRUE)

# 4. What’s the variance and standard deviation for income among
#       all participants?
var(nh$Income, na.rm = TRUE)
sd(nh$Income, na.rm = TRUE)
?sd

