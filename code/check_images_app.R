library(shiny)
library(here)

# obtain list of all the words (from the data set)
words <- readLines(here("data/clean/renamed_duplicates.txt"))
# obtain the paths for all the images (to render the images of the app)
imgs <- list.files(here("data/media/"), full.names = TRUE)
# create empty list to add bad images
bad_imgs <- vector("list", length(imgs))

ui <- fluidPage(
  h3(textOutput("word")),
  imageOutput("image"),
  actionButton("button_good", "Next!"),
  actionButton("button_bad", "Bad image :("),
  HTML("<br>"),
  actionButton("button_back", "Back"),
  HTML("<br>"),
  actionButton("button_end", "Finish and write the list")
)

server <- function(input, output, session) {
  
  # reactive element as a counter, it counts both buttons
  i <- reactive(input$button_good + input$button_bad - input$button_back)
  
  # render text
  output$word <- renderText(words[i() + 1])
  
  # render image
  output$image <- renderImage({
    list(src = imgs[i() + 1])
  }, deleteFile = FALSE)
  
  # fill the list with the image shown in the screen at that moment
  observeEvent(input$button_bad, {
    bad_imgs[[i()]] <<- imgs[i()]
    print(imgs[i()])
  })
  
  # write the results in a file
  observeEvent(input$button_end, {
    bad_imgs <- unlist(bad_imgs)
    bad_imgs <- bad_imgs[!is.na(bad_imgs)]
    writeLines(bad_imgs, "data/temporary/bad_images.txt")
  })
  
}

shinyApp(ui, server)
