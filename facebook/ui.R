library(shiny)
library(shinythemes)
library(plotly)

navbarPage("Facebook",
  theme = shinytheme("flatly"),
  tabPanel("Overview",
    sidebarLayout(
      sidebarPanel(
        p("The Facebook data we used is available ", a("here.",
          href = "https://www.kaggle.com/sheenabatra/facebook-data")),
        p("Our code can be accessed on ", a("GitHub.",
        href = "https://github.com/mc0504-1574813/Info201-BD6-Final-Project")),
        p("Major libraries used: ", tags$b("plotly, dplyr, shinythemes")),
        p("Data Reading: ", tags$b("csv"))
      ),
      mainPanel(
        h3("Project Overview"),
        p(paste0("For this project we used a dataset from Sheena Batra, a ",
                 "software engineer who published the data on Kaggle, an ",
                 "online community for data scientists and machine learners ",
                 "owned by Google. This dataset provides insight on Facebook ",
                 "users statistics and demographics.")),
        br(),
        h3("Target Audience"),
        p(paste0("Our target audience are people who use social media and ",
                 "technology a lot, specifically Facebook, and are interested ",
                 "in learning more about the correlations of the different ",
                 "factors of this data such as gender and age group.")),
        br(),
        h3("Central Questions"),
        p(paste0("Some of the central questions that we are trying to answer ",
                 "through our interpretation include:")),
        tags$ul(
          tags$li(paste0("What gender on average receives the most likes on ",
                         "their profile?")),
          tags$li(paste0("What is the correlation between age group and ",
                         "friendships initiated/friend count?")),
          tags$li(paste0("What are the demographics of Facebook users who are ",
                         "likely to interact on the platform through likes ",
                         "and friendships?")),
          tags$li(paste0("Can we determine how strong the number of likes a ",
                         "user gives correlates with the likes they receive?"))
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
        plotlyOutput("barplot"),
        br(),
        h4(tags$b("Summary:")),
        p(paste0("The three charts about 'Gender vs. Likes Received' produce ",
                 "similar correlations. On mobile, females get an average of ",
                 "106 more likes than males; on web, females get an average ",
                 "of 77 more likes than males. Combining both, females get an ",
                 "average of 183 more likes than males. From the results, we ",
                 "can safely conclude that females generally receive more ",
                 "likes on their Facebook profiles than males. We predict ",
                 "this patterns occurs because females generally post ",
                 "more contents on social media, particularly those that ",
          "are attractive such as selfies, which brings in more attention."))
      )
    )
  ),

  tabPanel("Age and Friendships",
    sidebarLayout(
      sidebarPanel(
        radioButtons("friendships", "Select friendship measure type",
                c("Friendships Initiated", "Friend Count")),
        checkboxGroupInput("age_friendships", "Select age group",
                c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70+"),
                selected = "10-19")
        ),
      mainPanel(
        plotlyOutput("scatterplot1"),
        br(),
        h4(tags$b("Summary:")),
        p(paste0("The two charts against the variables median friendships ",
                 "initiated and median friend count both reveal similar ",
                 "scatterplot patterns. In both of them, there appears to be ",
                 "slight raise in the earlier ages, then stabilizes in the ",
                 "middle ages, and increases greatly in the upper ages. We ",
                 "predict this pattern occurs because teenagers and young ",
                 "adults tend to use social media more, so it would make ",
                 "sense why there is greater friend count and friendships ",
                 "initiated. It may stabilize into the middle-aged years ",
                 "possibly because people in this demographic may tend to ",
                 "restrict their social media circles to a smaller group of ",
                 "friends. Finally, the possible reason behind accounts ages ",
                 "70+ with the highest number of friend counts and friendships ",
                 "initiated could be spam accounts or robots. Otherwise, it ",
                  "would be unrealistic for that many individuals in the older ",
                 "age group to have substantial friend connections. "))
      )
    )
  ),

  tabPanel("Likes and Likes Received",
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("age_likes", "Select age group",
                        c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69",
                             "70+"), selected = "10-19")
        ),
      mainPanel(
        plotlyOutput("scatterplot2"),
        br(),
        h4(tags$b("Summary:")),
        p(paste0("For this graph we wanted to visualize the correlation ",
                 "between the number of likes users give and receive. We ",
                 "expected them to be positively correlated, meaning the more ",
                 "likes a user gives, the more likes they will receive on ",
                 "their own profiles. However, the plot shows a random ",
                 "distribution, which means no correlation is found between ",
                 "likes given and received; our previous assumption was ",
                 "therefore refuted. We observed an interesting pattern ",
                 "though: by selecting different age groups, we found that ",
                 "young users tend to give and receive more likes than ",
                 "people of older age groups; this may be due to younger ",
                 "users being more active on social media."))
      )
    )
  )
)
