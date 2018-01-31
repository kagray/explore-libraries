01\_explore-libraries\_spartan.R
================
spgkentgray
Wed Jan 31 14:32:47 2018

Which libraries does R search for packages?

``` r
library(fs)
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
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

``` r
.libPaths()
```

    ## [1] "/Users/spgkentgray/Library/R/3.4/library"                      
    ## [2] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"

I noticed that the .Library and .libPaths do not match. Using the fs package we can see that the real path is not putting to the linked path

``` r
path_real(.Library)
```

    ## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

Installed packages

``` r
## use installed.packages() to get all installed packages
myPkgs <- installed.packages()
## how many packages?
nrow(myPkgs)
```

    ## [1] 361

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

## what are the column names?
colnames(installed.packages())
```

    ##  [1] "Package"               "LibPath"              
    ##  [3] "Version"               "Priority"             
    ##  [5] "Depends"               "Imports"              
    ##  [7] "LinkingTo"             "Suggests"             
    ##  [9] "Enhances"              "License"              
    ## [11] "License_is_FOSS"       "License_restricts_use"
    ## [13] "OS_type"               "MD5sum"               
    ## [15] "NeedsCompilation"      "Built"

``` r
myPkgs %>% 
  tbl_df() %>% 
  count(LibPath,Priority)
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
myPkgs %>% 
  tbl_df() %>% 
  count(NeedsCompilation) %>% 
  mutate(prop = n/sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                 191 0.529 
    ## 2 yes                157 0.435 
    ## 3 <NA>                13 0.0360

``` r
##   * how break down re: version of R they were built on

myPkgs %>% 
  tbl_df() %>% 
  count(Built) %>% 
  mutate(prop = n/sum(n))
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
#NO

## study package naming style (all lower case, contains '.', etc
installed.packages() %>% 
  tbl_df() %>% 
  select(Package) %>% 
  c()
