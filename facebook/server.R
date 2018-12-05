library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lettercase)

facebook <- read.csv("../facebook.csv", stringsAsFactors = FALSE)
labs <- c(paste(seq(10, 65, by = 10), seq(10 + 10 - 1, 70 - 1, by = 10), sep = "-"), paste(70, "+", sep = ""))
facebook$AgeGroup <- cut(facebook$age, breaks = c(seq(10, 70, by = 10), Inf), labels = labs, right = FALSE)

server <- function(input, output) {
  
  output$barplot <- renderPlotly({
    if (input$device == "Mobile") {
      likes_mean <- select(facebook, gender, mobile_likes_received) %>% 
        group_by(gender) %>% 
        summarise(mean_likes = mean(mobile_likes_received)) %>% 
        filter(gender == "female" | gender == "male")
    } else if (input$device == "Web") {
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
    plot_ly(likes_mean) %>% 
      add_trace(x = ~gender, y = ~mean_likes, width = 0.6, text = ~round(mean_likes), textposition = "auto", textfont = list(color = "white"), type = "bar", width = ~1.0, marker = list(color = c("red", "blue"))) %>% 
      layout(title = paste0("Gender vs. Likes on ", input$device), xaxis = list(title = "Gender"), yaxis = list(title = "Mean Likes"))
  })
  
  output$scatterplot1 <- renderPlotly({
    this_age <- filter(facebook, AgeGroup == input$age_friendships)
    if (input$friendships == "Friendships initiated") {
      age_chart <- group_by(this_age, age) %>%
        summarize(median = median(friendships_initiated))
    } else {
      age_chart <- group_by(this_age, age) %>%
        summarize(median = median(friend_count))
    }
    #global_colors <- setNames(rainbow(nrow(age_chart)), input$age_friendships)
    pal <- c("red", "blue", "yellow", "green", "black", "purple", "pink")
    plot_ly(data = age_chart, x = ~age, y = ~median, type = 'scatter', mode = 'markers', color = ~input$age_friendships, colors = pal) %>% 
      layout(title = str_title_case(paste0("Relationship Between Age and ", input$friendships)), 
                   yaxis = list(title = str_title_case(paste0("median ", input$friendships))), xaxis = list(title = "Age"))
  })
  
  output$scatterplot2 <- renderPlotly({
    without_outliers <- filter(facebook, likes < 10000, likes_received > 0 & likes_received < 10000)
    this_age <- filter(without_outliers, AgeGroup == input$age_likes)
    plot_ly(data = this_age, x = ~likes, y = ~likes_received, type = 'scatter', mode = 'markers') %>% 
      layout(title = "Likes vs. Likes Received", xaxis = list(title = "Mean Likes"), yaxis = list(title = "Mean Likes Received"))
  })
}
