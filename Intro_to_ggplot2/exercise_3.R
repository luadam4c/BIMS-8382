# Exercise 3

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import gapminder data
gm <- read_csv('../data/gapminder.csv')

# Make a jittered strip plot of GDP per capita against continent
p <- ggplot(gm, aes(x = continent, y = gdpPercap))
p + geom_jitter()

# Make a box plot of GDP per capita against continent
p + geom_boxplot()

# Using a log10 y-axis scale, overlay semitransparent jittered points
#   on top of box plots, where outlying points are colored
p + scale_y_log10() +
    geom_boxplot(outlier.color = 'red') +
    geom_jitter(alpha = 0.5)
# How to prevent boxplots from replotting outliers??

# Try to reorder the continents on the x-axis by GDP per capita
#   Why isn't this working as expected?
?reorder
p2 <- ggplot(gm, aes(x = reorder(continent, gdpPercap),
                     y = gdpPercap))
p2 + scale_y_log10() +
    geom_boxplot(outlier.color = 'red') +
    geom_jitter(alpha = 0.5)
# Perhaps the mean gdpPercap is already in ascending order


