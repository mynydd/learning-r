#####################################################
#####################################################
#tutorial R code for the course R: data visualisation
#topic: animated graphics
#institution: IT Services, University of Oxford
#year: 2019
#####################################################
#####################################################

#############################Animated graphics######################################
####################################################################################

#In this tutorial, you will learn how to create animated graphs using extensions of ggplot2. Do not hesitate to ask questions to your instructor during the exercise. Good luck! 

############################Ch.1 Gapminder##########################################
####################################################################################

#load librairies used in this section
library(ggplot2)#you can ignore the warning messages indicating that the package has been built under another version of R
library(gapminder)
library(gganimate)
library(gifski)
library(png)
#1.1. Run the following lines and try to understand how the plot has been generated.

gapminder<-gapminder#put the data into dataframe
?gapminder#get more info on this dataset

#static plot
theme_set(theme_bw())
p <- ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")
p

#1.2. Make a dynamic plot. Run the following lines and try to understand how time element is incorporated into the graphic.
p + transition_time(year) +
  labs(title = "Year: {frame_time}")
#Key R function: transition_time(). The transition length between the states will be set to correspond to the actual time difference between them.
#Label variables: frame_time. Gives the time that the current frame corresponds to.

#1.3. Add facets for each continent
p + facet_wrap(~continent) +
  transition_time(year) +
  labs(title = "Year: {frame_time}")

#1.4. Show preceding frames with gradual falloff
#This shadow is meant to draw a small wake after data by showing the latest frames up to the current. You can choose to gradually diminish the size and/or opacity of the shadow. The length of the wake is not given in absolute frames as that would make the animation susceptible to changes in the framerate. Instead it is given as a proportion of the total length of the animation.
#Run the following lines
p + transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

#1.5. Show the original data as background marks
#This shadow lets you show the raw data behind the current frame. Both past and/or future raw data can be shown and styled as you want.
#Run the following lines
p + transition_time(year)  
  labs(title = "Year: {frame_time}") +
  shadow_mark(alpha = 0.3, size = 0.5)

#1.6. Time series plot
#static graphic
p <- ggplot(airquality,aes(Day, Temp, group = Month, color = factor(Month))) + geom_line() + scale_color_viridis_d() +
  labs(x = "Day of Month", y = "Temperature") +
  theme(legend.position = "top")
p
#gradually reveal the x-axis
p + transition_reveal(Day)
#add points
p + geom_point() + transition_reveal(Day)
#try to modify the options of gganimate (look for some info on google)
#to get more info on the option on how the x-axis is revealed type:
?transition_reveal

#1.7 Save the last animation:
anim_save("gapmanim.gif",animation=last_animation())

############################Ch.2 Your graph#########################################
####################################################################################

#Using your own data, try to make a unique graph (animated or not)
#and share your output with your colleagues!
#if you have time and want to discover more on interactive plots, 
#google Rshiny and try to replicate some code. Enjoy!


################################################################################
#END of Rvis3.R################################################################
################################################################################
################################################################################
################################################################################
