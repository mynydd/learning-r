#####################################################
#####################################################
#tutorial R code for the course R: data visualisation
#topic: ggplot
#institution: IT Services, University of Oxford
#year: 2019
#####################################################
#####################################################

###################################ggplot###########################################
####################################################################################

#Welcome to the R: data visualisation "ggplot" section tutorial course. In this tutorial, you will learn how to plot data using ggplot2. Do not hesitate to ask questions to your instructor during the exercises. Good luck! 

#ggplot2 is a part of the tidyverse, an ecosystem of packages designed with common APIs and a shared philosophy. Learn more at tidyverse.org. Developed by Hadley Wickham, Winston Chang, Lionel Henry, Thomas Lin Pedersen, Kohske Takahashi, Claus Wilke, Kara Woo, Hiroaki Yutani.

##########################Ch.1 Basics of ggplot#####################################
####################################################################################

#1.1 Consult your ggplot2 "cheatsheet" (printed document given by the instructor)
#and try to familiarize with the concepts of ggplot. This cheatsheet will be useful during the exercises.

#load required libraries (already installed in Rvisu1.R)
library(tidyverse)#don't worry if it is indicated in the console that there are conflicts between packages, this cannot be avoided. However, it will not create issues for this tutorial.
library(ggplot2)
library(gridExtra)

#1.2. Setup
#Unlike base graphics, ggplot doesn't take vectors but uses dataframes as datasource.
#In ggplot, the 'aes()' argument is used for aesthetics. The aesthetics specified will be inherited by all the geometrical layers you will add subsequently.

#IMPORTANT REMARK:#################################################
#No plot will be printed until you add the "geom_layers" (Ch.2)
###################################################################

#1.3. Run the following lines and try observe the Plots tab in RStudio
?diamonds#get information on the data
diamonds<-diamonds# save it as dataframe so you can better visualise it
head(diamonds)#get info on the dataframe
ggplot(diamonds)#prepare a ggplot graphic 
ggplot(diamonds, aes(x=carat))#if only X-axis is known. 
ggplot(diamonds, aes(x=carat, y=price))#if both X and Y axes are fixed for all layers
ggplot(diamonds, aes(x=carat, color=cut))#each category of the 'cut' variable will now have a distinct color, once a layer is added.

#Note that ggplot2 considers the X and Y axis of the plot to be aesthetics as well, along with color, size, shape, fill etc. If you want to have the color, size etc fixed (i.e. not vary based on a variable from the dataframe), you need to specify it outside the aes() like in this example here:
ggplot(diamonds, aes(x=carat), color="steelblue")

##########################Ch.2 Layers of ggplot#####################################
####################################################################################

#The layers in ggplot2 are also called 'geoms'. Once the base setup is done, you can append the geoms one on top of the other. Check your ggplot cheatsheet to get more info on the layers.

#2.1. Run the following line
plot.new()
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() 
#We have added one layer: geom_point(). Since the X axis Y axis and the color were defined in ggplot() setup (Ch.1), this layer inherited those aesthetics. 

#2.1. Alternatively, you can specify those aesthetics inside the geom layer also as shown below.
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) # Same as above but specifying the aesthetics inside the geoms.

#2.2. From here we can add more layers (smooth function)
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth() #in this plot, we added a smooth function based on the entire dataset.

#2.3. We can add a smooth function for each category instead of a global one
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth(aes(color=cut)) 

#########################Ch.3 Labels with ggplot####################################
####################################################################################

#Now that you have drawn the main parts of the graph. You might want to add the plot's main title and perhaps change the X and Y axis titles. This can be done using the "labs" layer, used to specify the labels. 

#3.1. Run the following line and try to amend the labels:
gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + labs(title="My scatterplot", x="Carat", y="Price")  # add axis lables and plot title.
print(gg)#we print the plot using print() since we save the object as "gg"
#note that manipulating the size, color of the labels is the job of the 'Theme' (next chapter).

#########################Ch.4 Themes in ggplot######################################
####################################################################################

#Almost everything is set, except that we want to increase the size of the labels and change the legend title. Adjusting the size of labels can be done using the theme() function. You will be able to set the plot.title, axis.text.x and axis.text.y.

#4.1. Run the following lines and observe the results.
gg1 <- gg + theme(plot.title=element_text(size=30, face="bold"), 
                  axis.text.x=element_text(size=15), 
                  axis.text.y=element_text(size=15),
                  axis.title.x=element_text(size=25),
                  axis.title.y=element_text(size=25)) + 
  scale_color_discrete(name="Cut of diamonds")#change legend title.
print(gg1)# print the plot

