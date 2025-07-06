library(shiny)

ui <- fluidPage(
  titlePanel("Employee Info Form"),
  
  textInput("name", "Name"),
  textAreaInput("story", "Personal Story"),
  passwordInput("secret", "Secret Info"),
  
  numericInput("age", "Age", value = 25),
  sliderInput("experience", "Years of Experience", 0, 40, 1),
  sliderInput("contract", "Contract Duration", 1, 60, c(6, 12)),
  
  dateInput("dob", "Date of Birth"),
  dateRangeInput("vacation", "Vacation Dates"),
  
  selectInput("language", "Programming Languages", 
              choices = c("R", "Python", "Java", "C++"), multiple = TRUE),
  
  checkboxGroupInput("hobbies", "Hobbies", 
                     choices = c("Reading", "Gaming", "Coding",'Singing','Filming')),
  
  checkboxInput("sidejob", "Available for Side Job"),
  
  fileInput("file", "Upload Your File"),
  
  actionButton("submit", "Submit"),
  
  verbatimTextOutput("info")
)


server <- function(input, output) {
  observeEvent(input$submit, {
    if (input$age < 18 || input$age > 55) {
      output$info <- renderText("Age must be between 18 and 55")
    } else {
      output$info <- renderPrint({
        cat("Name:", input$name, "\n")
        cat("Story:", input$story, "\n")
        cat("Secret:", input$secret, "\n")
        cat("Age:", input$age, "\n")
        cat("Experience:", input$experience, "\n")
        cat("Contract:", input$contract[1], "-", input$contract[2], "\n")
        cat("DOB:", input$dob, "\n")
        cat("Vacation:", input$vacation[1], "-", input$vacation[2], "\n")
        cat("Languages:", input$language, "\n")
        cat("Hobbies:", input$hobbies, "\n")
        cat("Side Job:", ifelse(input$sidejob, "Yes", "No"), "\n")
        if (!is.null(input$file)) {
          cat("File:", input$file$name, "\n")
        }
        cat("Your Form has been Successfully Submitted!")
      })
    }
  })
}

shinyApp(ui = ui, server = server)
