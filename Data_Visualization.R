install.packages("tidyverse")
library(tidyverse)

## tidyverse is for ggplot2, tibble, tidyr, readr, purrr, dplyr

ggplot2::ggplot()
  
data("mpg")
View(mpg)

## Plot for find the relation between car engine size and fuel efficiancy

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

## There is negative relationship between engine size and fuel efficiency. That is as the size of the car increase

ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = drv))


ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))


dim(mtcars) ## 32 rows and 11 columns

ggplot(data = mpg)

?mpg

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class, size = class, shape = class))


## "alpha" aesthetics to control the transperancy of the points

## "shape" aesthetics to control the shape of the points, different class will have different shapes

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))


## Make all points single color

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "Blue")

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "Blue", size = 3, shape = 16)

## Exercises

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "Blue")

str(mpg)

## Stroke aesthetic

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, stroke = cyl, color = class))

avg_disp = mean(mpg$displ)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ < avg_disp))

## Facets; variable we pass for facet_wrap() should be discrete

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(.~ cyl)

## What happens if you facet on a continuous variable?

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ cty)

## Create a subplot for each value of the continuous variable

## What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?

## Empty cells for combination of 4-r , 5-4, 5-r indicates that there exists no points for these combinations in the plot of hwy vs displ

## What plots does the following code make? What does . do?

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ .)


## Geometric objects

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))


ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, group = drv, color = drv))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y = hwy)) + geom_smooth(mapping = aes(x = displ, y = hwy))

## mapping parameters declared as global parameters

ggplot(data = mpg,mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()

ggplot(data = mpg,mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth()

ggplot(data = mpg,mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth(data = filter(mpg, class == "subcompact"),se = FALSE)

## parameters in geom_smooth() are localized only for the line function

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + geom_point() + geom_smooth(se = FALSE)


####################### Statistical Transformations ############################################################################################

data("diamonds")
View(diamonds)

## Bar charts

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) + stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~a,      ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)

ggplot(data = demo) + geom_bar(mapping = aes(x = a, y = b),stat = "Identity")

## Creating a proportions bar chart

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop..),group = 1)

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
)

################ Position Adjustments #################################################################################################

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = cut))

## Stacked Bar Chart

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

## position = "jitter" avoids overplotting

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

## without position = "jitter"

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

####################### Coordinate Systems ###################################################################################

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot()

## Flipping x and y coordinates

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot() + coord_flip()

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) + geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) + geom_polygon(fill = "white", colour = "black") + coord_quickmap()

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

################### Data Visualization Completed ###########################################################################################