# Introduction to dplyr
# 2018-02-19
# Instructor: V. P. Nagraj
# http://bims.fun/r-dplyr-yeast.html

# Import readr
library(readr)

# Import data
yDat <- read_csv('../data/brauer2007_tidy.csv')

# Make sure it's a data frame
info <- class(yDat)
type <- info[3]

# The tibble attribute makes the printing more succinct
yDat
# as.data.frame(yDat)

# Open the data frame for viewing
View(yDat)

# Summary statistics for the data frame
summary(yDat)

# Structure information for the data frame
str(yDat)

# Import dplyr
library(dplyr)

# List all the variables and first few values
glimpse(yDat)

# Comparison operators
#   !=  not equal to\
#   |   or
#   &   and

# filter() extracts rows of a given condition
filter(yDat, symbol == "LEU1")
class(yDat$symbol)

# Use OR or AND operators
filter(yDat, symbol == "LEU1" | symbol == 'ADH2')
filter(yDat, symbol == "LEU1" & rate == 0.3)
filter(yDat, symbol == "LEU1" | rate == 0.05)

# One could get an empty tibble if the case is wrong
filter(yDat, symbol == "LEU1" & nutrient == 'glucose')
filter(yDat, symbol == "LEU1" & nutrient == 'Glucose')

# Extract and write
leuDat <- filter(yDat, nutrient == "Leucine" &
                    bp == "leucine biosynthesis")
write_csv(leuDat, "leucinedata.csv")

# select() extracts certain columns
select(yDat, symbol, bp, mf)

# Remove certain columns
noGo <- select(yDat, -bp, -mf)

# Extracts contiguous columns
select(yDat, systematic_name:rate)

# mutate() adds a column
mutate(noGo, signal = 2^expression)
mutate(noGo, signal = 2^expression,  sigsr = sqrt(signal))

# arrange() sorts according to a specific column
#   Default order is ascending
arrange(yDat, symbol)
arrange(yDat, desc(expression))

# Sort more than one column
arrange(yDat, desc(expression), rate)

# summarize() reduces multiple values down to a single value
#   summarise() also works
summarize(yDat, mean(expression))
mean(yDat$expression)

# Pass in a proper column name
summarize(yDat, meanexp = mean(expression))
summarize(yDat, r = cor(rate, expression))

# Pass in helper functions
# n() retrieves the number of rows
summarize(yDat, n())

# group_by() adds a grouping to a data frame
group_by(yDat, nutrient)
group_by(yDat, nutrient, rate)

# A new data type can be returned
class(group_by(yDat, nutrient, rate))

# Pipe operator
#   %>%

# Combine dplyr functions
summarize(
    group_by(yDat, symbol),
    meanexp = mean(expression)
)
summarize(
    group_by(yDat, nutrient),
    r = cor(rate, expression)
)

# Piping
tail(yDat, 5)
yDat %>% tail(5)
filter(yDat, nutrient == 'Leucine')
yDat %>% filter(nutrient == 'Leucine')
arrange(mutate(summarise(group_by(filter(yDat, bp == "leucine biosynthesis"), nutrient), r = cor(rate, expression)), r = round(r, 2)), r)
res <-
    yDat %>%
    filter(bp == "leucine biosynthesis") %>%
    group_by(nutrient) %>%
    summarise(r = cor(rate, expression)) %>%
    mutate(r = round(r, 2)) %>%
    arrange(r)
# Note: piping is designed for legibility, not for performance
#   Use the data.table package for performance

# Retrieve the number of distinct values for a variable
yDat %>%
    summarize(n_distinct(mf))

# Extracts columns based on a condition
select_if(yDat, is.character)
select_if(yDat, is.numeric)
