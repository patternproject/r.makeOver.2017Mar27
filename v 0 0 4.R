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
pacman::p_load(stringr)


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

# read input
Secrets_of_Success <- read_excel("C:/Users/burhan.haq/Downloads/Perso/9. MakeOverMonday/13. Mar 27 - The Secret of Success/1. Data/Secrets of Success.xlsx")
#View(Secrets_of_Success)

# master copy
df.1 = Secrets_of_Success

# fixing col names
names(df.1) <- tolower(names(df.1))
names(df.1)[1] = "social.strata"

# changing rating to factor
df.1$social.strata <- as.factor(df.1$social.strata)
df.1$reason <- as.factor(df.1$reason)

# sorting by social.strate
df.2 <-
  df.1 %>%
  arrange (social.strata, rate) 
  
View(df.2)

df.2 %>%
  mutate(rate.2 = 100*rate,
         filler = 100-rate.2) -> df.3



df.3 %>% filter(social.strata=="Middle class") %>% select(reason,rate.2,filler) -> df.4
# df.3 %>% mutate(rate.2=100*rate, filler=100-rate.2) -> df.3
df.4 %>% filter(str_detect(reason,"abili"))-> df.5
df.5 %>% gather(key,value,-reason) -> df.6

# basic chart
# http://stackoverflow.com/questions/19265172/converting-two-columns-of-a-data-frame-to-a-named-vector
# whatyouwant <- (df.3$rate.2)
# names(whatyouwant) <- df.3$reason
# waffle(whatyouwant, rows=8)

namedVec.1 = df.6$value
names(namedVec.1) = df.6$key
#waffle(namedVec.1)
waffle(namedVec.1, size=1, colors=c("#1879bf","#969696"), legend_pos="none")

# looking for circle instead of square
fa_grep("circle")
waffle(
  namedVec.1,
  size = 1,
  colors = c("#E82C7D", "#E9E9EB"),
  legend_pos = "none",
  use_glyph = "circle"
)



# write back
write_csv(df.2,path = "df.2.csv")
  