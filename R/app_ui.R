#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#'
library(shinydashboard)

app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    dashboardPage(
      dashboardHeader(title = "Ski Info", titleWidth = 150),
      dashboardSidebar(
        width = 150,
        sidebarMenu(
          menuItem("Filter Resorts", tabName = "fltr"),
          menuItem("Resort Map", tabName = "map"),
          menuItem("Resort Weather", tabName = "weather")
        )
      ),
      dashboardBody(
        tabItems(
          #filters
          tabItem(tabName = "fltr", fluidPage(
            mod_filters_ui("filters_1")
          )),

          #maps
          tabItem(tabName = "map", fluidPage(
            mod_map_ui("map_1")
          )),

          #weather
          tabItem(tabName = "weather", fluidPage(
            mod_weather_ui("weather_1")
          ))
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "ski.stuff"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