```

    ## $Package
    ##   [1] "acs"                      "AnnotationDbi"           
    ##   [3] "babynames"                "benchmarkme"             
    ##   [5] "benchmarkmeData"          "Biobase"                 
    ##   [7] "BiocGenerics"             "BiocInstaller"           
    ##   [9] "choroplethr"              "choroplethrMaps"         
    ##  [11] "clisymbols"               "colourpicker"            
    ##  [13] "combinat"                 "corpcor"                 
    ##  [15] "dataMaid"                 "DBI"                     
    ##  [17] "dbplyr"                   "desc"                    
    ##  [19] "devtools"                 "dplyr"                   
    ##  [21] "drat"                     "efficientTutorial"       
    ##  [23] "enc"                      "fs"                      
    ##  [25] "gdtools"                  "genetics"                
    ##  [27] "GeneticsPed"              "ggbiplot"                
    ##  [29] "ggplot2"                  "gh"                      
    ##  [31] "giphyr"                   "here"                    
    ##  [33] "ini"                      "insertImage"             
    ##  [35] "IRanges"                  "kableExtra"              
    ##  [37] "knitr"                    "LMERConvenienceFunctions"
    ##  [39] "magick"                   "maptools"                
    ##  [41] "oaColors"                 "oaPlots"                 
    ##  [43] "odbc"                     "officer"                 
    ##  [45] "poissontris"              "printr"                  
    ##  [47] "profvis"                  "proj4"                   
    ##  [49] "pwr"                      "rbenchmark"              
    ##  [51] "rematch2"                 "ReporteRs"               
    ##  [53] "ReporteRsjars"            "repurrrsive"             
    ##  [55] "rgdal"                    "rgeos"                   
    ##  [57] "RODBC"                    "RSQLServer"              
    ##  [59] "rvg"                      "S4Vectors"               
    ##  [61] "servr"                    "sf"                      
    ##  [63] "styler"                   "svglite"                 
    ##  [65] "tigris"                   "udunits2"                
    ##  [67] "units"                    "usethis"                 
    ##  [69] "uuid"                     "WDI"                     
    ##  [71] "whoami"                   "xaringan"                
    ##  [73] "zip"                      "acepack"                 
    ##  [75] "addinslist"               "animation"               
    ##  [77] "ArgumentCheck"            "assertthat"              
    ##  [79] "backports"                "base"                    
    ##  [81] "base64enc"                "BH"                      
    ##  [83] "bindr"                    "bindrcpp"                
    ##  [85] "bit"                      "bit64"                   
    ##  [87] "bitops"                   "blob"                    
    ##  [89] "bookdown"                 "boot"                    
    ##  [91] "brew"                     "broman"                  
    ##  [93] "broom"                    "callr"                   
    ##  [95] "car"                      "carData"                 
    ##  [97] "caTools"                  "cellranger"              
    ##  [99] "checkmate"                "checkpoint"              
    ## [101] "chron"                    "class"                   
    ## [103] "classInt"                 "cli"                     
    ## [105] "clipr"                    "cluster"                 
    ## [107] "coda"                     "codetools"               
    ## [109] "colorspace"               "colourpicker"            
    ## [111] "compiler"                 "condvis"                 
    ## [113] "cranlogs"                 "crayon"                  
    ## [115] "cronR"                    "crosstalk"               
    ## [117] "curl"                     "d3heatmap"               
    ## [119] "data.table"               "datasets"                
    ## [121] "DBI"                      "debugme"                 
    ## [123] "dendextend"               "DEoptimR"                
    ## [125] "devEMF"                   "devtools"                
    ## [127] "dichromat"                "digest"                  
    ## [129] "diptest"                  "doParallel"              
    ## [131] "dotCall64"                "dplyr"                   
    ## [133] "DT"                       "dygraphs"                
    ## [135] "e1071"                    "effects"                 
    ## [137] "ellipse"                  "estimability"            
    ## [139] "evaluate"                 "fields"                  
    ## [141] "flexdashboard"            "flexmix"                 
    ## [143] "forcats"                  "foreach"                 
    ## [145] "foreign"                  "formatR"                 
    ## [147] "Formula"                  "fpc"                     
    ## [149] "gapminder"                "gdalUtils"               
    ## [151] "gdata"                    "geosphere"               
    ## [153] "ggedit"                   "ggmap"                   
    ## [155] "ggplot2"                  "ggpmisc"                 
    ## [157] "ggrepel"                  "ggThemeAssist"           
    ## [159] "git2r"                    "glue"                    
    ## [161] "graphics"                 "grDevices"               
    ## [163] "grid"                     "gridBase"                
    ## [165] "gridExtra"                "grofit"                  
    ## [167] "gsubfn"                   "gtable"                  
    ## [169] "gtools"                   "HaploSim"                
    ## [171] "haven"                    "hexbin"                  
    ## [173] "highr"                    "Hmisc"                   
    ## [175] "hms"                      "htmlTable"               
    ## [177] "htmltools"                "htmlwidgets"             
    ## [179] "httpuv"                   "httr"                    
    ## [181] "igraph"                   "irlba"                   
    ## [183] "iterators"                "jpeg"                    
    ## [185] "jsonlite"                 "kernlab"                 
    ## [187] "KernSmooth"               "knitr"                   
    ## [189] "labeling"                 "labelled"                
    ## [191] "labelVector"              "Lahman"                  
    ## [193] "lattice"                  "latticeExtra"            
    ## [195] "lazyeval"                 "lazyWeave"               
    ## [197] "LCFdata"                  "leaflet"                 
    ## [199] "lightsout"                "lme4"                    
    ## [201] "lmerTest"                 "lpSolve"                 
    ## [203] "lpSolveAPI"               "lsmeans"                 
    ## [205] "lubridate"                "magrittr"                
    ## [207] "mapproj"                  "maps"                    
    ## [209] "mapview"                  "markdown"                
    ## [211] "MASS"                     "Matrix"                  
    ## [213] "MatrixModels"             "mclust"                  
    ## [215] "memoise"                  "methods"                 
    ## [217] "mgcv"                     "microbenchmark"          
    ## [219] "mime"                     "miniUI"                  
    ## [221] "minqa"                    "mnormt"                  
    ## [223] "modelr"                   "modeltools"              
    ## [225] "multcomp"                 "munsell"                 
    ## [227] "mvtnorm"                  "networkD3"               
    ## [229] "nlme"                     "nloptr"                  
    ## [231] "NLP"                      "NMF"                     
    ## [233] "nnet"                     "nycflights13"            
    ## [235] "onion"                    "openssl"                 
    ## [237] "OpenStreetMap"            "packrat"                 
    ## [239] "pacman"                   "pairsD3"                 
    ## [241] "pander"                   "parallel"                
    ## [243] "pbkrtest"                 "PBSmodelling"            
    ## [245] "pedigree"                 "pedigreemm"              
    ## [247] "pillar"                   "pixiedust"               
    ## [249] "pkgconfig"                "pkgmaker"                
    ## [251] "PKI"                      "plogr"                   
    ## [253] "plyr"                     "png"                     
    ## [255] "polynom"                  "prabclus"                
    ## [257] "praise"                   "processx"                
    ## [259] "proto"                    "pryr"                    
    ## [261] "psych"                    "purrr"                   
    ## [263] "quantreg"                 "questionr"               
    ## [265] "R.methodsS3"              "R.oo"                    
    ## [267] "R.utils"                  "R6"                      
    ## [269] "rappdirs"                 "raster"                  
    ## [271] "rasterVis"                "RColorBrewer"            
    ## [273] "Rcpp"                     "RcppArmadillo"           
    ## [275] "RcppEigen"                "RcppRoll"                
    ## [277] "RCurl"                    "readr"                   
    ## [279] "readxl"                   "registry"                
    ## [281] "rematch"                  "reprex"                  
    ## [283] "reshape"                  "reshape2"                
    ## [285] "rgdal"                    "rgl"                     
    ## [287] "RgoogleMaps"              "rJava"                   
    ## [289] "rjson"                    "RJSONIO"                 
    ## [291] "rlang"                    "rmarkdown"               
    ## [293] "rngtools"                 "robustbase"              
    ## [295] "RODBC"                    "rpart"                   
    ## [297] "rprojroot"                "RPushbullet"             
    ## [299] "rsconnect"                "RSQLite"                 
    ## [301] "rstudioapi"               "rticles"                 
    ## [303] "rvest"                    "sandwich"                
    ## [305] "satellite"                "scales"                  
    ## [307] "scatterD3"                "scatterplot3d"           
    ## [309] "selectr"                  "sendmailR"               
    ## [311] "shiny"                    "shinyAce"                
    ## [313] "shinyBS"                  "shinydashboard"          
    ## [315] "shinyjs"                  "shinythemes"             
    ## [317] "slam"                     "SnowballC"               
    ## [319] "sourcetools"              "sp"                      
    ## [321] "spam"                     "SparseM"                 
    ## [323] "spatial"                  "splines"                 
    ## [325] "splus2R"                  "sqldf"                   
    ## [327] "stats"                    "stats4"                  
    ## [329] "stringi"                  "stringr"                 
    ## [331] "survey"                   "survival"                
    ## [333] "taRifx"                   "tcltk"                   
    ## [335] "testthat"                 "TH.data"                 
    ## [337] "threejs"                  "tibble"                  
    ## [339] "tidyr"                    "tidyselect"              
    ## [341] "tidyverse"                "tm"                      
    ## [343] "tools"                    "trimcluster"             
    ## [345] "utf8"                     "utils"                   
    ## [347] "viridis"                  "viridisLite"             
    ## [349] "webshot"                  "whisker"                 
    ## [351] "withr"                    "wordcloud"               
    ## [353] "xfun"                     "xlsx"                    
    ## [355] "xlsxjars"                 "XML"                     
    ## [357] "xml2"                     "xtable"                  
    ## [359] "xts"                      "yaml"                    
    ## [361] "zoo"

``` r
### no '.' all seem to have different naming conventions

## use `fields` argument to installed.packages() to get more info and use it!
installed.packages(fields = 'URL') %>% 
  tbl_df() %>% 
  mutate(github = grepl("github", URL)) %>% 
  count(github) %>% 
  mutate(prop = n/sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 F        200 0.554
    ## 2 T        161 0.446
