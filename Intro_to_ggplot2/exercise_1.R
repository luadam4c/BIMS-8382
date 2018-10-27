# Exercise 1

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import gapminder data
gm <- read_csv('../data/gapminder.csv')

# Start with the ggplot() function using the gm data

# Create an aesthetic mapping of gdpPercap to the x-axis
#   and lifeExp to the y-axis
p <- ggplot(gm, aes(x = gdpPercap, y = lifeExp))
p

# Add points to the plot: Make the points size 3
#   and map continent onto the aesthetics of the point
p + geom_point(aes(color = continent), size = 3)

# Use a log10 scale for the x-axis
p <- p + scale_x_log10()
p + geom_point(aes(color = continent), size = 3)

