# Exercise 4

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import gapminder data
gm <- read_csv('../data/gapminder.csv')

# Plot a histogram of GDP Per Capita
p <- ggplot(gm, aes(gdpPercap))
p + geom_histogram()

# Do the same but use a log10 x-axis
p + scale_x_log10() + geom_histogram()

# Still on the log10 x-axis scale, try a density plot mapping
#   continent to the fill of each density distribution, and
#   reduce the opacity
p + scale_x_log10() + geom_density(aes(fill = continent), alpha = 1/4)

# Still on the log10 x-axis scale, make a histogram faceted by
#   continent and filled by continent. Facet with a single column
pFinal <-
    p + scale_x_log10() + geom_histogram(aes(fill = continent)) +
    facet_wrap(~ continent, ncol = 1)
pFinal
?facet_wrap

# Save this figure to a 6x10 PDF file
ggsave(plot = pFinal, file = 'gdppercap_by_continent.pdf', width = 6, height = 10)

