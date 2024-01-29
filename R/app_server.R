#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  resorts <- read.csv("data-raw/resort_info.csv")

  # Your application server logic
  mod_filters_server("filters_1", dataIN = resorts)
  mod_map_server("map_1")
  mod_weather_server("weather_1")
}
