# let's look at a different data set, one that requires actual data cleaning...
library(tidyverse)

df <- read_csv("https://raw.githubusercontent.com/pearsonlab/legal/master/data/combined_data.csv")


df <- read_csv("https://raw.githubusercontent.com/pearsonlab/legal/master/data/combined_data.csv",
               col_types=cols(
                 .default=col_factor(),
                 rating=col_number(),
                 age=col_number()))
View(df)
spec(df)

# load scenario descriptions:
desc <- read_csv("https://raw.githubusercontent.com/pearsonlab/legal/master/data/scenario_classification.csv", col_types=cols(Scenario=col_factor()))

# factors aren't necessarily picked in the order we want (they're done in order of appearance)
# so let's relevel physical evidence
df <- df %>% mutate(physical=fct_relevel(physical, "No Physical", after=0),
                    scenario=fct_relevel(scenario, as.character(seq(1, 33))))

# let's plot mean rating by crime/scenario
mean_ratings <- df %>% group_by(scenario) %>% 
  summarise(rating=mean(rating)) %>% 
  select(scenario, rating) %>% 
  arrange(rating) %>%
  inner_join(desc, by=c("scenario" = "Scenario"))

ggplot(mean_ratings) + geom_point(aes(x=`Crime type`, y=rating))
ggplot(mean_ratings) + geom_point(aes(x=`Crime type`, y=rating)) + coord_flip()
ggplot(mean_ratings) + geom_point(aes(x=fct_reorder(`Crime type`, rating), y=rating)) + coord_flip()

# regression?
mod <- lm(rating ~ -1 + scenario + physical + history + witness, data=df)
summary(mod)
