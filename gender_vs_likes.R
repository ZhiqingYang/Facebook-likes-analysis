library(dplyr)
library(ggplot2)

facebook_info <- read.csv(file = "./facebook.csv", 
                     stringsAsFactors = FALSE)
as.data.frame(facebook_info)
gender_likes_graph <- function(data, input_mobile_web)
  if (length (input_mobile_web) == 2 ){
    facebook_likes <- select(data, gender, likes_received) 
    likes_mean <- group_by(facebook_likes, gender) %>% 
      summarise(mean_likes = mean(likes_received)) %>% 
      filter(gender == "female" | gender == "male")
    ggplot() + 
      geom_bar(data = likes_mean, aes(x = gender, y = mean_likes
      ), stat = 'identity') +
      ggtitle(paste('gender vs likes')) +
      xlab("gender") +
      ylab("mean") 
  
  }  else if (input_mobile_web == c("mobile_likes_received")) {
    facebook_likes <- select(data, gender, mobile_likes_received) 
    likes_mean <- group_by(facebook_likes, gender) %>% 
      summarise(mean_likes = mean(mobile_likes_received)) %>% 
      filter(gender == "female" | gender == "male")
    ggplot() + 
      geom_bar(data = likes_mean, aes(x = gender, y = mean_likes
      ), stat = 'identity') +
      ggtitle(paste('gender vs likes')) +
      xlab("gender") +
      ylab("mean") 
  }else if (input_mobile_web == c("www_likes_received")) {
    facebook_likes <- select(data, gender, www_likes_received) 
    likes_mean <- group_by(facebook_likes, gender) %>% 
      summarise(mean_likes = mean(www_likes_received)) %>% 
      filter(gender == "female" | gender == "male")
    ggplot() + 
      geom_bar(data = likes_mean, aes(x = gender, y = mean_likes
      ), stat = 'identity') +
      ggtitle(paste('gender vs likes')) +
      xlab("gender") +
      ylab("mean") 
  }


graph2 <- gender_likes_graph(facebook_info, c("www_likes_received"))
graph1 <- gender_likes_graph(facebook_info, c("mobile_likes_received"))
graph3 <- gender_likes_graph(facebook_info, c("www_likes_received", "mobile_likes_received"))
