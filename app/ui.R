# Load packages ----
suppressPackageStartupMessages(source('package-deps.R'))

# Load functions ----
source('utils.R')

# Footer text ----

track_twitter <- function(name, handle, label, value = 1) {
  a(
    glue('{name}'),
    href = glue('https://www.twitter.com/{handle}'),
    target = '_blank',
    #onclick = glue('ga("send", "event", "click", "link", "{label}", {value})')
    )
}

footer <- 
  HTML(
    glue(
      "<hr /><footer><p>Developed by ",
      "{track_twitter('Vasily Giannakeas', 'vasilepi', 'twitter_vg', 1)}, ",
      "{track_twitter('Deepit Bhatia', 'BreslowDay', 'twitter_db', 1)}, ",
      "{track_twitter('Matthew T. Warkentin', 'mattwrkntn', 'twitter_mtw', 1)}, ",
      "{track_twitter('Isaac I. Bogoch', 'BogochIsaac', 'twitter_iib', 1)}, ",
      "and ",
      "{track_twitter('Nathan M. Stall', 'NathanStall', 'twitter_nms', 1)}",
      " (Toronto, Canada).<p/></footer>"
    ))

# Meta Content ----
tool_meta <- 
  meta() %>%
  meta_general(
    application_name = "CAIC-RT",
    description = "An online tool capable of estimating the maximum daily number of incident COVID-19 cases manageable by healthcare systems."
  ) %>% 
  meta_social(
    title = "CAIC-RT - COVID-19 Acute and Intensive Care Resource Tool",
    description = "An online tool capable of estimating the maximum daily number of incident COVID-19 cases manageable by healthcare systems.",
    url = "https://caic-rt.shinyapps.io/CAIC-RT",
    image = "https://images.unsplash.com/photo-1584118624012-df056829fbd0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1778&q=80",
    image_alt = "Image of the coronavirus courtesy of the CDC",
    twitter_card_type = "summary",
    og_author = c('Vasily Giannakeas', 'Deepit Bhatia',
                  'Matthew T. Warkentin', 'Isaac I. Bogoch', 'Nathan M. Stall')
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
      tool_meta,
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", 
                  href = "styles.css"),
        tags$link(rel = "stylesheet", type = "text/css", 
                  href = "tachyons.min.css"),
        includeHTML('www/google-analytics.html')
      ),
      
      fluidRow(
        
        # First Column ----
        column(3,
               span(HTML(glue("{strong('Last Updated:')} {Sys.Date()}"))),
            actionButton('about_tool', 'About This Tool', icon = icon('info'), 
                         class = "ma2 btn-primary f4", style = 'font-variant: small-caps;'),
               wellPanel(
               h4('Expected Resource Utilization for COVID-19 Patients'),
               numericInput(inputId = "lou_acute",
                            label = HTML("Mean days in acute care<sup>1</sup>"),
                            value = 11, min = 1),
               bsTooltip("lou_acute", 
                         "Note: Acute care days are mutually exclusive of critical care and ventilator days.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_crit",
                            label = HTML("Mean days in critical care<sup>1</sup>"),
                            value = 20, min = 1),
               bsTooltip("lou_crit", 
                         "Note: Critical care days are mutually exclusive of acute care days. Total number of days spent in critical care are equal to the number of days spent in critical care with or without a ventilator.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               numericInput(inputId = "lou_vent",
                            label = HTML("Mean days on a mechanical ventilator<sup>1</sup>"),
                            value = 20, min = 1),
               bsTooltip("lou_vent", 
                         "Note: Days spent on a mechanical ventilator are assumed to be spent in a critical care bed.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               
               p(HTML('<sup>1</sup> Default values are based on data extracted from Zhou <em>et al.</em> (2020), Yang <em>et al.</em> (2020), and Wang <em>et al.</em> (2020), collected in China. See <strong>Help</strong> page for full citations.'), class = 'f5'),
               )
               ),
        
        # Second Column ----
        column(3,
               wellPanel(
               h4('Resource Availability'),
               
               numericInput(inputId = "n_acute",
                            label = HTML("Number of acute care beds for COVID-19 patients<sup>2</sup>"),
                            value = 8378, min = 0),
               bsTooltip("n_acute", 
                         "Note: This is the total number of acute care beds that are available for or are currently being used by COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               actionButton('acute', 'Calculate Acute Care Beds',
                            icon = icon('cogs'), class = 'bg-dark-gray white'),
               hr(),
               
               numericInput(inputId = "n_crit",
                            label = HTML("Number of critical care beds for COVID-19 patients<sup>2</sup>"),
                            value = 513, min = 0),
               bsTooltip("n_crit", 
                         "Note: This is the total number of critical care beds that are available for or are currently being used by COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               actionButton('critical', 'Calculate Critical Care Beds',
                            icon = icon('cogs'), class = 'bg-dark-gray white'),
               hr(),
               
               numericInput(inputId = "n_vent",
                            label = HTML("Number of mechanical ventilators for COVID-19 patients<sup>2</sup>"),
                            value = 328, min = 0),
               bsTooltip("n_vent", 
                         "Note: This is the total number of mechanical ventilators that are available for or are currently being used by COVID-19 patients.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               actionButton('mvent', 'Calculate Mechanical Ventilators',
                            icon = icon('cogs'), class = "bg-dark-gray white"),
               hr(),
               
               sliderInput(inputId = "per_vent",
                            label = HTML("Percent of critical care patients requiring mechanical ventilation<sup>1</sup>"),
                            value = 50, min = 0, max = 100, step = 1, 
                           post = '%'),
               bsTooltip("per_vent", 
                         "Note: This is the percentage of COVID-19 critical care patients requiring mechanical ventilation.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               p(HTML('<sup>1</sup> Default values are based on data extracted from Zhou <em>et al.</em> (2020) and Wang <em>et al.</em> (2020), collected in China. See <strong>Help</strong> page for full citations.'), class = 'f5'),
               p(HTML('<sup>2</sup> Default values are based on data extracted from Barrett <em>et al.</em> (2020), collected in Ontario. See <strong>Help</strong> page for full citations.'), class = 'f5')
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
        
        h4('Maximum daily number of incident COVID-19 cases manageable by healthcare system'),
        p("The values shown below are thresholds for the maximum daily number of incident COVID-19 cases that can occur without causing a resource deficit. In other words, if more cases occur than the values shown below, the amount of acute care beds, critical care beds, and/or mechanical ventilators would be insufficient to meet the healthcare system's needs.", class = 'navy'),

        span(dropdownButton(size = 'xs', icon = icon('cog'),
                            tooltip = TRUE, inline = TRUE, width = '100px',
                            selectInput('colors', 'Choose Colour Palette',
                                        choices = c('YlOrRd', 'Viridis',
                                                    'Grayscale', 'Pastel', 
                                                    'Brewer', 'Default'),
                                        selected = 'YlOrRd', 
                                        multiple = FALSE)),
             plotlyOutput('plot')),
        wellPanel(
          span(h4("Interpreting the Results", style = "display: inline"),
               downloadButton('report', 'Generate PDF Report', 
                             class = "btn-primary f5")
               ),
          tabsetPanel(id = 'intepretations',
                      tabPanel('Acute Care',
                               br(),
                               textOutput('acute_int')),
                      tabPanel('Critical Care',
                               br(),
                               textOutput('crit_int')),
                      tabPanel('Mechanical Ventilators',
                               br(),
                               textOutput('mv_int'))
          )
          )
            )
      )
      ),
    
    
    # Help Page ----
    tabPanel(
      'Help', 
      icon = icon('question'),
      includeHTML('lang/eng/help.html')
    ),
    
    # More Info tab ----
    navbarMenu(
      'More Info',
      tabPanel(a(span(icon('file-medical-alt'),"See the article"), 
                 href="https://www.medrxiv.org/content/10.1101/2020.03.25.20043711v1",
                 target="_blank"
                 )),
      tabPanel(a(span(icon('github'),"See the code"), 
                 href="https://www.github.com/mattwarkentin/CAIC-RT",
                 target="_blank"
                 )
    )
  )
  )


