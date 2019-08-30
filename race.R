library(tidyverse)

conditions <- read_csv('Conditions3.csv')
results <- read_csv('Results3.csv')

summary(results)

# Looks like driver and name and trainer all have character classes. Let's first change them to factors.
results <- results %>%
  mutate_if(is_character, as_factor)

# Looks like the race positions are wrong. Let's create a new column with the correct positions.
results <- results %>% 
  group_by(racenum, date) %>% 
  arrange(seconds) %>%
  mutate(id = row_number()) %>%
  ungroup() %>% 
  arrange(date, racenum)

# Let's check the distribution of the seconds for the races
# Looks like there are races that took longer than 140 seconds. They aren't too alarming so we will keep them for now.
results %>% ggplot(aes(seconds))+geom_density()

# Let's drill down on the distribution of the winning times using our correct id column
results %>% filter(id == 1) %>% ggplot(aes(seconds))+geom_density()

# Wait ... some winners won the race with over 140 seconds? That's alarming now.
results %>% filter(seconds >= 140) %>% View()

# Looks like it's just one race. Race #4 on this date 2016-03-04. It's clearly an outlier, so I'll remove it since if I want to do a regression,
# this outlier might add some unnecessary bias.

# TODO

# How often are the odds correct on predicting the winner? If the odds are smaller, you win less because the chance of that 
# horse winning was too big.
results <- results %>% 
  group_by(racenum, date) %>% 
  arrange(odds) %>%
  mutate(odds_id = row_number()) %>%
  ungroup() %>% 
  arrange(date, racenum)

# Let's count how many races the odds were correct
results %>% filter(odds_id == 1, id == 1) %>% nrow()

# 159 ! Out of how many?
results %>% select(racenum,date) %>% distinct() %>% nrow()

# 463 ! 

# Wow, a third of the time the odds actually predict the correct winner. This is gonna be hard to make money, because 
# you have to bet aggains the odds to really make money

# Lets see how much money I would of made if I had only betted on #1 with 100$ each bet.

bet_outcomes <- results %>% filter(id == 1) %>% mutate(race_profit = if_else(id == odds_id, 100*odds,-100))

bet_outcomes %>% summarise(end_amount = sum(race_profit))

# Ouch thats not good. What if we only play it safe? We bet if the odds are lower than 1 (safe)

bet_outcomes <- results %>% filter(id == 1) %>% mutate(race_profit = if_else(odds<=1,if_else(id==odds_id,odds*100,-100),0))

bet_outcomes %>% summarise(end_amount = sum(race_profit))

plot(cumsum(bet_outcomes$race_profit))


## Different strategy, playing it safe.

# Let's check what the distribution of the best odds for each race look like:
results %>% filter(odds_id==1) %>% ggplot(aes(odds))+geom_density()


bet_outcomes2 <- results %>% filter(odds_id == 1,
                   odds <= 1) %>% mutate(race_profit = if_else(id == 1,100*odds,-100))

plot(cumsum(bet_outcomes2$race_profit))
# Still not a good strategy.


# risky strategy - only bet if the smallest odds are over 1.5

bet_outcomes3 <- results %>% filter(odds_id == 1,
                                    odds >= 1.5) %>% mutate(race_profit = if_else(id == 1,100*odds,-100))

plot(cumsum(bet_outcomes3$race_profit))

# Thats actualy interesting! Not a good strategy, but interesting.


# What we know so far, is that a third of the time the odds predicted the correct winner. But if take into account dollars you make vs what
# you loose, we quickly see that we would probably have needed to fille for banruptcy.

# What we are doing here is coding up some rules. We are naively trying to figure out good decision rules to either place a bet or not.
# We are creating a decision tree in our head and coding it. Let's use the algorithm to make the best splits!

# Notice, we have one issue here. We have races! We can't just run a normal decision tree, the race horces need to be grouped together.

# Unique Id -> name + driver + trainer

results <- results %>% 
  mutate(unique_id = as_factor(paste(name,driver,trainer,sep = '_'))) %>%
  group_by(unique_id) %>%
  mutate(unique_id_avg_time = mean(seconds)) %>%
  ungroup()

# Great, now we can compute a new id for which horse would win first just based on their average performances.

results <- results %>% 
  group_by(racenum, date) %>% 
  arrange(unique_id_avg_time) %>%
  mutate(id_2 = row_number()) %>%
  ungroup() %>% 
  arrange(date, racenum)

# filter race winners, 
bet_outcomes4 <- results %>% filter(id == 1) %>% mutate(race_profit = if_else(id == id_2, 100*odds,-100))

bet_outcomes4 %>% summarise(end_amount = sum(race_profit))

plot(cumsum(bet_outcomes4$race_profit))


# Let's split the data up to a specific date. let's say 70/30, so there are 43 dates. that means 
dates <- results %>% select(date) %>% distinct()
dates[30,]

train_data <- results %>% filter(date < '2016-03-14')
test_data <- results %>% filter(date >= '2016-03-14')

# Create a data frame of average times.
avg_time_df <- train_data %>% 
  mutate(unique_id = as_factor(paste(name,driver,trainer,sep = '_'))) %>%
  group_by(unique_id) %>%
  mutate(unique_id_avg_time_r = mean(seconds)) %>% ungroup() %>% select(unique_id,unique_id_avg_time_r) %>% distinct()

avg_time_df_horse <- train_data %>% 
  mutate(unique_id = as_factor(paste(name,driver,trainer,sep = '_'))) %>%
  group_by(name) %>%
  mutate(unique_id_avg_time_h = mean(seconds)) %>% ungroup() %>% select(unique_id,unique_id_avg_time_h) %>% distinct()

#

vvv <- left_join(test_data,avg_time_df,by='unique_id')

left_join(test_data,avg_time_df_horse,by='unique_id')





