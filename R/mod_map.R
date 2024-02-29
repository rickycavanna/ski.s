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

    fillPage(leafletOutput(ns('map'), height = "100vh"))

  )
}

#' map Server Functions
#'
#' @noRd
mod_map_server <- function(id, filter_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    filtered_data <- reactive({filter_data$data})

    output$map <- renderLeaflet({
      leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
        addTiles(urlTemplate = "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                attribution = '©OpenStreetMap, ©CartoDB') %>%
          setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
          addMarkers(
            data = filtered_data(),
            lat = ~Latitude,
            lng = ~Longitude,
            popup = ~Resort
          )
    })
  })
}

## To be copied in the UI
# mod_map_ui("map_1")

## To be copied in the server
# mod_map_server("map_1")
