#### Parte 1

## Ex 1 (stat_smooth)

#Familiarize yourself again with the mtcars dataset using str().
#Extend the first ggplot call: add a LOESS smooth to the scatter plot (which is the default) with geom_smooth(). 
# We want to have the actual values and the smooth on the same plot.
#Change the previous plot to use an ordinary linear model, by default it will be y ~ x, so you don't have to specify a formula. 
# You should set the method argument to "lm".
#Modify the previous plot to remove the 95% CI ribbon. You should set the se argument to FALSE.
#Modify the previous plot to show only the model, and not the underlying dots.


# ggplot2 is already loaded

# Explore the mtcars data frame with str()
str(mtcars)

# A scatter plot with LOESS smooth:
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + geom_smooth(method = "loess")


# A scatter plot with an ordinary Least Squares linear model:
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()+ geom_smooth(method = "lm")


# The previous plot, without CI ribbon:
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()+ geom_smooth(method = "lm", se =FALSE)


# The previous plot, without points:
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_smooth(method = "lm", se =FALSE)

## Ex 2

#A plot that maps cyl onto the col aesthetic is already coded.

#Change col so that factor(cyl) is mapped onto it instead of just cyl.
#Note: In this ggplot command our smooth is calculated for each subgroup because there is an invisible aesthetic, 
# group which inherits from col.

#Complete the second ggplot command

#Add another stat_smooth() layer with exactly the same attributes (method set to "lm", se to FALSE).
#Add a group aesthetic inside the aes() of this new stat_smooth(), set it to a summary variable, 1.

# Define cyl as a factor variable
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() + stat_smooth(method = "lm", se = F)

# Complete the following ggplot command as instructed
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() + stat_smooth(method = "lm", se = F) + 
  stat_smooth(mapping = aes(group = 1), method = "lm", se = F)


## Ex 3

#Plot 1: Recall that LOESS smoothing is a non-parametric form of regression that uses a weighted, sliding-window, 
# average to calculate a line of best fit. We can control the size of this window with the span argument.

#Add span, set it to 0.7
#Plot 2: In this plot, we set a linear model for the entire dataset as well as each subgroup, defined by cyl. 
# In the second stat_smooth(),

#Set method to "loess"
#Add span, set it to 0.7
#Plot 3: Plot 2 presents a problem because there is a black line on our plot that is not included in the legend. 
# To get this, we need to map something to col as an aesthetic, not just set col as an attribute.

#Add col to the aes() function in the second stat_smooth(), set it to "All". This will name the line properly.
#Remove the col attribute in the second stat_smooth(). Otherwise, it will overwrite the col aesthetic.
#Plot 4: Now we should see our "All" model in the legend, but it's not black anymore.

#Add a scale layer: scale_color_manual() with the first argument set to "Cylinders" and values set to the predfined myColors variable

# Plot 1: change the LOESS span
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + geom_smooth(se = F, span =0.7)

# Plot 2: Set the overall model to LOESS and use a span of 0.7
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() + 
  stat_smooth(method = "lm", se = F) + 
  stat_smooth(method = "loess", aes(group = 1), se = F, col = "black", span=0.7)

# Plot 3: Set col to "All", inside the aes layer of stat_smooth()
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() + stat_smooth(method = "lm", se = F) + 
  stat_smooth(method = "loess", aes(group = 1, col ="All"), se = F, span = 0.7)

# Plot 4: Add scale_color_manual to change the colors
require(RColorBrewer)
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) + geom_point() + stat_smooth(method = "lm", se = F, span = 0.75) + 
  stat_smooth(method = "loess", aes(group = 1, col="All"), se = F, span = 0.7) + scale_color_manual("Cylinders" , values = myColors)

## Ex 4

#Plot 1: The code on the right builds a jittered plot of vocabulary against education of the Vocab data frame.

#Add a stat_smooth() layer with method set to "lm". Make sure no CI ribbons are shown by setting se to FALSE.
#Plot 2: We'll just focus on the linear models from now on.

#Copy the previous command, remove the geom_jitter() layer.
#Add the col aesthetic to the ggplot() command. Set it to factor(year).
#Plot 3: The default colors are pretty unintuitive. Since this can be considered an ordinal scale, 
# it would be nice to use a sequential color palette.

