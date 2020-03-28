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

langs <- sort(c('English' = 'eng', 'French' = 'fr'))

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
      'Home', 
      icon = icon('toolbox'),
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
               htmlOutput('last_update'),
               selectInput('lang', 'Choose Language', 
                           choices = langs,
                           selected = 'English',  
                           multiple = FALSE),
            actionButton('about_tool', ' About This Tool', icon = icon('info'), 
                         class = "mb3 btn-primary f5", style = 'font-variant: small-caps;')
            ,
            actionButton('contribute', ' How can I contribute?',
                         icon = icon('hands-helping'), 
                         class = 'f5 bg-gold hover-bg-yellow small-caps mb3'),
               wellPanel(
               htmlOutput('p1_header'),
               numericInput(inputId = "lou_acute",
                            label = HTML("Mean days in acute care"),
                            value = 11, min = 1),
               
               numericInput(inputId = "lou_crit",
                            label = HTML("Mean days in critical care"),
                            value = 20, min = 1),
               
               numericInput(inputId = "lou_vent",
                            label = HTML("Mean days on a mechanical ventilator"),
                            value = 20, min = 1),
               
               htmlOutput('p1_footnote'),
               )
               ),
        
        # Second Column ----
        column(3,
               wellPanel(
               htmlOutput('p2_header'),
               
               numericInput(inputId = "n_acute",
                            label = HTML("Number of acute care beds for COVID-19 patients"),
                            value = 8378, min = 0),
               actionButton('acute', 'Calculate Acute Care Beds',
                            icon = icon('cogs'), class = 'bg-dark-gray white'),
               hr(),
               
               numericInput(inputId = "n_crit",
                            label = HTML("Number of critical care beds for COVID-19 patients"),
                            value = 513, min = 0),
               actionButton('critical', 'Calculate Critical Care Beds',
                            icon = icon('cogs'), class = 'bg-dark-gray white'),
               hr(),
               
               numericInput(inputId = "n_vent",
                            label = HTML("Number of mechanical ventilators for COVID-19 patients"),
                            value = 328, min = 0),
               actionButton('mvent', 'Calculate Mechanical Ventilators',
                            icon = icon('cogs'), class = "bg-dark-gray white"),
               hr(),
               
               sliderInput(inputId = "per_vent",
                            label = HTML("Percent of critical care patients requiring mechanical ventilation"),
                            value = 50, min = 0, max = 100, step = 1, 
                           post = '%'),
               bsTooltip("per_vent", 
                         "Note: This is the percentage of COVID-19 critical care patients requiring mechanical ventilation.", 
                         placement = "bottom", trigger = 'hover',
                         options = list(container = "body")),
               htmlOutput('p2_footnote_1'),
               htmlOutput('p2_footnote_2')
               )),
        
        # Third Column ----
        column(6,
               
              bsCollapse(id = 'global', multiple = TRUE,
                bsCollapsePanel(
                  title = htmlOutput('table_title'),
        DT::dataTableOutput("tab_pop"),
        p('Source: CDC COVID-19 Response Team. Severe Outcomes Among Patients with Coronavirus Disease 2019 (COVID-19) — United States, February 12–March 16, 2020. MMWR Morb Mortal Wkly Rep. 2020.', class='f5'),
        htmlOutput('table_tip'), style = 'primary'
                ), open = ''
              ),
        
        htmlOutput('plot_title'),
        htmlOutput('plot_desc'),

        span(dropdownButton(size = 'xs', icon = icon('cog'),
                            tooltip = TRUE, inline = TRUE, width = '200px',
                            selectInput('colors', 'Choose Colour Palette',
                                        choices = c('YlOrRd', 'Viridis',
                                                    'Grayscale', 'Pastel', 
                                                    'Brewer', 'Default'),
                                        selected = 'YlOrRd', 
                                        multiple = FALSE)),
             plotlyOutput('plot')),
        wellPanel(
          htmlOutput('interpret_title'),
          tabsetPanel(id = 'intepretations',
                      tabPanel(htmlOutput('acute_res_title'),
                               br(),
                               textOutput('acute_int')),
                      tabPanel(htmlOutput('crit_res_title'),
                               br(),
                               textOutput('crit_int')),
                      tabPanel(htmlOutput('vent_res_title'),
                               br(),
                               textOutput('mv_int'))),
          hr(),
          div(uiOutput('report'), class = 'tc')
          )
            )
      )
      ),
    
    
    # Help Page ----
    tabPanel(
      'Help', 
      icon = icon('question'),
      htmlOutput('help_text')
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


