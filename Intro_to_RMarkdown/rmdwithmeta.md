---
title: "Gapminder Analysis"
author: "Stephen Turner"
date: "January 1, 2017"
output: pdf_document
---

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
## # A tibble: 6 x 6
##   country  continent  year lifeExp      pop gdpPercap
##   <chr>    <chr>     <int>   <dbl>    <int>     <dbl>
## 1 Zimbabwe Africa     1982    60.4  7636524       789
## 2 Zimbabwe Africa     1987    62.4  9216418       706
## 3 Zimbabwe Africa     1992    60.4 10704340       693
## 4 Zimbabwe Africa     1997    46.8 11404948       792
## 5 Zimbabwe Africa     2002    40.0 11926563       672
## 6 Zimbabwe Africa     2007    43.5 12311143       470
```


```r
library(knitr) 
kable(head(gm)) 
```



|country     |continent | year| lifeExp|      pop| gdpPercap|
|:-----------|:---------|----:|-------:|--------:|---------:|
|Afghanistan |Asia      | 1952|  28.801|  8425333|  779.4453|
|Afghanistan |Asia      | 1957|  30.332|  9240934|  820.8530|
|Afghanistan |Asia      | 1962|  31.997| 10267083|  853.1007|
|Afghanistan |Asia      | 1967|  34.020| 11537966|  836.1971|
|Afghanistan |Asia      | 1972|  36.088| 13079460|  739.9811|
|Afghanistan |Asia      | 1977|  38.438| 14880372|  786.1134|

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
##  [5] R6_2.2.2         rlang_0.1.6      highr_0.6        stringr_1.2.0   
##  [9] tools_3.4.3      utf8_1.1.3       cli_1.0.0        htmltools_0.3.6 
## [13] yaml_2.1.16      assertthat_0.2.0 rprojroot_1.3-2  digest_0.6.15   
## [17] tibble_1.4.2     crayon_1.3.4     bindrcpp_0.2     codetools_0.2-15
## [21] rsconnect_0.8.8  glue_1.2.0       evaluate_0.10.1  rmarkdown_1.9   
## [25] stringi_1.1.6    compiler_3.4.3   pillar_1.1.0     backports_1.1.2 
## [29] pkgconfig_2.0.1
```

# Make a figure


```r
library(ggplot2) 
ggplot(gm, aes(gdpPercap, lifeExp)) + geom_point() 
```

![Life Exp vs GDP](figure/unnamed-chunk-5-1.png)

# Make another figure


```r
library(ggplot2) 
ggplot(gm, aes(gdpPercap, lifeExp)) +  
geom_point() +  
scale_x_log10() +  
aes(col=continent) 
```

![Life Exp vs GDP](figure/unnamed-chunk-6-1.png)

# Options

* echo: (TRUE by default) whether to include R source code in the output file.
* results takes several possible values:
    * markup (the default) takes the result of the R evaluation and turns it into markdown that is rendered as usual.
    * hide will hide results.
    * hold will hold all the output pieces and push them to the end of a chunk. Useful if you’re running commands that result in lots of little pieces of output in the same chunk.
    * asis writes the raw results from R directly into the document. Only really useful for tables.
* include: (TRUE by default) if this is set to FALSE the R code is still evaluated, but neither the code nor the results are returned in the output document.
* fig.width, fig.height: used to control the size of graphics in the output.


```r
# R code here 
```