#Copy the previous command, add scale_color_brewer() to use a default ColorBrewer. 
# This should result in an error, since the default palette, "Blues", only has 9 colors, but we have 16 years here.
#Plot 4: Overcome the error by using year as a numeric vector. You'll have to specify the invisible group aesthetic which will be 
# factor(year). You are given a scale layer which will fix your coloring, but you'll need to make the following changes:

#Add group inside aes(), set it to factor(year).
#Inside stat_smooth(), set alpha equal to 0.6 and size equal to 2.

# Plot 1: Jittered scatter plot, add a linear model (lm) smooth:
ggplot(Vocab, aes(x = education, y = vocabulary)) + geom_jitter(alpha = 0.2) + stat_smooth(method = "lm", se = FALSE) 


# Plot 2: Only lm, colored by year
ggplot(Vocab, aes(x = education, y = vocabulary, col = factor(year))) + stat_smooth(method = "lm", se = FALSE) 

# Plot 3: Set a color brewer palette
ggplot(Vocab, aes(x = education, y = vocabulary, col = factor(year))) + stat_smooth(method = "lm", se = FALSE) + 
  scale_color_brewer()


# Plot 4: Add the group, specify alpha and size
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group =factor(year))) + 
  stat_smooth(method = "lm", se = F, alpha=0.6, size=2) + scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

# Ex 5 (stat_quantile)

#The code from the previous exercise, with the linear model and a suitable color palette, is already included. 
# Change the stat function from stat_smooth() to stat_quantile(). Consider the arguments that were used with stat_smooth(). 
#  You only have to keep alpha and size, throw the other arguments out!
#  The resulting plot will be a mess, because there are three quartiles drawn by default. 
# Copy the code for the previous instruction and set the quantiles argument to 0.5 so that only the median is shown.

# Use stat_quantile instead of stat_smooth:
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) + 
  stat_quantile(method = "rq",alpha = 0.6, size = 2) + scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

# Set quantile to 0.5:
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) + 
  stat_quantile(method = "rq",alpha = 0.6, size = 2, quantiles =0.5) + scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

## Ex 6 (stat_sum -> calculates the count for each group)

# ggplot2 is already loaded. A plot showing a linear model and LOESS regression is already provided and stored as p. Add stat_sum() to this plotting object p. 
# This will map the overall count of each dot onto size. You don't have to set any arguments, the aesthetics will be inherited from the base plot!
# In addition, add the size scale with the generic scale_size() function. Use the range argument to set the minimum and maximum dot sizes as c(1,10)

# Plot with linear and loess model
p <- ggplot(Vocab, aes(x = education, y = vocabulary)) + stat_smooth(method = "loess", aes(col = "red"), se = F) + 
  stat_smooth(method = "lm", aes(col = "blue"), se = F) + scale_color_discrete("Model", labels = c("red" = "LOESS", "blue" = "lm")) 

# Add stat_sum
p + stat_sum()

# Add stat_sum and set size range
p + stat_sum() + scale_size(range = c(1,10))


#### Parte 2

## Ex 1 (stat_summary)

# Use str() to explore the structure of the mtcars dataset.
# In mtcars, cyl and am are classified as continuous, but they are actually categorical. Previously we just used factor(), 
# but here we'll modify the actual dataset. Change cyl and am to be categorical in the mtcars data frame using as.factor.
# Next we'll set three position objects with convenient names. This allows us to use the exact positions on multiple layers. Create:
#  posn.d, using position_dodge() with a width of 0.1,
# posn.jd, using position_jitterdodge() with a jitter.width of 0.1 and a dodge.width of 0.2
# posn.j, using position_jitter() with a width of 0.2.
# Finally, we'll make our base layers and store it in the object wt.cyl.am. 
# Make the base call for ggplot mapping cyl to the x, wt to y, am to both col and fill. Also set group = am inside aes().
# The reason for these redundancies will become clear later on.

# Display structure of mtcars
str(mtcars)

# Convert cyl and am to factors:
mtcars$cyl <- as.factor(mtcars$cyl) 
mtcars$am <- as.factor(mtcars$am)

