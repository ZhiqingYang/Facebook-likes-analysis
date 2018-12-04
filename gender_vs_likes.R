library(dplyr)
library(ggplot2)

facebook_info <- read.csv(file = "../facebook.csv", 
                     stringsAsFactors = FALSE)

gender_likes_graph <- function(this_data)
    ggplot() + 
      geom_bar(data = this_data, aes(x = gender, y = mean_likes
      ), stat = 'identity') +
      ggtitle(paste('gender vs likes')) +
      xlab("gender") +
      ylab("mean") 


