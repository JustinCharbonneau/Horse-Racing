Data Science Interview Task
=============================

Spend one hour.

Using your choice of tool, prepare a report that answers the question and explains how you arrived at the answer, noting any potential issues, etc. Be prepared to discuss the choices you made, alternatives rejected, etc. when you come in to meet us.

The data is a series of times for the finishers of harness horse races in a variety of weather conditions. The data has been morphed to prevent identification of any individual horse, driver, etc. 

The file 'Conditions3.csv' has three fields:
temp - the temperature in C
cond - the track conditions
date - the date

The file 'Results3.csv' has nine fields:
racenum - the number of the race. Higher numbered races come later in the evening.
pos - the finishing position of the horse
hnum - the horse's number
odds - the decimal odds at post time (so odds of 7 to 2 would be shown in this field as 3.5)
date - the date
seconds - the time it took the horse to finish the race
name - the name of the horse
driver - the name of the driver
trainer - the name of the trainer

Note that the same set of morphed names has been used for horses, drivers and trainers independently. I.e. the driver 'Jake' is not the same as the trainer 'Jake.'


There is one more race, not in the Results3.csv file. It is the 9th race on 2016-04-29. The entries are

hnum   odds   name    driver    trainer
========================================
   1   34.8   Ramon   Asher     Moises 
   3   38.2   Jean    Penelope  Brynn  
   4    7.10  Bryson  Gabriella Kyleigh
   5   25.4   Gabriel Estrella  Elena  
   6    4.10  Anthony Theresa   Maurice
   7    3.25  Noe     Beau      Quincy 
   8   16.1   Johnny  Betty     Carol  
   9    0.500 Carter  Kody      Walter 

Note there is no horse number 2 in this race. Of course the weather/date/time of day and track conditions may affect the results. The task is for you to predict the winner. How sure are you....how much would you bet? 

I suggest spending 15 minutes loading and exploring the data, 15 minutes cleaning and plotting the data, 15 minutes building and running the predictive model, and 15 minutes writing the doc. 

Please send me your report at least 3 business days before your interview. Good luck!






