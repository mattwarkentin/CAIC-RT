# Load packages ----
suppressPackageStartupMessages(source('package-deps.R'))

# Load data ----
source('data.R')

# Load functions ----
source('utils.R')

# Dropdown menu text ----
text <- list(
  contact = "Please contact us at...",
  info = "Very helpful information!"
)



# Navbar UI ----

ui <- 
  navbarPage(
    title = 'COVID-19 Hospitalization Tool',
    fluid = TRUE, position = 'fixed-top', collapsible = TRUE,
    header = tags$style(type="text/css", "body {padding-top: 70px;}"),
    # Home Tool ----
    tabPanel(
      'Home', icon = icon('toolbox'),
      useShinyalert(),
      useShinyFeedback(),
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", 
                  href = "styles.css"),
        tags$link(rel = "stylesheet", type = "text/css", 
                  href = "tachyons.min.css")
      ),
      fluidRow(
        column(3,
               wellPanel(
               h4('Length of Stay'),
               numericInput(inputId = "lou_acute",
                            label = "Average days in acute care",
                            value = 11, min = 1),
               bsTooltip("lou_acute", 
                         "Estimate of the average number of days a patient will remain in acute care.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_crit",
                            label = "Average days in critical care",
                            value = 8, min = 1),
               bsTooltip("lou_crit", 
                         "Estimate of the average number of days a patient will remain in crticial care.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_vent",
                            label = "Average days on a ventilator",
                            value = 7.5, min = 1),
               bsTooltip("lou_vent", 
                         "Estimate of the average number of days a patient will remain on a ventilator.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               )),
        column(3,
               wellPanel(
               h4('Resource Availability'),
               numericInput(inputId = "n_acute",
                            label = "Number of dedicated acute care beds:",
                            value = 178321, min = 0),
               bsTooltip("n_acute", 
                         "Estimate of the number of acute care beds that are dedicated for COVID-19 patients.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "n_crit",
                            label = "Number of dedicated critical care beds:",
                            value = 32199, min = 0),
               bsTooltip("n_crit", 
                         "Estimate of the number of critical care beds that are dedicated for COVID-19 patients.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "n_vent",
                            label = "Number of dedicated ventilators:",
                            value = 20667, min = 0),
               bsTooltip("n_vent", 
                         "Estimate of the number of ventilators that are dedicated for COVID-19 patients.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               sliderInput(inputId = "per_vent",
                            label = "Percentage of critical care patients requiring ventilators:",
                            value = 50, min = 0, max = 100, step = 1, 
                           post = '%'),
               bsTooltip("per_vent", 
                         "Estimate of the percentage of COVID-19 critical care patients that will require ventilators.", 
                         placement = "right", trigger = 'hover',
                         options = list(container = "body")),
               
               
               )),
        column(6,
               
              bsCollapse(id = 'global', multiple = TRUE,
                bsCollapsePanel('Data (click to toggle visibility)',
        DT::dataTableOutput("tab_pop"),
        span(strong('TIP:'), 'Use TAB to navigate through column items when editing. Press CONTROL + ENTER when done editing a column.')
                ), open = 'Data (click to toggle visibility)'
              ),
        
        h4('Maximum allowable COVID case rate [cases per-day]'),
        plotlyOutput('plot'),
        wellPanel(
          radioButtons('fmt', 'Please choose your preferred output format',
                       choices = c('HTML', 'PDF'), selected = 'HTML',
                       inline = TRUE),
          downloadButton('report', 'Generate Report')
          ),
        br(), br()
            )
      )
      ),
    
    
    # Help Page ----
    
    tabPanel(
      'Help', icon = icon('question'),
      includeHTML('../report/help.html')
    ),
    
    # More tab ----
    navbarMenu(
      'More Info',
      tabPanel('Authors',
               icon = icon('signature')),
      tabPanel('Other Resources',
               icon = icon('link')),
      tabPanel(a(span(icon('github'),"See the code"), 
                 href="https://www.github.com/mattwarkentin/covid-hospitalization-app",
                 target="_blank")
    )
  )
  )


