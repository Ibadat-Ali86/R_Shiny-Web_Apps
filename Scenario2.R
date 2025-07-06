library(shiny)

ui <- fluidPage(
  titlePanel("Data Cleaner"),
  
  fileInput("up", "Upload CSV"),
  textInput("dl", "Delimiter", ""),
  numericInput("sk", "Skip Rows", 0),
  numericInput("prv", "Preview Rows", 5),
  
  h4("Raw Preview"),
  tableOutput("raw"),
  
  checkboxInput("rm_na", "Remove NA Rows"),
  
  h4("Cleaned Preview"),
  tableOutput("clean"),
  
  downloadButton("down", "Download")
)

server <- function(input, output) {
  rawData <- reactive({
    req(input$up)
    sep <- ifelse(input$dl == "", ",", input$dl)
    read.csv(input$up$datapath, sep = sep, skip = input$sk)
  })
  
  output$raw <- renderTable({
    head(rawData(), input$prv)
  })
  
  cleanData <- reactive({
    data <- rawData()
    if (input$rm_na) {
      data <- na.omit(data)
    }
    data
  })
  
  output$clean <- renderTable({
    head(cleanData(), input$prv)
  })
  
  output$down <- downloadHandler(
    filename = function() {
      "cleaned_data.csv"
    },
    content = function(file) {
      write.csv(cleanData(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)
