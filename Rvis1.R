#####################################################
#####################################################
#tutorial R code for the course R: data visualisation
#topic: basic plots
#institution: IT Services, University of Oxford
#year: 2019
#####################################################
#####################################################

#WELCOME TO R STUDIO
#Please follow the instructions provided during the course and feel free to consult the cheatsheets provided. The symbol "#" at the beginning of a line indicates a comment instead of an R code. Don't hesitate to amend the comments and code to answer the questions and further explore the functionalities of R.

#HOW TO RUN AN R CODE LINE
#Take few minutes to consult the R-cheatsheet.pdf and explore the R Studio environment. To run a code line, left-click anywhere on a line code and press Ctrl+Enter (for MAC: Command+Enter).

#WORKING DIRECTORY
#check where is the current working directory
getwd()

#set working directory for your machine, using the location of the folder which contains the data for the course. For example if the files for this course are saved in 'H:` run the line:
setwd("H:")

#check where is new current working directory
getwd()

#By running the command setwd(), you have set your working directory. Furthermore, you have printed its path with the command getwd(). If everything is set, start Ch.1 Bar plot.

################################Ch.1 Bar plot#######################################
####################################################################################

#Welcome to the R: data visualisation tutorial course. In this tutorial, you will get some knowledge on using R to visualise data. Do not hesitate to ask questions to your instructor during the exercise. Good luck! 

#1.1. Run the following lines to check and install all required packages for the tutorial
#this may take about 5-8 minutes on an IT services desktop machine - take some time to get familiar with R and ggplot by consulting your cheatsheets
list.of.packages <- c("corrplot","ggplot2","tidyverse","gapminder","gganimate","gifski","gridExtra","png")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load a library used in this tutorial
library(corrplot)
#some warning messages - although in red - can be ignored. They only indicate that a package is built under a specific version of R 
#1.2. Explore the dataset mtcars by running the following line
?mtcars #tip: to run a line, click left anywhere on a code line and press "ctrl+Enter" for PC, "command+Enter" for MAC). 
#A description of the dataset is given in the Help tab, bottom-right of R studio.

#run the following line to get more information on the variables (columns) and observations (rows)
head(mtcars)

#1.3 Aggregate the data
Numbers<-table(mtcars$cyl,mtcars$gear)
Numbers
#what is the result of the table command applied to two columns of mtcars?
#tips: 'table' is a function used to aggregate data

#1.4. Make your first bar plot
barplot(Numbers,main='Automobile cylinder number grouped by number of gears', 
        col=c('red','orange','steelblue'),legend=rownames(Numbers),xlab='Number of Gears',ylab='count')
#run the following line to get more information on barplot (select Bar Plots when you get the info on the Help menu)
?barplot
#customize the plot (e.g. change the filling color of the bar, plot horizontally, remove the axes,....)

#1.5. Save your final barplot (feel free to customize the code lines below) as a pdf and png file

#save your plot as pdf
pdf("mybarplot.pdf")# this line is used to indicate that the plot will be saved as a pdf file.
barplot(Numbers,main='Automobile cylinder number grouped by number of gears', 
            col=c('red','orange','steelblue'),legend=rownames(Numbers),xlab='Number of Gears',ylab='count')
dev.off()#important element to close the plot  

#save your plot as png
png("mybarplot.png", width = 450, height = 350)
barplot(Numbers,main='Automobile cylinder number grouped by number of gears', 
            col=c('red','orange','steelblue'),legend=rownames(Numbers),xlab='Number of Gears',ylab='count')
dev.off()
#where are the plots saved?
#tips: check where is your working directory by running the following line
getwd()
#this is where your plots are saved if not indicated otherwise
#customize the way you save your plot (size, location) and save your final choices
#tip: run ?pdf and also ?png to get more info on the plot options 

################################Ch.2 Histogram##########################################################################################################################

#2.1. Plot the histogram of frequency of ozone values in 'airquality' dataset
hist(airquality$Temp,col='steelblue',main='Maximum Daily Temperature',
     xlab='Temperature (degrees Fahrenheit)')

#2.2. We would prefer having an histogram with values degrees Celsius instead of degrees Fahrenheit. Transform the values of temperature in degree Celsius and replot your histogram.
#tip: The temperature in degrees Celsius is equal to the temperature in degrees Fahrenheit minus 32, times 5/9. Therefore, you can add the new temperature in the dataframe "airquality", for example by running: airquality$TCelsius <-  airquality$Temp....

#2.3. Let's compare the two histograms. Plot them next to each other.
#Tip: look at the some tips for the layout of plots from this website: https://www.statmethods.net/advgraphs/layout.html. In addition, make sure that you also amend the labels accordingly.


################################Ch.3 Box plot#########################################################################################################################

#Here you will learn how to make box plot, which allows you to visualise some useful statistics of the data

#3.1.Run the following lines
mtcars<-transform(mtcars,cyl=factor(cyl))# convert 'cyl' column from class 'numeric' to class 'factor'
class(mtcars$cyl)# 'cyl' is now a categorical variable 
par(mfrow=c(1,1))#back to the original graphic layout
boxplot(mpg~cyl,mtcars,xlab='Number of Cylinders',ylab='miles per gallon',
        main='miles per gallon for varied cylinders in automobiles',cex.main=1.2)
#How is the relationship between the number of cylinders and the number of miles per gallon? Is it what you expect?

#############################Ch.4 Correlogram#########################################################################################################################

#4.1. Plot the correlation among several variables
mtcars$cyl<-as.numeric(mtcars$cyl)#make variable cylinder numerical
#get correlation coefficients
corr_matrix <- cor(mtcars)
#generate disks of different sizes and colours
corrplot(corr_matrix)
#what is the meaning of the disk size and colours?

#4.2. plot the correlation with numbers and a lower matrix matrix
corrplot(corr_matrix,method = 'number',type = "lower")
#what is the meaning of the numbers and colours?

################################################################################
#END of Rvis1.R################################################################
################################################################################
#GO to Rvis2.R#################################################################
################################################################################