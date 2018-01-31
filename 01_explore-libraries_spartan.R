#' ---
#' output: github_document
#' ---

#' Which libraries does R search for packages?
.Library
.libPaths()
library(fs)
path_real(.Library)
#' Installed packages

## use installed.packages() to get all installed packages
installed.packages()
## how many packages?
nrow(installed.packages())

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
library(tidyverse)
colnames(installed.packages())
installed.packages() %>% 
  tbl_df() %>% 
  group_by(LibPath,Priority) %>% 
  summarise(n = n())
##   * what proportion need compilation?
installed.packages() %>% 
  tbl_df() %>% 
  group_by(NeedsCompilation) %>% 
  summarise(n = n()) %>% 
  mutate(prop = n/sum(n))
##   * how break down re: version of R they were built on

installed.packages() %>% 
  tbl_df() %>% 
  group_by(Built) %>% 
  summarise(n = n()) %>% 
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
