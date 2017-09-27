library(dplyr)
library(ggplot2)
#Explaining a few details used in the  larger analysis script
download.file('sdtaylor.github.io/dplyr/shrub_data.csv', 'shrub_data.csv')
shrubs = read.csv('shrub_data.csv')

##############################################
# functions. Nearly everything you do in R uses a function
# All functions have the format of the function name 
# followed by () with the function arguments. Nearly all
# functions then return some value.

# Mean is a function which takes a list of number as an argument
# and returns the mean value
mean(c(54,13,44,56))

# read.csv() is a function which takes a filename as an argument
# and returns a data.frame of that file
shrubs = read.csv('shrub_data.csv')


# You can create your own functions using the following form.
# 
# This function is called get_random_npp_data. It has a single
# argument, num_samples. It returns a dataframe with 2 variables,
# precip, and a correlated variable, npp.

get_random_npp_data = function(num_samples) {
  precip = rnorm(num_samples, mean=50, sd=10)
  npp = precip * 50 + rnorm(num_samples, mean=0, sd=100)
  
  df = data.frame(npp = npp,
                  precip = precip)

  return(df)
}

# Run the code above like normal to make the function available,
# and then call it like any other function

d = get_random_npp_data(num_samples = 500)


# What is the num_samples argument doing?

############################################
# Joins
# 
# joins allow you to take information in one data.frame, and
# associate it with info in another data.frame which shares a commmon
# variable.

# Say for our shrub data we want to have the mean shrub height of all
# sites to compare against the individual shrubs

mean_site_values = shrubs %>%
  group_by(site) %>%
  summarise(mean_height = mean(height), mean_width = mean(width), mean_length = mean(length)) 

# left_join takes 3 arguments. The first is the data.frame you want
# to begin with, the 2nd is the data.frame you want to pull information
# from, the 3rd is the common variable that they have in common

shrubs = left_join(shrubs, mean_site_values, by='site')


###############################################
#Broom package

# Statistical models are one of the best parts about R,
# but their output isn't very good when you want to save it all.
# 
# The broom package takes are of that by storing the model values
# into data.frame()

#As an example, make up some data to do a linear model
npp_data = get_random_npp_data(num_samples = 200)

model = lm(npp ~ precip, data=npp_data)

# The summary of the model provides output for interpretation
summary(model)
# But what if we want to save this output, and many other models, for comparison?
# Use  the broom package

# The tidy function cleans up model details into it's various parts
broom::tidy(model)
# The glance function cleans up the model summary statistics
broom::glance(model)

###################################################################
#for loops

# For loops are used to repeat the same task over and over with minor variations
sample_sizes = c(50, 200, 500)

# This for loop will, for each entry in the sample_size vector, get dataframe of
# npp values, build a linear model, and print the p.value of the model
for(sample_size in sample_sizes){
  npp_data = get_random_npp_data(num_samples = sample_size)
  model = lm(npp~precip, data=npp_data)
  
  print(broom::glance(model)$p.value)
}


###################################################################
# ggplot has become the defacto graphing package in R
# 
# It works with 2 primary concepts. The aesthetics of a graph (the size and 
# color of data points, the values of x and y axis, etc) and the geometries (points,
# lines, histograms, etc). 

# ggplot only accepts data.frame(), so for an example, put the made up data from 
# the precip~npp model into a data.frame for graphing

npp_data = data.frame(npp = npp,
                      precip = precip)

ggplot(npp_data, aes(x=precip, y=npp))
#This command made an empty plot. Why? 
#Because it defines the aesthetics of the plot, but not the geometries we want

ggplot(npp_data, aes(x=precip, y=npp)) +
  geom_point()

#ggplot uses a + symble to string together different aspects of the graph

