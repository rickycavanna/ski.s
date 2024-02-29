#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    #useShinyjs(),
    titlePanel("Test Map"),

    fluidPage(
      fluidRow(
            column(9,
               DT::dataTableOutput(ns('table'))
        )
      )
    )
  )
}

#' map Server Functions
#'
#' @noRd
mod_map_server <- function(id, filter_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    #specifies the cols to keep
    column_order <- c("Resort", "Region", "Group", "State")

    output$table <- DT::renderDataTable({
      filter_data %>% select(column_order)},
      rownames = F,
      options = list(
        filter = FALSE,
        paging = FALSE,
        ordering = FALSE,
        scrollY = "400px"
      ),
    )

  })
}

## To be copied in the UI
# mod_map_ui("map_1")

## To be copied in the server
# mod_map_server("map_1")
