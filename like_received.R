#like and like_received scatter plot
library(plotly)
df <- read.csv("facebook-1.csv")
#clear the cluster on the x and y axis
df <- filter(df, likes < 10000 )
df <- filter(df, likes_received > 0 & likes_received < 10000)

labs <- c(paste(seq(10, 65, by = 10), seq(10 + 10 - 1, 70 - 1, by = 10),
                sep = "-"), paste(70, "+", sep = ""))

df$AgeGroup <- cut(df$age, breaks = c(seq(10, 70, by = 10), Inf), labels = labs, right = FALSE)
#filter by age group
#df <- filter(df, AgeGroup == "10-19" | AgeGroup == "20-29" | AgeGroup == "30-39")
df <- filter(df, AgeGroup == "10-19" | AgeGroup == "20-29" | 
               AgeGroup == "30-39" | AgeGroup == "40-49")


#plot
p <- plot_ly(data = df, x = ~friend_count, y = ~likes_received, color = ~AgeGroup)
p

##summary: from 10-39, as the age grows, people tend to have less likes and like received. 
##teenagers are giving more like than the other two. On general, how many friends a user has, 
#doesn't correlate with the likes you received.Teenagers have more friend than people over 20.
##