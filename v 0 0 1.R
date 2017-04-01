# set wd
setwd("C:/Users/burhan.haq/Downloads/Perso/9. MakeOverMonday/")

# import lib
library(tidyverse)
library(readxl)

# read input
Top_500_YouTube_Games_Channels <- read_excel("C:/Users/burhan.haq/Downloads/Perso/9. MakeOverMonday/10. Mar 6 YouTube Games/1. Data/Top 500 YouTube Games Channels.xlsx")

# master copy
df.1 = Top_500_YouTube_Games_Channels

# fixing col names
names(df.1) <- tolower(names(df.1))
names(df.1)[2] = "sb.score"
names(df.1)[6] = "video.views"

# dropping useless cols
df.1 <-
  df.1 %>%
  select(-user)

# changing rating to factor
df.1$rating <- as.factor(df.1$rating)

# check range for all numeric cols
select_if(df.1, is.numeric) %>% 
  map(range)

# plot multiple numeric columns in one go, using ggplot2 as plotting engine.
# srC: http://stackoverflow.com/questions/38184288/how-to-plot-multiple-factor-columns-with-ggplot
df.1 %>% 
  select_if(is.numeric) %>% 
  gather %>% 
  ggplot(aes(x = value)) + 
  geom_histogram(bins=5) + 
  facet_wrap(~key,scales = 'free') + 
  theme_bw()


# write back
write_csv(df.2,path = "df.2.csv")
  