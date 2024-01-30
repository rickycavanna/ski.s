#' filters UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_filters_ui <- function(id){
  ns <- NS(id)
  tagList(
    #useShinyjs(),
    titlePanel("Filter the Destinations"),

    fluidPage(
      fluidRow(
        column(3,
               checkboxGroupInput(ns('region'),label = 'Select Region', choices = c('n.a')),
               checkboxGroupInput(ns('pass'),label = 'Select Pass', choices = c('n.a')),
               selectizeInput(ns('state'), label = 'Select State', choices = c('n.a'),
                              multiple = TRUE,
                              options = list(placeholder = 'select a state name')),
               dataTableOutput(ns('table'))
        )
      )
    )
  )
}

#' filters Server Functions
#'
#' @noRd
mod_filters_server <- function(id, dataIN){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observe({
      updateCheckboxGroupInput(session,'region',label = 'Select Regions', choices = sort(unique(dataIN$Region),))
    })

    observe({
      updateCheckboxGroupInput(session,'pass',label = 'Select Pass', choices = sort(unique(dataIN$Group),))
    })
    #
    # observe({
    #   updateCheckboxGroupInput(session,'state',label = 'Select States', choices = sort(unique(dataIN$State),))
    # })

    observe({
      updateSelectizeInput(session, 'state', label = 'Select States', choices = sort(unique(dataIN$State),))
    })

    filtered_data <- reactive({
      dataIN %>% filter(Region %in% input$region) %>% filter(Group %in% input$pass)
    })

    output$table <- renderDataTable({
      filtered_data()
    })

  })
}

## To be copied in the UI
# mod_filters_ui("filters_1")

## To be copied in the server
# mod_filters_server("filters_1")
