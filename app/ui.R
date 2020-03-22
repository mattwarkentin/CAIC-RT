# Load packages ----
suppressPackageStartupMessages(source('package-deps.R'))

# Load functions ----
source('utils.R')

# Dropdown menu text ----
text <- list(
  contact = "Please contact us at...",
  info = "Very helpful information!"
)

# Footer text ----

footer <- HTML(
  '<footer><p>Developed by <a href="https://www.twitter.com/vasilepi">Vasily Giannakeas</a>, <a href="https://www.twitter.com/NathanStall">Nathan M. Stall</a>, <a href="https://www.twitter.com/BreslowDay">Deepit Bhatia</a>, <a href="https://www.twitter.com/mwark89">Matthew T. Warkentin</a>, and <a href="https://www.twitter.com/BogochIsaac">Isaac I. Bogoch</a>.<p/></footer>'
  )

# Navbar UI ----

ui <- 
  navbarPage(
    # Navbar ----
    title = 'CAIC-RT',
    footer = footer,
    inverse = TRUE,
    fluid = TRUE, 
    position = 'fixed-top', 
    collapsible = TRUE,
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
        
        # First Column ----
        column(3,
               p(HTML(glue("{strong('Last Updated:')} {Sys.Date()}"))),
               wellPanel(
               h4('Length of Stay'),
               numericInput(inputId = "lou_acute",
                            label = HTML("Mean days in acute care<sup>*</sup>"),
                            value = 11, min = 1),
               bsTooltip("lou_acute", 
                         "Note: Acute care days are mutually exclusive with critical care and ventilator days.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_crit",
                            label = HTML("Mean days in critical care<sup>*</sup>"),
                            value = 8, min = 1),
               bsTooltip("lou_crit", 
                         "Note: Critical care days are mutually exclusive with acute care days. Total number of days spent in critical care are equal to the number of days spent in critical care with or without a ventilator.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_vent",
                            label = HTML("Mean days on a mechanical ventilator<sup>*</sup>"),
                            value = 7.5, min = 1),
               bsTooltip("lou_vent", 
                         "Note: Days spent on mechanical ventilator are assumed to be spent in a critical care bed.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               p(HTML('<sup>*</sup> Default values come from CDC report.')),
               p(HTML('Citation: CDC COVID-19 Response Team. <a href="https://www.cdc.gov/mmwr/volumes/69/wr/mm6912e2.htm">Severe Outcomes Among Patients with Coronavirus Disease 2019 (COVID-19)</a> — United States, February 12–March 16, 2020. MMWR Morb Mortal Wkly Rep. 2020. '))
               )
               ),
        
        # Second Column ----
        column(3,
               wellPanel(
               h4('Resource Availability for COVID-19 Cases'),
               numericInput(inputId = "n_acute",
                            label = HTML("Number of appropriable acute care beds<sup>*</sup>"),
                            value = 144661, min = 0),
               bsTooltip("n_acute", 
                         "Estimate of the number of acute care beds that are appropriable for COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "n_crit",
                            label = HTML("Number of appropriable critical care beds<sup>*</sup>"),
                            value = 32199, min = 0),
               bsTooltip("n_crit", 
                         "Estimate of the number of critical care beds that are appropriable for COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "n_vent",
                            label = HTML("Number of appropriable ventilators<sup>*</sup>"),
                            value = 20667, min = 0),
               bsTooltip("n_vent", 
                         "Estimate of the number of ventilators that are appropriable for COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               sliderInput(inputId = "per_vent",
                            label = "Percent of critical care patients requiring mechanical ventilators",
                            value = 50, min = 0, max = 100, step = 1, 
                           post = '%'),
               bsTooltip("per_vent", 
                         "Estimate of the percentage of COVID-19 critical care patients that will require ventilators.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               p(HTML('<sup>*</sup> Appropriable: The maximum number of acute care beds, critical care beds, and mechanical ventilators that can be used or are currently being used by COVID-19 patients. For example, if a healthcare system has 100 acute care beds, and an occupancy rate of 70%, then the number of appropriable beds is 30 beds plus any surge capacity that can be added. If surge capacity is 50 beds, then the total number of appropriable beds is 30+50 = 80 beds.'))
               )),
        
        # Third Column ----
        column(6,
               
              bsCollapse(id = 'global', multiple = TRUE,
                bsCollapsePanel('Age-stratified Case Distribution and Severity (click to toggle visibility)',
        DT::dataTableOutput("tab_pop"),
        span(strong('TIP:'), 'Double-click a cell to begin editing. Use [TAB] to navigate through column items while editing. Press [CONTROL + ENTER] when done editing a column.')
                ), open = 'Age-stratified Case Distribution and Severity (click to toggle visibility)'
              ),
        
        h4('Maximum daily number of COVID-19 cases sustainable by healthcare system'),
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
      includeHTML('text/help.html')
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


