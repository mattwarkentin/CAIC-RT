# Load packages ----
source('package-deps.R')

# Load functions ----
source('utils.R')

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

# Based on ISO 639-2/B
# https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
langs <- sort(c('English' = 'eng', 'Spanish' = 'spa',
                'French' = 'fre'))

ui <- function(request) {
  navbarPage(
    # Navbar ----
    title = 'CAIC-RT',
    footer = htmlOutput('dev_by'),
    inverse = TRUE,
    fluid = TRUE,
    position = 'fixed-top',
    collapsible = TRUE,
    header = tags$style(type="text/css", "body {padding-top: 70px;}"),
    # Home Tool ----
    tabPanel(
      htmlOutput('home'),
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
                         class = "mb3 btn-primary f4 f5-ns small-caps")
            ,
            actionButton('contribute', ' How can I contribute?',
                         icon = icon('hands-helping'),
                         class = 'f4 f5-ns bg-gold hover-bg-yellow small-caps mb3'),
               wellPanel(
               htmlOutput('p1_header'),
               numericInput(inputId = "lou_acute",
                            label = htmlOutput('lou_acute_label'),
                            value = round((10 + (5 * 26.7 / 100))),
                            min = 1),

               numericInput(inputId = "lou_crit",
                            label = htmlOutput('lou_crit_label'),
                            value = 9, min = 1),

               numericInput(inputId = "lou_vent",
                            label = htmlOutput('lou_vent_label'),
                            value = 9, min = 1),

               htmlOutput('p1_footnote'),
               )
               ),

        # Second Column ----
        column(4,
               wellPanel(
               htmlOutput('p2_header'),

               numericInput(inputId = "n_acute",
                            label = htmlOutput('n_acute_label'),
                            value = 8378, min = 0),
               actionButton('acute', 'Calculate Acute Care Beds',
                            icon = icon('cogs'),
                            class = 'bg-dark-gray white f5 f5-l f7-m'),
               hr(),

               numericInput(inputId = "n_crit",
                            label = htmlOutput('n_crit_label'),
                            value = 513, min = 0),
               actionButton('critical', 'Calculate Critical Care Beds',
                            icon = icon('cogs'),
                            class = 'bg-dark-gray white f5 f5-l f7-m'),
               hr(),

               numericInput(inputId = "n_vent",
                            label = htmlOutput('n_vent_label'),
                            value = 328, min = 0),
               actionButton('mvent', 'Calculate Mechanical Ventilators',
                            icon = icon('cogs'),
                            class = "bg-dark-gray white f5 f5-l f7-m mb4"),

               htmlOutput('p2_footnote_2')
               ), bsCollapse(id = 'global', multiple = TRUE,
                             bsCollapsePanel(
                               title = htmlOutput('table_title'),
                               uiOutput('input_data'),
                               DT::dataTableOutput("tab_pop"),
                               htmlOutput('table_source'),
                               htmlOutput('table_tip'),
                               actionButton('reset', 'Reset', class = 'btn-warning f4 f4-l f5-m',
                                            icon = icon('redo')),
                               hr(),
                               sliderInput(inputId = "per_vent",
                                           label = htmlOutput('per_vent_label'),
                                           value = 70, min = 0, max = 100, step = 1,
                                           post = '%'),
                               htmlOutput('p2_footnote_1'),
                               style = 'primary'
                             ), open = ''
               )),

        # Third Column ----
        column(5,
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
          tabsetPanel(id = 'interpretations',
                      tabPanel(htmlOutput('acute_res_title'),
                               br(),
                               htmlOutput('acute_int')),
                      tabPanel(htmlOutput('crit_res_title'),
                               br(),
                               htmlOutput('crit_int')),
                      tabPanel(htmlOutput('vent_res_title'),
                               br(),
                               htmlOutput('mv_int'))),
          hr(),
          div(uiOutput('report', class = 'dib'),
               uiOutput('bookmark', class = 'dib'),
              class = 'tc')
          )
            )
      )
      ),

    # Help Page ----
    tabPanel(
      htmlOutput('help'),
      htmlOutput('help_text')
    ),
    # What's New? ----
    tabPanel(htmlOutput('whats_new'),
             htmlOutput('whats_new_text')),

    # Tutorial ----
    tabPanel(htmlOutput('tutorial'),
             HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/owjI123tUrE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')),

    # More Info ----
    navbarMenu(htmlOutput('more_info', inline = TRUE),
               tabPanel(tags$a(htmlOutput('see_article'), href = "https://www.acpjournals.org/doi/10.7326/M20-1169", target = "_blank")),
               tabPanel(tags$a(htmlOutput('see_code'), href = "https://www.github.com/mattwarkentin/CAIC-RT", target = "_blank"))
    )
  )
}
