library(shiny)
library(ggplot2)
library(dplyr)
source("../graph2.R")
source("../gender_vs_likes.R")
source("../likes_received.R")

facebook <- read.csv("../facebook.csv", stringsAsFactors = FALSE)
labs <- c(paste(seq(10, 65, by = 10), seq(10 + 10 - 1, 70 - 1, by = 10), sep = "-"), paste(70, "+", sep = ""))
facebook$AgeGroup <- cut(facebook$age, breaks = c(seq(10, 70, by = 10), Inf), labels = labs, right = FALSE)

server <- function(input, output) {
  
  output$barplot <- renderPlot({
    if (input$likes == "Mobile") {
      likes_mean <- select(facebook, gender, mobile_likes_received) %>% 
        group_by(gender) %>% 
        summarise(mean_likes = mean(mobile_likes_received)) %>% 
        filter(gender == "female" | gender == "male")
    } else if (input$likes == "Web") {
      likes_mean <- select(facebook, gender, www_likes_received) %>% 
        group_by(gender) %>% 
        summarise(mean_likes = mean(www_likes_received)) %>% 
        filter(gender == "female" | gender == "male")
    } else {
      likes_mean <- select(facebook, gender, likes_received) %>% 
        group_by(gender) %>% 
        summarise(mean_likes = mean(likes_received)) %>% 
        filter(gender == "female" | gender == "male")
    }
    gender_likes_graph(likes_mean)
  })
  
  output$scatterplot1 <- renderPlot({
    this_age <- filter(facebook, AgeGroup == input$age_group)
    if (input$friendships == "Friendships initiated") {
      age_chart <- group_by(this_age, age) %>%
        summarize(mean = mean(friendships_initiated))
    } else {
      age_chart <- group_by(this_age, age) %>%
        summarize(mean = mean(friend_count))
    }
    graph2(age_chart)
  })
  
  output$scatterplot2 <- renderPlot({
    this_age <- filter(facebook, likes < 10000, likes_received > 0 & likes_received < 10000, AgeGroup == input$age_group)
    graph3(this_age)
  })
}
