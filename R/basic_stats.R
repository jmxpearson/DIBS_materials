# let's try some hypothesis testing

library(tidyverse)

View(diamonds)

model <- lm(log10(price) ~ log10(carat) + cut + color + clarity, data=diamonds)

summary(model)

anova(model)

# make some test data
test_df <- diamonds %>% expand(carat=quantile(diamonds$carat, probs=seq(0, 1, 0.05)), 
                               color,
                               cut,
                               clarity)

# predict at these data points
preds <- predict(model, test_df)

# add to data frame
test_df <- test_df %>% mutate(price=preds)

# now plot
ggplot(test_df) + geom_point(aes(x=carat, y=price, color=color)) + scale_x_log10() + scale_y_log10()
ggplot(test_df) + geom_point(aes(x=carat, y=price, color=cut)) + scale_x_log10() + scale_y_log10()
ggplot(test_df) + geom_point(aes(x=carat, y=price, color=clarity)) + scale_x_log10() + scale_y_log10()

ggplot(test_df) + geom_line(aes(x=carat, y=price, color=color)) + 
  scale_x_log10() + scale_y_log10() +
  facet_wrap(. ~ clarity)
