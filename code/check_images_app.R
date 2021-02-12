library(shiny)
library(here)

# obtain the paths for all the images (to render the images of the app)
imgs <- list.files(here("data/media/"), full.names = TRUE)
# create empty list to add bad images
bad_imgs <- vector("list", length(imgs))

ui <- fluidPage(
  imageOutput("image"),
  # ADD THE WORDS, TO COMPARE AND DECIDE IF IT'S A GOOD OR A BAD IMAGE :)
  actionButton("button_good", "Next!"),
  actionButton("button_bad", "Bad image :("),
  actionButton("button_back", "Back")
)

server <- function(input, output, session) {
  # reactive element as a counter, it counts both buttons
  i <- reactive(input$button_good + input$button_bad - input$button_back)
  # render image
  output$image <- renderImage({
    list(src = imgs[i() + 1])
  }, deleteFile = FALSE)
  # fill the list with the image shown in the screen at that moment
  observeEvent(input$button_bad, {
    bad_imgs[[i()]] <<- imgs[i()]
    print(imgs[i()])
  })
}

shinyApp(ui, server)
