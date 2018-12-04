library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
source("../graph2.R")
source("../gender_vs_likes.R")
source("../likes.R")

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
  
  output$scatterplot1 <- renderPlotly({
    this_age <- filter(facebook, AgeGroup == input$age_group)
    if (input$friendships == "Friendships initiated") {
      age_chart <- group_by(this_age, age) %>%
        summarize(mean = mean(friendships_initiated))
    } else {
      age_chart <- group_by(this_age, age) %>%
        summarize(mean = mean(friend_count))
    }
    plot_ly(data = age_chart, x = ~age, y = ~mean, type = 'scatter', mode = 'markers') %>% 
      layout(title = paste("Relationship Between Age and ", input$friendships), 
                   yaxis = list(title = input$friendships), xaxis = list(title = "Age"))
  })
  
  output$scatterplot2 <- renderPlotly({
    without_outliers <- filter(facebook, likes < 10000, likes_received > 0 & likes_received < 10000)
    this_age <- filter(without_outliers, AgeGroup == input$age_group)
    plot_ly(data = this_age, x = ~likes, y = ~likes_received, type = 'scatter', mode = 'markers')
  })
}
