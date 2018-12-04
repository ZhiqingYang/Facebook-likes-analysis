#like and like_received scatter plot
library(plotly)



#plot
graph3 <- function(age_df) {
  plot_ly(data = df, x = ~likes, y = ~likes_received, color = ~AgeGroup)
}


##summary: from 10-39, as the age grows, people tend to have less likes and like received.
##teenagers are giving more like than the other two. On general, how many friends a user has,
#doesn't correlate with the likes you received.Teenagers have more friend than people over 20.
##