# let's make some plots to look at our data

library(tidyverse)

View(diamonds)

ggplot(data=diamonds) + geom_histogram(aes(x=color), stat="count")

ggplot(diamonds) + geom_histogram(aes(clarity), stat="count")

# whyyyyyy?
# ggplot is really weird if you're coming from Matlab
# grammar of graphics:
# 1. pick a data frame (always)
# 2. pick a geometry
#    1. which maps variables in df to aes(thetics)
#    2. if you need to change data, you pick a stat
#    3. you need to pick scales (map x, y, etc. to numbers)
# 3. `+` operation adds elements to plot
# ... you'll get used to it

ggplot(diamonds) + geom_histogram(aes(price))
ggplot(diamonds) + geom_histogram(aes(log10(price)))
ggplot(diamonds) + geom_histogram(aes(log10(price)), bins = 100)
ggplot(diamonds) + geom_histogram(aes((price)), bins = 100) + scale_x_log10()

ggplot(diamonds) + geom_point(aes(x=carat, y=price))
ggplot(diamonds) + geom_point(aes(x=carat, y=price), alpha=0.05)
ggplot(diamonds) + geom_hex(aes(x=carat, y=price))  # need to install hexbin by typing `install.packages("hexbin")` in console
ggplot(diamonds) + geom_hex(aes(x=carat, y=price), bins=100)
ggplot(diamonds) + geom_hex(aes(x=carat, y=price), bins=100) + scale_x_log10()
ggplot(diamonds) + geom_hex(aes(x=carat, y=price), bins=100) + scale_x_log10() + scale_y_log10()

# straight line on a log-log plot is power law!
ggplot(diamonds) + geom_hex(aes(x=carat, y=price), bins=100) + scale_x_log10() + scale_y_log10() +
  geom_smooth(aes(x=carat, y=price), method=lm, formula=y~x)

ggplot(diamonds) + geom_hex(aes(x=carat, y=price), bins=100) + scale_x_log10() + 
  scale_y_log10(limits=c(300, 20000)) +
  geom_smooth(aes(x=carat, y=price), method=lm, formula=y~x)

# how do other variables affect price?
ggplot(diamonds) + geom_boxplot(aes(x=cut, y=price))
ggplot(diamonds) + geom_boxplot(aes(x=color, y=price))
ggplot(diamonds) + geom_boxplot(aes(x=clarity, y=price))

# hmmmm... what if there's confounding?
ggplot(diamonds) + geom_boxplot(aes(x=cut, y=carat))
# ...etc.  

# let's color by cut
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + scale_x_log10() + 
  scale_y_log10(limits=c(300, 20000)) +
  geom_smooth(aes(x=carat, y=price), method=lm, formula=y~x)
  
ggplot(diamonds) + geom_hex(aes(x=carat, y=price, color=cut), bins=100) + scale_x_log10() + 
  scale_y_log10(limits=c(300, 20000)) +
  facet_wrap( ~ cut)

ggplot(diamonds) + geom_density(aes(x=carat, color=cut))
ggplot(diamonds) + geom_density(aes(x=carat, color=color))
ggplot(diamonds) + geom_density(aes(x=carat, color=clarity))
