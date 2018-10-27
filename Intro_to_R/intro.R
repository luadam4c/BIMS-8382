# Introduction to R
# 2018-02-12
# Instructor: V. P. Nagraj
# http://bims.fun/r-basics.html
# http://bims.fun/r-dataframes.html

# Arithmetics
2 + 2
5 * 4
3 / 7
5^2 + 1
5^(2+1)

# Assignment of object
weight_kg <- 50
weight_kg = 50    # works but impairs code legibility

# Retrieve value of object
weight_kg

# Case matters
Weight_kg <- 49

# Don't override existing objects
data

# Pull up documentation
?t

# Assign value to existing function
t <- 2

# This retrieves assigned value
t

# Remove an object
rm(t)

# This retrieves internal matrix transpose function
t

# Tab completion
rm(Weight_kg)

# Make a new object dependent on the old one
weight_lb <- 2.2 * weight_kg

# Change old object to new value
weight_kg <-75

# Need to rerun code to update dependent object
weight_lb <- 2.2 * weight_kg

# Built-in functions
sqrt(144)
log(1000)

# Look for a different function with documentation
?log
help(log)
log10(1000)

# More verbose version
# May be necessary for optional arguments
log(x = 1000)

# Use more than one arguments
log(x = 1000, base = 10)

# Nest functions
sqrt(log10(1000))
sqrt(3)

# list all objects
ls()

# remove all objects
# rm(list = ls())

# Construct a vector
1:5
6:10
100:1000

# Operations on vectors are element by element
1:10 + 2
1:10 * 2:11

# If vector is different length , the "recycling method" is applied
#   on the shorter vector. A warning is printed only if the longer 
#   object length is not a multiple of the shorter object length
1:10 + 0:1
1:9 + 0:1

# Construct a vector by concatenation
c(1, 2, 5)
c(1:10, 25, 40:55)

# Sequence generation
?seq

# Construct a vector by using seq()
seq(from = 4, to = 40, by = 2)

# Assign an object to a vector
animal_weights <- c(50, 60, 65)

# Get length of a vector
length(animal_weights)

# Create character vectors
animals <- c("mouse", "rat", "dog")
animals2 = c('mouse', 'rat', 'dog')

# Get length of a vector
length(animals)

# You can get the mean from a numeric vector but not a character vector
mean(animal_weights)
mean(animals)

# Get what class
class(animal_weights)
class(animals)

# Create a large vector
x <- seq(from = 2, to = 200, by = 4)

# Get the 6th element
x[6]

# Indexing starts at 1
x[1]

# Get a part of a vector
x[6:10]

# A vector can only have a single data class
class(c(animals, animal_weights))

# Concatenation of numeric with character 
#   automatically converts numeric to character
combined = c(animals, animal_weights)

# Read in data
?read.table
# read.table('blah.csv', set = ',')
# read.csv('blah.csv')

# Use a better function from the package readr
# install.packages("readr")
library(readr)

# Read in the data with read_csv to a data frame
#   This is 10 times faster than read.csv
#   and allows for extraction and data type detection
ydat <- read_csv(file = '../data/brauer2007_tidy.csv')

# Get all the different classes associated with ydat
class(ydat)

# Print the first 6 rows
head(ydat)
head(ydat, 20)

# Print the last 6 rows
tail(ydat)

# Get the dimensions
dim(ydat)     # returns [nRows, nCols]
nrow(ydat)
ncol(ydat)

# Get the column names
names(ydat)
colnames(ydat)

# Summary statistics
summary(ydat)

# Structure of the data frame
str(ydat)

# Extract a specific column
ydat$symbol

# Do statistics on a specific column
mean(ydat$expression)

# load the gapminder demographics data
gm <- read_csv('../data/gapminder.csv')

# Compute the standard deviation of the life expectancy
sd(gm$lifeExp)

# Create a vector with a missing value
badlifeexp <- c(gm$lifeExp, NA)

# The standard deviation will be NA by default
sd(badlifeexp)

# You can remediate by adding an argument
sd(badlifeexp, na.rm = TRUE)

# Mean population
mean(gm$pop)

# Mean population in millions
mean(gm$pop / 1e6)

# Range of years
range(gm$year)

# Load the dplyr package
library(dplyr)

# Run a function from a specific package
?base::union
?dplyr::union

# Get parts of a data frame
#   dplyr::filter returns a data frame
filter(gm, lifeExp > 80)
filter(gm, gdpPercap < 500 & gm$year == 2007)

# Write filtered data frame to a file
ydatlb <- filter(ydat, bp == 'leucine biosynthesis')
write_csv(ydatlb, 'ydatlab.csv')
