#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Annual changes in global temperature, 1880-2015"),
  h3("Source: Frictionless Data. http://data.okfn.org/data/core/global-temp"),

  # Sidebar with a checkbox for Temp Units and a slider input for number of years for moving average calculations 
  sidebarLayout(
    sidebarPanel(
      checkboxInput("checkbox", label = "Uncheck for Fahrenheit", value = TRUE),
      h3("Please select number of years for Moving Average"),
       sliderInput("Average",
                   "Number of Previous Years to Average over:",
                   min = 1,
                   max = 40,
                   value = 1)
    ),
    
    # Show a plot of the generated averages
    mainPanel(
      h3("Annual change in global temperature relative to the 20th century mean"),
             plotlyOutput("tempPlot"))
  ),
  
  h4("The Summary: "), 

    h5( "- Time-Series of Annual Global Temperature Change.", br(),
     
     "- Observation Period: 1988-2015.", br(),
     
     "- Temperature options: Celsius or Fahrenheit.",br(),
     
     "- Trend Analysis with user-adjustable Moving Average.",br(),
     
     "- Number of years of Moving Average: 1-40."),
  
  h4( "The Input:" ), 
     
     h5("- Data Source: Frictionless Data. http://data.okfn.org/data/core/global-temp.", br(),
     
     "- User can adjust number of previous years, n, that is used in Moving Average Calculations.",br(),
     
     "- Default Number of Years is 1. This is a case with no averaging.", br(),
     
     "- Default Temperature units: Celsius.",br(),
     
     "- Unchecking the box switches the units to Fahrenheit."),
  
  h4( "The Output:"),
     
     h5("- The Plot is reactive to changes in both parameters:
          Temperature Units and Number of Years (n).", br(),
     
    "- The cut-off line (orange vertical) separates first n years, for which the moving average is not calculated (left of the line).", br(),
     
    "- The higher n, the smoother the plot and the clearer the trend.", br(),
     
     "- The Interactive Output is realized by means of Plotly package.")
     
    
))
