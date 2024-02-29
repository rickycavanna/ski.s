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
                              options = list(placeholder = 'select a state name'))),
        column(9,
          DT::dataTableOutput(ns('table'), height = "100vh")
        )
      )
    )
  )
}

#' filters Server Functions
#'
#' @noRd
mod_filters_server <- function(id, dataIN, filtered_data = filtered_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observe({
      updateCheckboxGroupInput(session,'region',label = 'Select Regions',
                               choices = sort(unique(dataIN$Region)),
                               selected = sort(unique(dataIN$Region)))
    })

    observe({
      updateCheckboxGroupInput(session, 'pass', label = 'Select Pass',
                               choices = sort(unique(dataIN$Group)),
                               selected = sort(unique(dataIN$Group)))
    })

    observe({
      updateSelectizeInput(session, 'state', label = 'Select States',
                           choices = sort(unique(dataIN$State),))
    })

    filtered <- reactive({
      if (length(input$state) > 0) {
        dataIN %>%
          filter(Region %in% input$region) %>%
          filter(Group %in% input$pass) %>%
          filter(State %in% input$state)
      } else {
        dataIN %>%
          filter(Region %in% input$region) %>%
          filter(Group %in% input$pass)
      }
    })

    #specifies the cols to keep
    column_order <- c("Resort", "Region", "Group", "State")

    output$table <- DT::renderDataTable({
      filtered() %>%
        select(all_of(column_order))},
      rownames = F,
      options = list(
        filter = FALSE,
        paging = FALSE,
        ordering = FALSE,
        scrollY = "450px"
        ),
      )

    observe({
      filtered_data$data <- filtered()
    })
  })
}

## To be copied in the UI
# mod_filters_ui("filters_1")

## To be copied in the server
# mod_filters_server("filters_1")
