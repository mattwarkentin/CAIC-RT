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
  '<hr /><footer><p>Developed by <a href="https://www.twitter.com/vasilepi">Vasily Giannakeas</a>, <a href="https://www.twitter.com/NathanStall">Nathan M. Stall</a>, <a href="https://www.twitter.com/BreslowDay">Deepit Bhatia</a>, <a href="https://www.twitter.com/mwark89">Matthew T. Warkentin</a>, and <a href="https://www.twitter.com/BogochIsaac">Isaac I. Bogoch</a>.<p/></footer>'
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
               span(HTML(glue("{strong('Last Updated:')} {Sys.Date()}"))),
            actionButton('about', 'About This Tool', icon = icon('info'), 
                         class = "ma2 btn-primary", style = 'font-variant: small-caps;'),
               wellPanel(
               h4('Expected Length of Stay for COVID-19 Cases'),
               numericInput(inputId = "lou_acute",
                            label = HTML("Mean days in acute care<sup>1</sup>"),
                            value = 11, min = 1),
               bsTooltip("lou_acute", 
                         "Note: Acute care days are mutually exclusive with critical care and ventilator days.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_crit",
                            label = HTML("Mean days in critical care<sup>1</sup>"),
                            value = 8, min = 1),
               bsTooltip("lou_crit", 
                         "Note: Critical care days are mutually exclusive with acute care days. Total number of days spent in critical care are equal to the number of days spent in critical care with or without a ventilator.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_vent",
                            label = HTML("Mean days on a mechanical ventilator<sup>1</sup>"),
                            value = 7.5, min = 1),
               bsTooltip("lou_vent", 
                         "Note: Days spent on mechanical ventilator are assumed to be spent in a critical care bed.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               p(HTML('<sup>1</sup> Default values are based on Chinese data extracted from Zhou <em>et al.</em> (2020) and Wang <em>et al.</em> (2020). See <strong>Help</strong> page for full citations.'), class = 'f5'),
               )
               ),
        
        # Second Column ----
        column(3,
               wellPanel(
               h4('Resource Availability for COVID-19 Cases'),
               
               numericInput(inputId = "n_acute",
                            label = HTML("Number of appropriable acute care beds<sup>2,3</sup>"),
                            value = 8378, min = 0),
               bsTooltip("n_acute", 
                         "Note: This is the number of acute care beds that are available for COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               actionButton('acute', 'Calculate Acute Care Beds',
                            icon = icon('cogs'), class = 'bg-dark-gray white'),
               hr(),
               
               numericInput(inputId = "n_crit",
                            label = HTML("Number of appropriable critical care beds<sup>2,3</sup>"),
                            value = 513, min = 0),
               bsTooltip("n_crit", 
                         "Note: This is the number of critical care beds that are available for COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               actionButton('critical', 'Calculate Critical Care Beds',
                            icon = icon('cogs'), class = 'bg-dark-gray white'),
               hr(),
               
               numericInput(inputId = "n_vent",
                            label = HTML("Number of appropriable mechanical ventilators<sup>2,3</sup>"),
                            value = 328, min = 0),
               bsTooltip("n_vent", 
                         "Note: This is the number of mechanical ventilators that are available for COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               actionButton('mvent', 'Calculate Mechanical Ventilators',
                            icon = icon('cogs'), class = "bg-dark-gray white"),
               hr(),
               
               sliderInput(inputId = "per_vent",
                            label = "Percent of critical care patients requiring mechanical ventilators",
                            value = 50, min = 0, max = 100, step = 1, 
                           post = '%'),
               bsTooltip("per_vent", 
                         "Note: This is the percentage of COVID-19 critical care patients that will require mechanical ventilators.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               p(HTML('<sup>2</sup> Appropriable: The maximum number of acute care beds, critical care beds, and mechanical ventilators that can be used or are currently being used by COVID-19 patients. For example, if a healthcare system has 100 acute care beds, and an occupancy rate of 70%, then the number of appropriable beds is 30 beds plus any surge capacity that can be added. If surge capacity is 50 beds, then the total number of appropriable beds is 30+50 = 80 beds.'), class = 'f5'),
               p(HTML('<sup>3</sup> Default values are based on Ontario data extracted from Barrett <em>et al.</em> (2020). See <strong>Help</strong> page for full citations.'), class = 'f5')
               )),
        
        # Third Column ----
        column(6,
               
              bsCollapse(id = 'global', multiple = TRUE,
                bsCollapsePanel('Age-stratified Case Distribution and Severity (click to toggle visibility)',
        DT::dataTableOutput("tab_pop"),
        p('Source: CDC COVID-19 Response Team. Severe Outcomes Among Patients with Coronavirus Disease 2019 (COVID-19) — United States, February 12–March 16, 2020. MMWR Morb Mortal Wkly Rep. 2020.', class='f5'),
        p(HTML('<strong>TIP:</strong> Double-click a cell to begin editing. Use [TAB] to navigate through column items while editing. Press [CONTROL + ENTER] when done editing a column.'), class = 'f5')
                ), open = ''
              ),
        
        h4('Maximum daily number of new COVID-19 cases manageable by healthcare system'),
        p('The values shown below are thresholds for the maximum daily number of new COVID-19 cases that can occur without causing a resource deficit. In other words, if more cases occur than the values shown, the amount of acute care beds, critical care beds, and mechanical ventilators would be insufficient to meet regional healthcare needs.', class = 'navy'),
        
        span(dropdownButton(size = 'xs', icon = icon('cog'),
                            tooltip = TRUE, inline = TRUE, width = '100px',
                            selectInput('colors', 'Choose Colour Palette',
                                        choices = c('YlOrRd', 'Viridis',
                                                    'Grayscale', 'Pastel', 
                                                    'Brewer', 'Default'),
                                        selected = 'YlOrRd', 
                                        multiple = FALSE)),
             plotlyOutput('plot')),
        br(),
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
      'Help', 
      icon = icon('question'),
      includeHTML('text/help.html')
    ),
    
    # More Info tab ----
    navbarMenu(
      'More Info',
      tabPanel(a(span(icon('file-medical-alt'),"See the article"), 
                 href="#",
                 target="_blank")),
      tabPanel(a(span(icon('github'),"See the code"), 
                 href="https://www.github.com/mattwarkentin/covid-hospitalization-app",
                 target="_blank")
    )
  )
  )


