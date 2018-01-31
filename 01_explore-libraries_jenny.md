01\_explore-libraries\_jenny.R
================
spgkentgray
Wed Jan 31 14:06:14 2018

``` r
## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for packages?

``` r
.libPaths()
```

    ## [1] "/Users/spgkentgray/Library/R/3.4/library"                      
    ## [2] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"

``` r
## let's confirm the second element is, in fact, the default library
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

``` r
library(fs)
path_real(.Library)
```

    ## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

Installed packages

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.2.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 361

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 4 x 3
    ##   LibPath                                                 Priority       n
    ##   <chr>                                                   <chr>      <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources… base          14
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources… recommend…    15
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources… <NA>         259
    ## 4 /Users/spgkentgray/Library/R/3.4/library                <NA>          73

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                 191 0.529 
    ## 2 yes                157 0.435 
    ## 3 <NA>                13 0.0360

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 4 x 3
    ##   Built     n  prop
    ##   <chr> <int> <dbl>
    ## 1 3.4.0   161 0.446
    ## 2 3.4.1    44 0.122
    ## 3 3.4.2    43 0.119
    ## 4 3.4.3   113 0.313

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ##   [1] "acepack"        "addinslist"     "animation"      "ArgumentCheck" 
    ##   [5] "assertthat"     "backports"      "base64enc"      "BH"            
    ##   [9] "bindr"          "bindrcpp"       "bit"            "bit64"         
    ##  [13] "bitops"         "blob"           "bookdown"       "brew"          
    ##  [17] "broman"         "broom"          "callr"          "car"           
    ##  [21] "carData"        "caTools"        "cellranger"     "checkmate"     
    ##  [25] "checkpoint"     "chron"          "classInt"       "cli"           
    ##  [29] "clipr"          "coda"           "colorspace"     "colourpicker"  
    ##  [33] "condvis"        "cranlogs"       "crayon"         "cronR"         
    ##  [37] "crosstalk"      "curl"           "d3heatmap"      "data.table"    
    ##  [41] "DBI"            "debugme"        "dendextend"     "DEoptimR"      
    ##  [45] "devEMF"         "devtools"       "dichromat"      "digest"        
    ##  [49] "diptest"        "doParallel"     "dotCall64"      "dplyr"         
    ##  [53] "DT"             "dygraphs"       "e1071"          "effects"       
    ##  [57] "ellipse"        "estimability"   "evaluate"       "fields"        
    ##  [61] "flexdashboard"  "flexmix"        "forcats"        "foreach"       
    ##  [65] "formatR"        "Formula"        "fpc"            "gapminder"     
    ##  [69] "gdalUtils"      "gdata"          "geosphere"      "ggedit"        
    ##  [73] "ggmap"          "ggplot2"        "ggpmisc"        "ggrepel"       
    ##  [77] "ggThemeAssist"  "git2r"          "glue"           "gridBase"      
    ##  [81] "gridExtra"      "grofit"         "gsubfn"         "gtable"        
    ##  [85] "gtools"         "HaploSim"       "haven"          "hexbin"        
    ##  [89] "highr"          "Hmisc"          "hms"            "htmlTable"     
    ##  [93] "htmltools"      "htmlwidgets"    "httpuv"         "httr"          
    ##  [97] "igraph"         "irlba"          "iterators"      "jpeg"          
    ## [101] "jsonlite"       "kernlab"        "knitr"          "labeling"      
    ## [105] "labelled"       "labelVector"    "Lahman"         "latticeExtra"  
    ## [109] "lazyeval"       "lazyWeave"      "LCFdata"        "leaflet"       
    ## [113] "lightsout"      "lme4"           "lmerTest"       "lpSolve"       
    ## [117] "lpSolveAPI"     "lsmeans"        "lubridate"      "magrittr"      
    ## [121] "mapproj"        "maps"           "mapview"        "markdown"      
    ## [125] "MatrixModels"   "mclust"         "memoise"        "microbenchmark"
    ## [129] "mime"           "miniUI"         "minqa"          "mnormt"        
    ## [133] "modelr"         "modeltools"     "multcomp"       "munsell"       
    ## [137] "mvtnorm"        "networkD3"      "nloptr"         "NLP"           
    ## [141] "NMF"            "nycflights13"   "onion"          "openssl"       
    ## [145] "OpenStreetMap"  "packrat"        "pacman"         "pairsD3"       
    ## [149] "pander"         "pbkrtest"       "PBSmodelling"   "pedigree"      
    ## [153] "pedigreemm"     "pillar"         "pixiedust"      "pkgconfig"     
    ## [157] "pkgmaker"       "PKI"            "plogr"          "plyr"          
    ## [161] "png"            "polynom"        "prabclus"       "praise"        
    ## [165] "processx"       "proto"          "pryr"           "psych"         
    ## [169] "purrr"          "quantreg"       "questionr"      "R.methodsS3"   
    ## [173] "R.oo"           "R.utils"        "R6"             "rappdirs"      
    ## [177] "raster"         "rasterVis"      "RColorBrewer"   "Rcpp"          
    ## [181] "RcppArmadillo"  "RcppEigen"      "RcppRoll"       "RCurl"         
    ## [185] "readr"          "readxl"         "registry"       "rematch"       
    ## [189] "reprex"         "reshape"        "reshape2"       "rgdal"         
    ## [193] "rgl"            "RgoogleMaps"    "rJava"          "rjson"         
    ## [197] "RJSONIO"        "rlang"          "rmarkdown"      "rngtools"      
    ## [201] "robustbase"     "RODBC"          "rprojroot"      "RPushbullet"   
    ## [205] "rsconnect"      "RSQLite"        "rstudioapi"     "rticles"       
    ## [209] "rvest"          "sandwich"       "satellite"      "scales"        
    ## [213] "scatterD3"      "scatterplot3d"  "selectr"        "sendmailR"     
    ## [217] "shiny"          "shinyAce"       "shinyBS"        "shinydashboard"
    ## [221] "shinyjs"        "shinythemes"    "slam"           "SnowballC"     
    ## [225] "sourcetools"    "sp"             "spam"           "SparseM"       
    ## [229] "splus2R"        "sqldf"          "stringi"        "stringr"       
    ## [233] "survey"         "taRifx"         "testthat"       "TH.data"       
    ## [237] "threejs"        "tibble"         "tidyr"          "tidyselect"    
    ## [241] "tidyverse"      "tm"             "translations"   "trimcluster"   
    ## [245] "utf8"           "viridis"        "viridisLite"    "webshot"       
    ## [249] "whisker"        "withr"          "wordcloud"      "xfun"          
    ## [253] "xlsx"           "xlsxjars"       "XML"            "xml2"          
    ## [257] "xtable"         "xts"            "yaml"           "zoo"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 F        200 0.554
    ## 2 T        161 0.446
