# v 0 0 1: simple copy from last week (i.e wk 10 or Mar 6)
# v 0 0 2: setting the waffle chart. Removed all the examples, refer to it if required
# v 0 0 3: basic setup
# v 0 0 4: first plot, sucessfully done

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


# lambda function for purr::map
fn.1 = function(df)
{
  namedVec = df$value
  names(namedVec) = df$key
  return (namedVec)
}


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
df.1 %>%
  arrange (social.strata, rate) %>%
  mutate(rate.2 = 100 * rate,
         filler = 100 - rate.2) -> df.2

View(df.2)

df.2 %>%
  filter(str_detect(reason,"abili")) %>%
  select(social.strata,rate.2,filler) %>%
  gather(key,value,-social.strata) %>%
  arrange (social.strata) -> df.3

df.3 %>% 
  split(.$social.strata) %>% 
  map(fn.1) -> df.4

waffle(
  df.4$Poor,
  size = 1,
  colors = c("#E82C7D", "#E9E9EB"),
  legend_pos = "none" ,
  use_glyph = "circle"
) -> w.poor

w.poor

waffle(
  df.4$`Middle class`,
  size = 1,
  colors = c("#6B9CCB", "#E9E9EB"),
  legend_pos = "none",
  use_glyph = "circle"
) -> w.middle

w.middle

waffle(
  df.4$`Rich people`,
  size = 1,
  colors = c("#F47E13", "#E9E9EB"),
  legend_pos = "none",
  use_glyph = "circle"
) -> w.rich

w.rich

iron(w.poor,w.middle,w.rich)
  
  





# write back
write_csv(df.2,path = "df.2.csv")
  