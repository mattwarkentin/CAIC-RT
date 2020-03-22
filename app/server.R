server <- function(input, output, session) {
  # US Data ----
  default_table <- 
    tribble(
      ~age_dist, ~case_dist, ~ac_adm, ~cc_adm,
      "0-19", 5.02, 2.5, 0,
      "20-44", 28.8, 20.8, 4.2,
      "45-54", 17.5, 28.3, 4.2,
      "55-64", 17.5, 30.1, 11.2,
      "65-74", 16.7, 43.5, 18.8,
      "75-84", 8.57, 58.7, 31,
      "85+", 5.88, 70.3, 29
    )
  
  # Intro Model ----
  observeEvent("", {
    showModal(modalDialog(
      includeHTML("text/intro_text.html"),
      easyClose = TRUE
    ))
  }
  )
  
  # Observe n_crit ----
  observeEvent(input$n_crit, {
    feedbackWarning(
      inputId = 'n_crit',
      condition = input$n_crit <= input$n_vent,
      text = "Number of critical care beds are less than the number of ventilators."
    )
  })
  
  # Observe n_vent ----
  observeEvent(input$n_vent, {
    feedbackWarning(
      inputId = 'n_vent',
      condition = input$n_vent >= input$n_crit,
      text = "Number of ventilators are greater than the number of critical care beds."
    )
  })
  
  # Data Table ----
  
  x <- data.frame(default_table)
  
  output$tab_pop <-
    DT::renderDT(
      DT::datatable(
      x,
      editable = 'column',
      selection = 'none',
      rownames = FALSE,
      extensions = c('Buttons'),
      options = list(
        paging = FALSE,
        searching = FALSE,
        ordering = FALSE,
        dom = 'tB',
        keys = TRUE,
        buttons = c('copy', 'csv', 'excel')),
      colnames = c("Age groups", "Case distribution [report as %]", 
                   "Acute care admission [report as %]", 
                   "Critical care admission [report as %]")
      ) %>% 
        formatString(columns = c(2,3,4), suffix = '%')
      )
  
  proxy <- dataTableProxy('tab_pop')
  
  observeEvent(input$tab_pop_cell_edit, {
    
    x <<- editData(x, input$tab_pop_cell_edit, 'proxy', rownames = FALSE)
    
    if (!dplyr::near(sum(x[, 'case_dist'], na.rm = TRUE), 100, tol = 0.1)) {
      shinyalert('Uh oh!', 'The case distribution column must add up to 100%!', type = 'error')
    }
    
    if (any(x[, 'ac_adm']>100 | x[, 'ac_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', 'The admission rate cannot be less than 0, or greater than 100', type = 'error')
    }
    
    if (any(x[, 'cc_adm']>100 | x[, 'cc_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', 'The admission rate cannot be less than 0, or greater than 100', type = 'error')
      x[, 'cc_adm']
    }
    
  })
  
  # Output results ----
  output$plot <- renderPlotly({
    input$tab_pop_cell_edit
    ma <- maxAcute(x[, 'case_dist'], x[, 'ac_adm'], 
                   input$n_acute, input$lou_acute)
    mc <- maxCrit(x[, 'case_dist'], x[, 'cc_adm'], 
                  input$n_crit, input$lou_crit)
    mv <- maxVent(x[, 'case_dist'], x[, 'cc_adm'], 
                  input$n_crit, input$lou_vent, input$per_vent)
    
    plot_data <- tribble(
      ~name, ~value,
      "Acute Care Beds", ma,
      "Crtical Care Beds", mc,
      "Mechanical Ventilators", mv
    )
    
    p <- ggplot(plot_data, aes(name, value, fill = name,
                               text = glue("{name}",
                                           "Maximum: {scales::comma(value)}", 
                                           .sep = '\n'))) +
      geom_col(show.legend = FALSE, col = 'black') +
      labs(x = '', y = 'Maximum Daily Number of Cases') + 
      scale_fill_manual(values = c('#FFEC19', '#FF9800', '#F6412D')) +
      scale_y_continuous(labels = scales::comma_format()) +
      coord_flip() +
      theme_classic() +
      theme(legend.position = 'none')
    
    ggplotly(p, tooltip = c('text'))
  })
  
  # Generate report ----
  output$report <- downloadHandler(
    filename = glue("COVID-19_report_{Sys.Date()}.{tolower(input$fmt)}"),
    content = function(file) {
      withProgress(message = "Generating report...",
                   detail = 'Hold tight, this may take a few moments.',
                   {
      incProgress(0.25)
      tempReport <- file.path(tempdir(), "report.Rmd")
      incProgress(0.25)
      file.copy("text/report.Rmd", tempReport, overwrite = TRUE)
      incProgress(0.25)
      params <- list(
        maxAcute = maxAcute(x[, 'case_dist'], x[, 'ac_adm'],
                            input$n_acute, input$lou_acute), 
        maxCrit = maxCrit(x[, 'case_dist'], x[, 'cc_adm'],
                            input$n_crit, input$lou_crit), 
        maxVent = maxVent(x[, 'case_dist'], x[, 'cc_adm'],
                            input$n_crit, input$lou_crit, input$per_vent), 
        inputData = x,
        input = reactiveValuesToList(input)
        )
      incProgress(0.25)
      rmarkdown::render(
        tempReport,
        output_file = file,
        params = params,
        output_format = glue('{tolower(input$fmt)}_document'),
        envir = new.env(parent = globalenv())
        )
      })
      
    }
  )
}
