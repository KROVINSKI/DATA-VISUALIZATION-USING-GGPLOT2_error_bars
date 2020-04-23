##Hello World

## Author: https://www.datanovia.com/
## Notes: Kate Rovinski
## Title: DATA VISUALIZATION USING GGPLOT2
## Date: April 2020

# R script below follows the tutorial on how to assign error bars in GGplot

# Error Bars are used to visualize the variability of the plotted data. 
# Error Bars can be applied to graphs such as, 
#                                           Dot Plots, 
#                                           Barplots, or 
#                                           Line Graphs 
#                             to provide an additional layer of detail on the presented data.

#Generally, Error bars are used to show either the standard deviation, 
#                             standard error, confidence intervals or interquartile range.

# The length of an Error Bar helps reveal the uncertainty of a data point: 
#                             a short Error Bar shows that values are concentrated, 
#                             signalling that the plotted average value is more likely, 
#                             while a long Error Bar would indicate that the values 
#                                            are more spread out and less reliable.



#*********************************
##Libraries
#*********************************
library(ggplot2)
library(ggplot2)
theme_set(
  theme_classic() +
    theme(legend.position = "top")
)
library(dplyr)

#*********************************
## 1.) bringing in the data & checking dimensions
#*********************************

df <- ToothGrowth

dim(ToothGrowth)
# Expected Results
# > dim(ToothGrowth)
# [1] 60  3

df$dose <- as.factor(df$dose)
head(df,3)

#*********************************
## 2.) Summary Statistics
#*********************************
# Direction: Compute summary statistics for the variable len 
#            organized into groups by the variable dose:

# - - - - - - - - - - - - - - - - - - - - - - - - - | 
#   Group by                                        |
#   Group by one or more variables - Description    |
#                                                   |
# Most data operations are done on groups defined by|
# variables. group_by() takes an existing tbl and   |
# converts it into a grouped tbl where operations   |
# are performed "by group".                         |
# ungroup() removes grouping                        |
# - - - - - - - - - - - - - - - - - - - - - - - - - |


# - - - - - - - - - - - - - - - - - - - - - - - - - | 
#   Summarise                                       |
#   summarise {dplyr}                               |
#   Reduce multiple values down to a single value   |
#                                                   |
#   Description                                     |
#                                                   |
# Create one or more scalar variables summarizing   |
# the variables of an existing tbl. Tbls with       |
# groups created by group_by() will result in one   |
# row in the output for each group. Tbls with no    |
# groups will result in one row.                    |
#                                                   |
# - - - - - - - - - - - - - - - - - - - - - - - - - |

df.summary <- df %>%
  group_by(dose) %>%
  summarise(
    sd = sd(len, na.rm = TRUE),
    len = mean(len)
  )
df.summary

# Results
# A tibble: 3 x 3
#   dose     sd   len
#   <fct> <dbl> <dbl>
#[1] 0.5    4.50  10.6
#[2] 1      4.42  19.7
#[3] 2      3.77  26.1


#*********************************
## 3.) Key R functions
#*********************************

# Key R functions and error plot types
# Key functions to create error plots using the summary statistics data:

#geom_crossbar() for hollow bar with middle indicated by horizontal line
#geom_errorbar() for error bars
#geom_errorbarh() for horizontal error bars
#geom_linerange() for drawing an interval represented by a vertical line
#geom_pointrange() for creating an interval represented by a vertical line, with a point in the middle.



#*********************************
## 4.) Initializing the ggplot
#*********************************
# Direction 1:
# Start by initializing ggplot with the summary statistics data:
# Direction 2:   
# Specify x and y as usually
# Direction 3:
#     Specify ymin = len-sd 
# Direction 4:
#     ymax = len+sd to add lower and upper error bars
# Notes
#     If you want only to add upper error bars but not the lower ones, 
#     use ymin = len (instead of len-sd) and ymax = len+sd.


# Initialize ggplot with data
f <- ggplot(
  df.summary, 
  aes(x = dose, y = len, ymin = len-sd, ymax = len+sd)
)

f+ geom_errorbar(width = 0.2) +
  geom_point(size = 1.5)
