### https://shiny.rstudio.com/tutorial/
# architecture of a shiny app

# behind the webpage there is a computer 
# running r script

# 1. UI
# 2. Server instructions

## shiny app snippet - begin all apps with that

library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "surveyed",
              label = "Rok realizacji badań",
              step = 1, min = 2017, max = 2019,
              value = c(2017, 2019), sep = "",
              ticks = FALSE),
  checkboxGroupInput(inputId = "mode",
                     label = "Tryb ukończonych studiów",
                     choices = list("Stacjonarny", "Niestacjonarny"),
                     selected = list("Stacjonarny", "Niestacjonarny")),
  plotOutput(outputId = "plot"),
  imageOutput(outputId = "logo")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    library(tidyverse)
    library(scales)
    p <- c("#999999", "#e5231b")
    df <- read_csv("df.csv")
    df %>% 
      filter(surveyed %in% input$surveyed,
             mode %in% input$mode) %>% 
      ggplot(aes(x = type, y = not_working_pct, fill = mode)) +
      geom_col(position = "dodge") +
      facet_grid(surveyed ~ tour_descr) +
      labs(x = "Rodzaj ukończonych studiów",
           y = "Odsetek absolwentów niepracujących w chwili badania",
           caption = "Źródło: badania własne Biura Karier UŁ") +
      scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
      scale_fill_manual(name = "Tryb studiów", values = p) +
      coord_flip()
    })
  output$logo <- renderImage({
    filename <- "logo_biuro_karier.png"
    list(src = filename)
    }, deleteFile = FALSE)
}

shinyApp(ui, server)

### app.R should be the name of app to share
### or server.R and ui.R