#try to modify the theme in order to get your desired font size and type
#you can get predefined themes as well. Explore https://ggplot2.tidyverse.org/reference/ggtheme.html to get more info.

#example with black and white theme
ggbw <- gg + theme_bw()+ 
  scale_color_discrete(name="Cut of diamonds")
print(ggbw)# print the plot

#example with classic theme
ggcl <- gg + theme_classic()+ 
  scale_color_discrete(name="Cut of diamonds")
print(ggcl)# print the plot

#4.2. You can also change the position of the legend
#Run the three examples with different legend specifications and plot them together
#Note the different possibilities to modify the legend
p1 <- gg + theme(legend.position="none") + labs(title="First option")# remove legend
p2 <- gg + theme(legend.position="top") + labs(title="Second option")# legend at top
p3 <- gg + labs(title="Third option") + theme(legend.justification=c(1,0), legend.position=c(1,0))# legend inside the plot.
grid.arrange(p1, p2, p3, ncol=3)#display plots next to each other
#try to make your own customized plots with your favorite theme and legend option.

#########################Ch.5 Facets in ggplot######################################
####################################################################################

#In the previous chart, you had the scatterplot for all different values of cut plotted in the same chart. What if you want one chart for one cut?

#5.1. Run the following line and observe the results
gg1 + facet_wrap( ~ cut, ncol=3)# columns defined by 'cut'
#get more information on the way you can define facets
?facet_wrap

#5.2. Make 3 plots displayed in 3 rows
gg1 + facet_wrap( ~ cut, nrow=3)

######################Ch.6 Bar chart in ggplot####################################
####################################################################################

#By default, ggplot makes a 'counts' barchart: it counts the frequency of observations specified by the 'x' aesthetic (in our case, it corresponds to the number of automatic vs manual cars) and plots it. In this format, you don't need to specify the Y aesthetic.
#6.1. Run the following lines and observe the structure of the plotting function
mtcars$am<-as.factor(mtcars$am)#replace numerical by factor value
bar1 <- ggplot(mtcars, aes(x=am)) + geom_bar() + labs(title="Frequency bar chart")  # Y axis derived from counts of X item
print(bar1)

#6.2. Let's add the number of cylinders on the x-axis instead of the artificial names for the category (0 and 1).
bar2 <- ggplot(mtcars, aes(x=am)) + geom_bar() + labs(title="Frequency bar chart")  + scale_x_discrete(name ="gearbox", labels=c("automatic","manual"))
print(bar2)

#6.3. To make a bar chart using the Y aesthetic (a value is provided by a variable rather than being a count), you need to set stat="identity" inside the geom_bar.
df <- data.frame(var=c("a", "b", "c"), nums=c(6,2,8))
df#observe the structure of the dataframe
plot2 <- ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity")
print(plot2)
#make your own barplot by changing the name and values in the dataframe df

######################Ch.7 Time series in ggplot####################################
####################################################################################

#Plotting timeseries requires that you have your data in dataframe format, in which one of the columns is the dates that will be used for X-axis. In this section, we use another dataset 'economics', which is also part of ggplot2.
data(economics)
economics <- data.frame(economics)#convert to dataframe
head(economics)#gives summary statistics of the dataframe
?economics#gives information on the dataframe

#7.1. Run the following lines to plot your timeseries
ggplot(economics) + geom_line(aes(x=date, y=pce, color="pcs")) + geom_line(aes(x=date, y=unemploy, col="unemploy")) + scale_color_discrete(name="Legend") + labs(title="Economics") # plot multiple time series using 'geom_line's
#what geometric layer is used to plot lines?
#How the code is structured so that two time series can be plot on the same graph?
#What is common between the two 'geom_line' in the plot? 

###############################Ch.8 Save ggplot#####################################
####################################################################################

#An important aspect in R is to save objects. Knowing the options of saving plots in R is useful. Here is how to save your ggplots

#8.1. Save a ggplot in a different format
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggsave("myggplot.png", plot=plot1)# save plot1 as png file in your working directory
ggsave("myggplot.pdf", plot=plot1)# save plot1 as pdf file in your working directory
ggsave("myggplot.jpg", plot=plot1)# save plot1 as jpg file in your working directory

#8.2. Run the following line to get more info on the ggsave function and customise the saved plot (for example increase the dpi)
?ggsave

#note that to save the final plot displayed in R studio (in our case we named it "myggplot"), you can run the following command: ggsave("myggplot.png") 

################################################################################
#END of Rvis2.R################################################################
################################################################################
#GO to Rvis3.R#################################################################
################################################################################


