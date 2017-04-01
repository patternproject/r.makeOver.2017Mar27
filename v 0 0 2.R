# v 0 0 1: simple copy from last week (i.e wk 10 or Mar 6)
# v 0 0 2: setting the waffle chart. Removed all the examples, refer to it if required
# v 0 0 3: 

# set wd
setwd("C:/Users/burhan.haq/Downloads/Perso/9. MakeOverMonday/")

# import lib
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)
pacman::p_load(readxl)
pacman::p_load(waffle)
pacman::p_load(extrafont)
pacman::p_load(ggedit)

myfont <- "Ubuntu Mono"

# Iteration 1
# src: https://www.r-bloggers.com/pre-cran-waffle-update-isotype-pictograms/
# To use the FontAwesome glyphs you need to:
#   
#   grab the ttf version from here
# install it on your system
# install the extrafont package
# run font_import() (get some coffee/scotch while you wait)
# load extrafont when you need to use these glyphs
# font_import()
# and then
# extrafont::loadfonts(device="win")
# details here:
# http://stackoverflow.com/questions/14733732/cant-change-fonts-in-ggplot-geom-text


# current verison
packageVersion("waffle")

# basic example
parts <- c(80, 30, 20, 10)
waffle(parts, rows=8)

# or more elaborately
parts <- c(One=80, Two=30, Three=20, Four=10)
chart <- waffle(parts, rows=8)
print(chart)

# isotype pictogram
waffle(parts, rows=8, use_glyph="shield")

# slightly more complex example
parts <- c(`Un-breached\nUS Population`=(318-11-79), `Premera`=11, `Anthem`=79)
#waffle(parts/10, rows=3, colors=c("#969696", "#1879bf", "#009bda"), size=8)
waffle(parts/10, rows=3, colors=c("#969696", "#1879bf", "#009bda"),
       use_glyph="medkit", size=8)

# another example
professional <- c(`Male`=44, `Female (56%)`=56)
waffle(professional)
waffle(professional, rows=10, size=0.5, colors=c("#af9139", "#544616"))

# another example
iron(
  waffle(c(thing1=0, thing2=100), rows=5),  
  waffle(c(thing1=25, thing2=75), rows=5)
)

iron(
  waffle(c(thing1=0, thing2=100), rows=5, keep=FALSE),  
  waffle(c(thing1=25, thing2=75), rows=5, keep=FALSE)
)


# another example
pain.adult.1997 <- c(`YOY (406)`=406, `Adult (24)`=24)

A <- waffle(pain.adult.1997/2, rows=7, size=0.5, 
            colors=c("#c7d4b6", "#a3aabd"), 
            title="Paine Run Brook Trout Abundance (1997)", 
            xlab="1 square = 2 fish", pad=3)


pine.adult.1997 <- c(`YOY (221)`=221, `Adult (143)`=143)

B <- waffle(pine.adult.1997/2, rows=7, size=0.5, 
            colors=c("#c7d4b6", "#a3aabd"), 
            title="Piney River Brook Trout Abundance (1997)", 
            xlab="1 square = 2 fish", pad=8)

stan.adult.1997 <- c(`YOY (270)`=270, `Adult (197)`=197)

C <- waffle(stan.adult.1997/2, rows=7, size=0.5, 
            colors=c("#c7d4b6", "#a3aabd"), 
            title="Staunton River Trout Abundance (1997)", 
            xlab="1 square = 2 fish")

iron(A, B, C)


# read input
Secrets_of_Success <- read_excel("C:/Users/burhan.haq/Downloads/Perso/9. MakeOverMonday/13. Mar 27 - The Secret of Success/1. Data/Secrets of Success.xlsx")
View(Secrets_of_Success)

# master copy
df.1 = Secrets_of_Success

# fixing col names
names(df.1) <- tolower(names(df.1))
names(df.1)[1] = "social.strata"

# dropping useless cols
# df.1 <-
#   df.1 %>%
#   select(-user)

# changing rating to factor
df.1$social.strata <- as.factor(df.1$social.strata)
df.1$reason <- as.factor(df.1$reason)

# sorting by social.strate
df.2 <-
  df.1 %>%
  arrange (social.strata, rate) 
  


# write back
write_csv(df.2,path = "df.2.csv")
  