# Define positions:
posn.d <- position_dodge(width = 0.1)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width = 0.2)
posn.j <- position_jitter(width=0.2)

# base layers:
wt.cyl.am <- ggplot(data = mtcars, mapping=aes(x=cyl, y=wt, col=am, fill=am, group=am))


## Ex 2

#Plot 2: Add a stat_summary() layer to wt.cyl.am and calculate the mean and standard deviation as we did in the video: 
# set fun.data to mean_sdl and specify fun.args to be list(mult = 1). Set the position argument to posn.d.
#Plot 3: Repeat the previous plot, but use the 95% confidence interval instead of the standard deviation. You can use mean_cl_normal instead of mean_sdl this time. There's no need to specify fun.args in this case. Again, set position to posn.d.
#The above plots were simple because they implicitly used a default geom, which is geom_pointrange(). For Plot 4, fill in the blanks to calculate the mean and standard deviation separately with two stat_summary() functions:
#For the mean, use geom = "point" and set fun.y = mean. This time you should use fun.y because the point geom uses the y aesthetic behind the scenes.
#Add error bars with another stat_summary() function. Set geom = "errorbar" to get the real "T" tips. Set fun.data = mean_sdl.


# wt.cyl.am, posn.d, posn.jd and posn.j are available

# Plot 1: Jittered, dodged scatter plot with transparent points
wt.cyl.am + geom_point(position = posn.jd, alpha = 0.6)

# Plot 2: Mean and SD - the easy way
wt.cyl.am + stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), position = posn.d)


# Plot 3: Mean and 95% CI - the easy way
wt.cyl.am + stat_summary(fun.data = mean_cl_normal), position = posn.d)



# Plot 4: Mean and SD - with T-tipped error bars - fill in ___
wt.cyl.am +  stat_summary(geom = "point", fun.y = mean, position = posn.d) + 
  stat_summary(geom = "errorbar", fun.data = mean_sdl, position = posn.d, fun.args = list(mult = 1), width = 0.1)

## Ex 3 (mean_sdl)

# First, change the arguments ymin and ymax inside the data.frame() call of gg_range().
# ymin should be the minimum of x
# ymax should be the maximum of x
# Use min() and max(). Watch out, naming is important here. gg_range(xx) should now generate the required output.

# Next, change the arguments y, ymin and ymax inside the data.frame() call of med_IQR().
# y should be the median of x
# ymin should be the first quartile
# ymax should be the 3rd quartile.
# You should use median() and quantile(). For example, quantile() can be used as follows to give the first quartile: quantile(x)[2]. med_IQR(xx) should now generate the required output.

# Play vector xx is available

# Function to save range for use in ggplot 
gg_range <- function(x) {  data.frame(ymin = min(x),ymax = max(x))}

gg_range(xx)
# Required output:
#   ymin ymax
# 1    1  100

# Function to Custom function:
med_IQR <- function(x) {data.frame(y = median(x), ymin = quantile(x, 0.25), ymax = quantile(x, 0.75))}

med_IQR(xx)
# Required output:
#        y  ymin  ymax
# 25% 50.5 25.75 75.25


## Ex 4

# Complete the given stat_summary() functions, only fill in the ___ and don't change the predefined arguments:

# The first stat_summary() layer should have geom set to "linerange". fun.data argument should be set to med_IQR, the function you used in the previous exercise.
# The second stat_summary() uses the "linerange" geom. This time fun.data should be gg_range, the other function you created. Also set alpha to 0.4.
# For the last stat_summary(), use geom = "point". The points should have col "black" and shape "X".

# The base ggplot command, you don't have to change this
wt.cyl.am <- ggplot(mtcars, aes(x = cyl,y = wt, col = am, fill = am, group = am))

# Add three stat_summary calls to wt.cyl.am
wt.cyl.am + stat_summary(geom = "linerange", fun.data = med_IQR, position = posn.d, size = 3) + 
  stat_summary(geom = "linerange", fun.data = gg_range, position = posn.d, size = 3, alpha = 0.4) + 
  stat_summary(geom = "point", fun.y = median, position = posn.d, size = 3, col = "black", shape = "X")











