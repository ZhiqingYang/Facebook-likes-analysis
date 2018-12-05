library(shiny)
library(shinythemes)
library(plotly)

facebook <- read.csv("../facebook.csv", stringsAsFactors = FALSE)

navbarPage("Facebook",
  theme = shinytheme("flatly"),
  tabPanel("Overview",
    sidebarLayout(
      sidebarPanel(
        p("Facebook data is available ", a("here.", href = "https://www.kaggle.com/sheenabatra/facebook-data")),
        p("Major Libraries Used: ", tags$b("plotly, dplyr, shinythemes")),
        p("Data Reading: ", tags$b("csv"))
      ),
      mainPanel(
        img(src = "../facebook.jpg"),
        h3("Project Overview"),
        p("For this project we used a dataset from Sheena Batra, a software engineer who published the data on Kaggle, an online community for data scientists and machine learners owned by Google. This dataset provides insight on Facebook users statistics and demographics."),
        br(),
        h3("Target Audience"),
        p("Our target audience are people who use social media and technology a lot, specifically Facebook, and are interested in learning more about the correlations of the different factors of this data such as gender and age group."),
        br(),
        h3("Central Questions"),
        p("Some of the central questions that we are trying to answer through our interpretation include:"),
        tags$ul(
          tags$li("What gender on average receives the most likes on their profile?"),
          tags$li("What is the correlation between age group and friendships initiated/friend count?"),
          tags$li("What are the demographics of Facebook users who are likely to interact on the platform through likes and friendships?"),
          tags$li("Can we determine how strong the number of likes a user gives correlates with the likes they receive?")
        ),
        br(),
        h3("Project Creators"),
        tags$ul(
          tags$li("Vanessa Yang"),
          tags$li("Tiffany Wong"),
          tags$li("AJ"),
          tags$li("Michelle Chen")
        )
      )
    )
  ),
  
  tabPanel("Gender and Likes",
    sidebarLayout(
      sidebarPanel(
        radioButtons("device", "Select likes on",
                     c("Mobile", "Web", "Mobile and Web Combined"))
        ),
      mainPanel(
        plotlyOutput("barplot")
      )
    )
  ),
  
  tabPanel("Age and Friendships",
    sidebarLayout(
      sidebarPanel(
        radioButtons("friendships", "Select friendships measure type",
                c("Friendships Initiated", "Friend Count")),
        checkboxGroupInput("age_friendships", "Select age group",
                c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70+"), selected = "10-19")
        ),
      mainPanel(
        plotlyOutput("scatterplot1")
      )
    )
  ),
  
  tabPanel("Likes and Likes Received",
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("age_likes", "Select age group",
                           c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70+"), selected = "10-19")
        ),
      mainPanel(
        plotlyOutput("scatterplot2")
      )
    )
  )
)
      
      
      
    
  
  
  