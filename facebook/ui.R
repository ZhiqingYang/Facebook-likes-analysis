library(shiny)
library(shinythemes)
library(plotly)

facebook <- read.csv("../facebook.csv", stringsAsFactors = FALSE)

navbarPage("Facebook",
  theme = shinytheme("spacelab"),
  tabPanel("Overview",
    #sidebarLayout(
      mainPanel(
        h3("Project Overview"),
        p("For this project we used a dataset from Sheena Batra, a software engineer who published the data on Kaggle, an online community for data scientists and machine learners owned by Google. This dataset provides insight on Facebook users statistics and demographics. It is available at ", a("here.", href = "https://www.kaggle.com/sheenabatra/facebook-data")),
        br(),
        h3("Target Audience"),
        p("Our target audience are people who use social media and technology a lot, specifically Facebook, and are interested in learning more about the correlations of the different factors of this data such as gender and age group."),
        br(),
        h3("Central Questions"),
        p("Some of the central questions that we are trying to answer through our interpretation include:"),
        tags$ul(
          tags$li("What gender on average receives the most likes on their profile?"),
          tags$li("What is the correlation between age group and friendships initiated/friend count? Does gender play a role?"),
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
    #)
  ),
  
  tabPanel("Graph1",
    sidebarLayout(
      sidebarPanel(
        radioButtons("likes", "Likes type",
                     c("Mobile", "Web", "Combined"))
        ),
      mainPanel(
        plotOutput("barplot")
      )
    )
  ),
  
  tabPanel("Graph2",
    sidebarLayout(
      sidebarPanel(
        radioButtons("friendships", "Friendship Measure type",
                c("Friendships initiated", "Friend count")),
        checkboxGroupInput("age_group", "Choose Age Group for Friendships Measure",
                c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70+"), selected = "10-19")
        ),
      mainPanel(
        plotlyOutput("scatterplot1")
      )
    )
  ),
  
  tabPanel("Graph3",
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("age_group", "Choose Age Group for likes received and given",
                           c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70+"), selected = "10-19")
        ),
      mainPanel(
        plotlyOutput("scatterplot2")
      )
    )
  )
)
      
      
      
    
  
  
  