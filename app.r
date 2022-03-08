library(shiny)

ui <- function(req) 
  fluidPage(
    dateRangeInput("daterange1", "Date range:",
                   start = Sys.Date(),
                   end   = Sys.Date()+1),
    
fluidRow(
  column(br(), br(), br(),
         tableOutput("ship_dates_out"),
         offset = 1,
         width=10))
)

server <- function(input, output, session) {
  start_date <- reactive({
    as.character(input$daterange1[1])
  })
  end_date <- reactive({
    as.character(input$daterange1[2])
  })
  ship_dates <- reactive({
    mydata <- seq(as.Date(start_date()), as.Date(end_date()), by = "days")
    return(mydata)
  })
  
  output$ship_dates_out <- renderTable({
    thedates <- as.character(ship_dates())
    date_table <- tibble::tibble(Dates = thedates)
    return(date_table)
  })
}

shinyApp(ui = ui, server = server)
