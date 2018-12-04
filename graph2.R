library(plotly)
library(dplyr)

facebook <- read.csv("../facebook.csv", stringsAsFactors = FALSE)

graph2 <- function(age_chart) {

  #labs <- c(paste(seq(10, 65, by = 10), seq(10 + 10 - 1, 70 - 1, by = 10), sep = "-"), paste(70, "+", sep = ""))
  #facebook$AgeGroup <- cut(facebook$age, breaks = c(seq(10, 70, by = 10), Inf), labels = labs, right = FALSE)
  
#  age_chart <- group_by(this_age, age) %>%
 #   summarize(mean = mean(friendships_initiated))
  ggplot(age_chart, aes(x = age, y = mean)) + geom_point()
}