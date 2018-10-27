# How to tidy data
# 2018-02-26
# Instructor: V. P. Nagraj
# http://bims.fun/r-tidy.html

# Load libraries
library(readr)
library(dplyr)
library(tidyr)

## Heart rate data
# #Load messy heart rate data
hr <- read_csv("../data/heartrate2dose.csv")
hr

# Use gather() when there are columns that are not variables.
?gather

# List all variables to convert to values
hr %>%
    gather(key = drugdose, value = hr,
           a_10, a_20, b_10, b_20, c_10, c_20)

# Give a range for the variables:
hr %>%
    gather(key = drugdose, value = hr, a_10:c_20)

# Skip certain variables:
hr %>%
    gather(key = drugdose, value = hr, -name)

# Use separate() when a variable is actually more than one variables
?separate

# Create a new data.frame
#   into dictates how to separate the variable;
#   sep is the delimiter for separating the values
hrtidy <-
    hr %>%
    gather(key = drugdose, value = hr, -name) %>%
    separate(drugdose, into = c("drug", "dose"), sep = "_")
hrtidy

# Optionally, view it
# View(hrtidy)

# Analyze the tidied data
hrtidy %>%
    filter(drug == "a")
hrtidy %>%
    filter(name!="joe") %>%
    group_by(drug, dose) %>%
    summarize(meanhr=mean(hr))

## Yeast data
# Load tidied data
ydat <- read_csv("../data/brauer2007_tidy.csv")

# Load original messy data
yorig <- read_csv("../data/brauer2007_messy.csv")
View(yorig)
yorig

# Separate the NAME column
yorig %>%
    separate(NAME, into=c("symbol", "systematic_name", "somenumber"),
             sep="::")

# Get rid of extraneous columns
yorig %>%
    separate(NAME, into=c("symbol", "systematic_name", "somenumber"), sep="::") %>%
    select(-GID, -YORF, -somenumber, -GWEIGHT)

# Convert nutrient-rates from variables to values
yorig %>%
    separate(NAME, into=c("symbol", "systematic_name", "somenumber"), sep="::") %>%
    select(-GID, -YORF, -somenumber, -GWEIGHT) %>%
    gather(key = nutrientrate, value = expression, G0.05:U0.3)

# Separate nutrients from rates and store to ynogo (no gene ontology)
ynogo <- yorig %>%
    separate(NAME, into=c("symbol", "systematic_name", "somenumber"), sep="::") %>%
    select(-GID, -YORF, -somenumber, -GWEIGHT) %>%
    gather(key = nutrientrate, value = expression, G0.05:U0.3) %>%
    separate(nutrientrate, into = c("nutrient", "rate"), sep=1)
ynogo

# Import gene ontology information
sn2go <- read_csv("../data/brauer2007_sysname2go.csv")

# Take a look
# View(sn2go)
head(sn2go)

# Use inner_join() to combine two tables
yjoined <- inner_join(ynogo, sn2go, by = "systematic_name")
# View(yjoined)
yjoined

# The glimpse function makes it possible to see a little bit of everything in your data.
glimpse(yjoined)

# Create a dictionary for nutrient labels
nutrientlookup <-
    data_frame(nutrient = c("G", "L", "N", "P", "S", "U"),
               nutrientname = c("Glucose", "Leucine", "Ammonia",
                                "Phosphate", "Sulfate", "Uracil"))
nutrientlookup

# Convert rate to numeric
yjoined <-
    yjoined %>%
    mutate(rate = as.numeric(rate))
yjoined

# Make sure missing values are coded properly (NA)
yjoined <-
    yjoined %>%
    mutate(symbol = ifelse(symbol == "NA", NA, symbol))
yjoined

# Add a column for nutrientname at the very right
yjoined <-
    yjoined %>%
    left_join(nutrientlookup)
yjoined

# Remove the column of single-letter nutrient names
yjoined <-
    yjoined %>%
    select(-nutrient)
yjoined

# Reorder columns
yjoined <-
    yjoined %>%
    select(symbol:systematic_name, nutrient = nutrientname, rate:mf)
yjoined

# Look at what's different from tidied data
anti_join(yjoined, ydat)

# Get rid of rows with missing expression data
yjoined <-
    yjoined %>%
    filter(!is.na(expression))
nrow(yjoined)

# Make sure the result is identical to tidied data
all.equal(ydat, yjoined)

# all.equal can also return the rows that are different
nutrientlookup2 <-
    data_frame(nutrient = c("L", "G", "N", "P", "S", "U"),
               nutrientname = c("leucine", "Glucose", "Ammonia",
                                "Phosphate", "Sulfate", "Uracil"))

all.equal(nutrientlookup2, nutrientlookup)

# diffobj has even better comparison tools
library(diffobj)
diffPrint(nutrientlookup2, nutrientlookup)

