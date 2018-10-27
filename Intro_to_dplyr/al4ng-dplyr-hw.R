# Advanced Data Manipulation Homework
# http://bims.fun/r-dplyr-homework.html

# Import libraries
library(readr)
library(dplyr)

# Import data
gm <- read_csv('../data/gapminder.csv')
gm

# 1. How many unique countries are represented per continent?
hw1 <-
    gm %>%
    group_by(continent) %>%
    summarise(n = n_distinct(country))
hw1

# 2. Which European nation had the lowest GDP per capita in 1997?
hw2 <-
    gm %>%
    filter(continent == "Europe" & year == 1997) %>%
    arrange(gdpPercap) %>%
    head(1)
hw2
# Answer: Albania

# 3. According to the data available, what was the average life
#      expectancy across each continent in the 1980s?
hw3 <-
    gm %>%
    filter(year >= 1980 & year < 1990) %>%
    group_by(continent) %>%
    summarize(mean_lifeExp = mean(lifeExp))
hw3

# 4. What 5 countries have the highest total GDP over all years
#      combined?
hw4 <-
    gm %>%
    mutate(gdp = pop * gdpPercap) %>%
    group_by(country) %>%
    summarize(Total.GDP = sum(gdp)) %>%
    arrange(desc(Total.GDP)) %>%
    head(5)
hw4

# 5. What countries and years had life expectancies of at least
#      80 years? N.b. only output the columns of interest:
#      country, life expectancy and year (in that order).
hw5 <-
    gm %>%
    filter(lifeExp >= 80) %>%
    select(country, lifeExp, year)
hw5

# 6. What 10 countries have the strongest correlation (in either
#      direction) between life expectancy and per capita GDP?
hw6 <-
    gm %>%
    group_by(country) %>%
    summarise(cor = cor(lifeExp, gdpPercap)) %>%
    arrange(desc(abs(cor))) %>%
    head(10)
hw6

# 7. Which combinations of continent (besides Asia) and year have
#      the highest average population across all countries?
#      N.b. your output should include all results sorted by
#      highest average population.
hw7 <-
    gm %>%
    filter(continent != "Asia") %>%
    group_by(continent, year) %>%
    summarise(mean.Pop = mean(pop)) %>%
    arrange(desc(mean.Pop))
hw7

# 8. Which three countries have had the most consistent population
#      estimates (i.e. lowest standard deviation) across the years
#      of available data?
hw8 <-
    gm %>%
    group_by(country) %>%
    summarise(sd.pop = sd(pop)) %>%
    arrange(sd.pop) %>%
    head(3)
hw8

# 9. Which observations indicate that the population of a country
#       has decreased from the previous year and the life expectancy
#       has increased from the previous year?
hw9 <-
    gm %>%
    group_by(country) %>%
    filter(pop < lag(pop, order_by = year) &
            lifeExp > lag(lifeExp, order_by = year))
hw9
