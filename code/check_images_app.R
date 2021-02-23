library(shiny)
library(here)
library(readr)

# obtain list of all the words (from the data set)
dat <- read_csv2(here("data/data_set.csv"))
# obtain the image paths from the data set
imgs <- here("data/media", dat$image)
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
  output$word <- renderText(dat$word[i() + 1])
  
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
    writeLines(bad_imgs, here("data/bad_images.txt"))
  })
  
}

shinyApp(ui, server)
