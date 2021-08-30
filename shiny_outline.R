## August 31st, 2021
## Shiny Demo with Zoe Zilz and Amelia Ritger
## Creating a two-tab Shiny app using the penguins data

# Load packages
library(shiny)
library(tidyverse)
library(shinythemes) 

# Read in the data
penguins <- read_csv("penguins.csv")

## Create the ui (user interface) - what the user sees 
ui <- navbarPage("Hello, world!")

## Create the server
server <- function(input,output) {}

## Combine the ui and the server into a Shiny app
shinyApp(ui=ui, server=server)