## August 31st, 2021
## Shiny Demo with Zoe Zilz and Amelia Ritger
## Creating a two-tab Shiny app using the penguins data

# Load packages
library(shiny) #this will allow you to create a shiny app
library(tidyverse) #this will allow you to wrangle data
library(shinythemes) #this will allow you to make your shiny app a different theme

# Read in the data
penguins <- read_csv("penguins.csv")

## Create the ui (user interface) - what the user sees 
ui <- navbarPage("My navigation bar", #create page with navigation bar on top
                 theme = shinytheme("spacelab"), #personalize your app with a theme
                 tabPanel("First tab is the first tab", #create a new tab
                          sidebarLayout( #create a sidebar within the tab
                            sidebarPanel("put some text here!", #add a title to the sidebar
                                         radioButtons(inputId = "species", #create a radiobutton with options from "species" (THIS IS PART OF THE SERVER)
                                                      label = "pick a species:", #label it (THIS IS PART OF THE UI)
                                                      choices = c("Adelie", "Gentoo", "Chinstrap")), #format choices in same exact format as they show up in 'sp_short' column of the penguins dataframe
                                         selectInput(inputId = "pt_color", #create a dropdown menu with options from "pt_color" (THIS IS PART OF THE SERVER)
                                                     label = "pick a point color", #label it (THIS IS PART OF THE UI)
                                                     choices = c("favorite RED!!"="red", "pretty purple!"="purple", "ORAAAANGE!!!"="orange"))), #add = if you want to change what it looks like to user vs what R reads
                            mainPanel("some more text is here", #add some text to the main panel
                                      plotOutput(outputId = "penguin_plot")))), #add a 'penguin_plot' to the main panel (THIS IS PART OF THE SERVER)
                 tabPanel("Second tab is the second tab", #create a new tab
                            mainPanel("some more text is here", #add some text to the main panel
                                      img(src='waddle.jpg', align = "center"))) #add 'myImage' to the main panel, align it to the center of the page
                          )

## Create the server - what the app developer sees
server <- function(input,output) { #our server (called 'server', but you can call it anything) has inputs and outputs
  
  #create a reactive ({}) data frame
  penguin_select <- reactive({ #create a reactive data frame called "penguin_select"
    penguins %>% #use the "penguins" data frame AND THEN
      filter(sp_short==input$species) #filter for species in the 'sp_short' column that the user (in the UI) selects in the 'species' widget
  })
  
  #create a reactive ({}) output using a reactive data frame()
  output$penguin_plot <- renderPlot({ #create a reactive plot called "penguin_plot" - it's a reactive plot because it changes depending on the data frame
    ggplot(data=penguin_select(), aes(x=flipper_length_mm, y=body_mass_g)) + #create a ggplot using the reactive data frame, "penguin_select"
      geom_point(color=input$pt_color) #change the color of the points depending on what the user (in the UI) selects in the 'pt_color' widget
  })
}

## Tell R you want to create a Shiny app, with the user interface (ui) and the server (server)
shinyApp(ui=ui, server=server)