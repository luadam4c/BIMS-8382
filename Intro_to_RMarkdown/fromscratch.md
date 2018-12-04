# Introduction 
  
This is my first RMarkdown document! 
  
# Let's embed some R code 
  
Let's load the **Gapminder** data: 


```r
library(dplyr) 
library(readr) 
gm <- read_csv('../data/gapminder.csv') 
```

```
## Parsed with column specification:
## cols(
##   country = col_character(),
##   continent = col_character(),
##   year = col_integer(),
##   lifeExp = col_double(),
##   pop = col_integer(),
##   gdpPercap = col_double()
## )
```

```r
head(gm) 
```

```
## # A tibble: 6 x 6
##   country     continent  year lifeExp      pop gdpPercap
##   <chr>       <chr>     <int>   <dbl>    <int>     <dbl>
## 1 Afghanistan Asia       1952    28.8  8425333       779
## 2 Afghanistan Asia       1957    30.3  9240934       821
## 3 Afghanistan Asia       1962    32.0 10267083       853
## 4 Afghanistan Asia       1967    34.0 11537966       836
## 5 Afghanistan Asia       1972    36.1 13079460       740
## 6 Afghanistan Asia       1977    38.4 14880372       786
```

The mean life expectancy is 59.4744394 years. 

The years surveyed in this data include: 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997, 2002, 2007. 

# Session Information 


```r
sessionInfo() 
```

```
## R version 3.4.3 (2017-11-30)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
## 
## Matrix products: default
## 
## locale:
## [1] LC_COLLATE=Chinese (Traditional)_Taiwan.950 
## [2] LC_CTYPE=Chinese (Traditional)_Taiwan.950   
## [3] LC_MONETARY=Chinese (Traditional)_Taiwan.950
## [4] LC_NUMERIC=C                                
## [5] LC_TIME=Chinese (Traditional)_Taiwan.950    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] readr_1.1.1 dplyr_0.7.4 knitr_1.19 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.15     bindr_0.1        magrittr_1.5     hms_0.4.1       
##  [5] R6_2.2.2         rlang_0.1.6      stringr_1.2.0    tools_3.4.3     
##  [9] utf8_1.1.3       cli_1.0.0        htmltools_0.3.6  yaml_2.1.16     
## [13] assertthat_0.2.0 rprojroot_1.3-2  digest_0.6.15    tibble_1.4.2    
## [17] crayon_1.3.4     bindrcpp_0.2     glue_1.2.0       evaluate_0.10.1 
## [21] rmarkdown_1.9    stringi_1.1.6    compiler_3.4.3   pillar_1.1.0    
## [25] backports_1.1.2  pkgconfig_2.0.1
```
