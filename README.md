#### At what time lag are desert rodent species influence by precipitation?

In this project I'll be doing an analysis inspired by [Thibault et al. 2010](https://academic.oup.com/jmammal/article/91/4/787/965765/Long-term-insights-into-the-influence-of)
which uses the same dataset I'll use here. The dataset is a long term dataset
of monthly rodent surveys done in Southern Arizona. I encourage you to read 
more about it [here](https://github.com/weecology/PortalData).

For ~20 rodent species, I will calculate the correlation between different time
lags of precipitation. For example, if it rains in March, producing annual plant
growth, how long before a rodent species sees the benefits of that rain?

Specifically I will use a linear model with the monthly species abundance as the dependent
variable and the total precipitation from each of the prior 6 months as the independent
variables. Then I will use stepwise model selection with AIC to select the months
which best explain rodent abundance.

The analysis script is separated into various data cleaning and organizing steps and analysis steps.
