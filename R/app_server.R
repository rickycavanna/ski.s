#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  resorts <- read.csv("data-raw/resort_info.csv")
  filtered_data <- reactiveValues(data = NULL)

  # Your application server logic
  mod_filters_server("filters_1", dataIN = resorts, filtered_data = filtered_data)
  mod_map_server("map_1", filter_data = filtered_data)
  mod_weather_server("weather_1")
}
