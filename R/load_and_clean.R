# let's load and clean some data
# don't forget to set current working directory -- but not in code! why?

library(tidyverse)

# how can we look at the data?
View(diamonds)
head(diamonds)
tail(diamonds)

diamonds

# can we answer some questions?

# 1. How many diamonds of each color?
diamonds %>% group_by(color) %>% summarise(count=n())

# what did this do?
# variable diamonds
# what is a pipe?
# what is a group_by?
# summarise?

# pattern: split-apply-combine

# 2. How many diamonds of each cut and color?
# omit final print on first go, then explain what it does
diamonds %>% group_by(cut, color) %>% summarise(count=n()) %>% print(n=100)

# 3. mean price per carat
diamonds %>% summarize(ppc=mean(price/carat))
diamonds %>% group_by(size=cut_number(carat, 10)) %>% summarise(ppc=mean(price/carat))

# recap: don't freak out
# think about the pattern, not memorizing functions
# what you want to do probably has a name
# read R for Data Science; this session just about what you can do