library(plotly)

graph2 <- function(chart, title, y_title) {
  
  p <- plot_ly(data = chart, x = ~age, y = ~mean, type = 'scatter', mode = 'markers') %>% 
    layout(layout(title = title, 
                  yaxis = list(title = y_title), xaxis = list(title = "Age")))
  
  return(p)
  
}