# Performance comparison of pipes, no pips and temp variables

# Load library
library(dplyr)

# Use a built-in data set
starwars

# Find the mean mass of each species with pipes
starwars %>%
    group_by(species) %>%
    summarize(mean(mass))

# Find the mean mass of each species without pipes
summarize(group_by(starwars, species), mean(mass))

# Find the mean mass of each species with temp variables
tmp <- group_by(starwars, species)
summarize(tmp, mean(mass))

# Compare the performance with microbenchmark
microbenchmark::microbenchmark(
    pipe = starwars %>% group_by(species) %>% summarize(mean(mass)),
    nopipe = summarize(group_by(starwars, species), mean(mass)),
    temp_variables = {tmp <- group_by(starwars); summarize(starwars, mean(mass))}
)
