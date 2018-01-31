#' ---
#' output: github_document
#' ---
library(fs)
library(tidyverse)
#' Which libraries does R search for packages?

.Library
.libPaths()
#' I noticed that the .Library and .libPaths do not match.  Using the fs package we can see that the real path is not putting to the linked path
path_real(.Library)
#' Installed packages

## use installed.packages() to get all installed packages
myPkgs <- installed.packages()
## how many packages?
nrow(myPkgs)

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

## what are the column names?
colnames(installed.packages())

myPkgs %>% 
  tbl_df() %>% 
  count(LibPath,Priority)

##   * what proportion need compilation?
myPkgs %>% 
  tbl_df() %>% 
  count(NeedsCompilation) %>% 
  mutate(prop = n/sum(n))
##   * how break down re: version of R they were built on

myPkgs %>% 
  tbl_df() %>% 
  count(Built) %>% 
  mutate(prop = n/sum(n))


#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
#NO

## study package naming style (all lower case, contains '.', etc
installed.packages() %>% 
  tbl_df() %>% 
  select(Package) %>% 
  c()

### no '.' all seem to have different naming conventions

## use `fields` argument to installed.packages() to get more info and use it!
installed.packages(fields = 'URL') %>% 
  tbl_df() %>% 
  mutate(github = grepl("github", URL)) %>% 
  count(github) %>% 
  mutate(prop = n/sum(n))
