#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
# Libraries used
library(shiny)
library(ggplot2)
library(plotly)

##Reading pre-downloaded from the local folder
df <- read.csv("annual2.csv")

# renaming column
colnames(df)[3]<-"Change"

# choosing data source type = Global Component of Climate at a Glance (GCAG)
df <- df[df$Source=="GCAG",]
# deleting the source type column
df<-df[-1]
# ordering by year from latest
df<-df[order(df$Year),]


# Define server logic required to draw a plot
shinyServer(function(input, output) {
  
  output$tempPlot <- renderPlotly({
    
      if (!input$checkbox){df$Change<-df$Change*1.8; lab<-"Annual Temperature Change, Fahrenheit"}
    else {lab<-'Annual Temperature Change, Celcius'}
      df2<- df
    # generate Moving Average depending on user input$Average from ui.R
    numav<-input$Average
    
    # Function for moving-average calculation
    move_average<-function(yy,n){
         y<-yy
         for (i in n:length(yy)){
             y[i]=sum(yy[(i-n+1):i])/n
         }
      return(y)
    }
    # actual call to the moving average function
    df2[,2] <- move_average(df[,2], numav)
    
   
    # draw the plot
    p <- plot_ly(df2, x = ~Year, y = ~ Change) %>%
      add_trace(y = ~ Change, name = lab,mode = 'lines', type ="scatter") %>%
      add_trace(x = c(1880 + numav, 1880 + numav), y = c(min(df2$Change), max(df2$Change)), name = 'Cut-Off Line', mode = "lines", type ="scatter")
    
  })
  
})
