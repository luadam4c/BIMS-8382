# R_script_syntax.R
# Lists common R commands

# Documentation
?func
help(func)
example(func)     # show a usage example

# Logical values
T == TRUE
F == FALSE

# Operators
x <- 3                  # assignment

# Managing the Environment
rm(object)              # remove an object
ls()                    # list all objects
list.files()            # list all files
source("test.R")        # run a script
setwd()                 # set working directory

# Vectors
c(a, b)                 # concatenate or combine
seq()                   # construct a sequence
class()                 # get the data class

# Matrices
matrix()                # construct a matrix

# Data frames
data.frame()            # construct a data frame
dat$var                 # access a variable
dat[["var"]]            # another way to access a variable
head()                  # show the first 6 rows
tail()                  # show the last 6 rows

# Lists
list()                  # construct a list
names()                 # find out what's in a list

# Normal distribution
dnorm()                 # normal density
pnorm()                 # normal cumulative probability
qnorm()                 # normal quantile
rnorm()                 # random number from normal distribution

# Functions on numbers
sum()

# Functions on characters
rep('Yes! ', times = 3) # replicate elements of vectors and lists

# Plotting
?par

# Loops
# When you introduce a variable within the for-loop,
# R will not remember it when it has gotten out of the for-loop.
