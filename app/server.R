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
      easyClose = TRUE, size = 'm', 
      title = HTML('CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool')
    ))
  }
  )
  
  observeEvent(input$about, {
    showModal(modalDialog(
      includeHTML("text/intro_text.html"),
      easyClose = TRUE, size = 'm', 
      title = HTML('CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool')
    ))
  })
  
  # Modal Calculation ----
  
  observeEvent(input$acute, {
    
    showModal(modalDialog(
      title = "Calculate the number of acute care beds available for COVID-19 cases",
      easyClose = TRUE, size = 'm',
      numericInput('tot_ac_bed', 'Total number of acute care beds', 
                   min = 0, value = 33511),
      sliderInput('tot_ac_av', "Percent of acute care beds available for COVID-19 cases",
                  min = 0, max = 100, value = 25, step = 1,
                  post = '%'),
      numericInput('tot_ac_sur', "Surge acute care beds available for COVID-19 cases",
                   min = 0, max = 100, value = 0),
      actionButton('submit_ac', "Apply Changes", 
                   class = 'btn-success')
    ))
  })
  observeEvent(input$submit_ac, {
    updateNumericInput(session, 'n_acute', 
                       value = round((input$tot_ac_bed * 
                                  (input$tot_ac_av / 100)) + 
                                  (input$tot_ac_sur))
                       )
    removeModal()
  })
  
  observeEvent(input$critical, {
    
    showModal(modalDialog(
      title = "Calculate the number of critical care beds available for COVID-19 cases",
      easyClose = TRUE, size = 'm',
      numericInput('tot_cc_bed', 'Total number of critical care beds', 
                   min = 0, value = 2053),
      sliderInput('tot_cc_av', "Percent of critical care beds available for COVID-19 cases",
                  min = 0, max = 100, value = 25, step = 1,
                  post = '%'),
      numericInput('tot_cc_sur', "Surge critical care beds available for COVID-19 cases",
                   min = 0, max = 100, value = 0),
      actionButton('submit_cc', "Apply Changes", 
                   class = 'btn-success')
    ))
  })
  observeEvent(input$submit_cc, {
    updateNumericInput(session, 'n_crit', 
                       value = round((input$tot_cc_bed * 
                                        (input$tot_cc_av / 100)) + 
                                       (input$tot_cc_sur))
    )
    removeModal()
  })
  
  observeEvent(input$mvent, {
    
    showModal(modalDialog(
      title = "Calculate the number of mechanical ventilators available for COVID-19 cases",
      easyClose = TRUE, size = 'm',
      numericInput('tot_mv_bed', 'Total number of mechanical ventilators', 
                   min = 0, value = 1311),
      sliderInput('tot_mv_av', "Percent of mechanical ventilators available for COVID-19 cases",
                  min = 0, max = 100, value = 25, step = 1,
                  post = '%'),
      numericInput('tot_mv_sur', "Surge mechanical ventilators available for COVID-19 cases",
                   min = 0, max = 100, value = 0),
      actionButton('submit_mv', "Apply Changes", 
                   class = 'btn-success')
    ))
  })
  observeEvent(input$submit_mv, {
    updateNumericInput(session, 'n_vent', 
                       value = round((input$tot_mv_bed * 
                                        (input$tot_mv_av / 100)) + 
                                       (input$tot_mv_sur))
    )
    removeModal()
  })
  
  # Observe n_crit ----
  observeEvent(input$n_crit, {
    feedbackWarning(
      inputId = 'n_crit',
      condition = input$n_crit <= input$n_vent,
      text = "Number of critical care beds are less than the number of mechanical ventilators."
    )
  })
  
  # Observe n_vent ----
  observeEvent(input$n_vent, {
    feedbackWarning(
      inputId = 'n_vent',
      condition = input$n_vent >= input$n_crit,
      text = "Number of mechanical ventilators are greater than the number of critical care beds."
    )
  })
  
  # Data table ----
  
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
    
    if (any(is.na(x[, 2:4]), na.rm = TRUE)) {
      shinyalert('Uh oh!', 'This column can only accept numeric inputs. Please check your numbers!', type = 'error')
    } 
    
    if (!dplyr::near(sum(x[, 'case_dist'], na.rm = TRUE), 100, tol = 0.1)) {
      shinyalert('Uh oh!', 'The case distribution column must sum to 100%. Please check your numbers!', type = 'error')
    }
    
    if (any(x[, 'ac_adm']>100 | x[, 'ac_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', 'The admission rate cannot be less than 0% or greater than 100%. Please check your numbers!', type = 'error')
    }
    
    if (any(x[, 'cc_adm']>100 | x[, 'cc_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', 'The admission rate cannot be less than 0% or greater than 100%. Please check your numbers!', type = 'error')
      x[, 'cc_adm']
    }
    
  })
  
  # Plot results ----
  output$plot <- renderPlotly({
    input$tab_pop_cell_edit
    ma <- maxAcute(x[, 'case_dist'], x[, 'ac_adm'], 
                   input$n_acute, input$lou_acute)
    mc <- maxCrit(x[, 'case_dist'], x[, 'cc_adm'], 
                  input$n_crit, input$lou_crit)
    mv <- maxVent(x[, 'case_dist'], x[, 'cc_adm'], 
                  input$n_crit, input$lou_vent, input$per_vent)
    
    color_scale <- switch(input$colors,
      YlOrRd = scale_fill_manual(values = c('#FFEC19', '#FF9800', '#F6412D')),
      Viridis = scale_fill_viridis_d(),
      Grayscale = scale_fill_grey(),
      Pastel = scale_fill_brewer(palette = 'Set2'),
      Brewer = scale_fill_brewer(),
      Default = scale_fill_hue()
    )
    
    plot_data <- tribble(
      ~name, ~value,
      "Acute Care Beds", ma,
      "Critical Care Beds", mc,
      "Mechanical Ventilators", mv
    )
    
    if (all(is.na(ma), is.na(mv), is.na(mc))) {
      p <- ggplot(plot_data, aes(glue("{name}\n ({value} new cases/day)"), value, fill = name, text = glue("The number of appropriable {name}\n in this healthcare system can manage\n a maximum of {value} daily cases of COVID-19"))) +
        labs(x = '', 
             y = 'Maximum Daily Number of Cases') + 
        color_scale +
        coord_flip() +
        theme_classic() +
        theme(legend.position = 'none')
      p
    } else {
    
    p <- ggplot(plot_data, aes(glue("{name}\n ({scales::comma(value)} new cases/day)"), value, fill = name,
      text = glue("The number of appropriable {name}\n in this healthcare system can manage\n a maximum of {scales::comma(value)} daily cases of COVID-19"))) +
      geom_col(show.legend = FALSE, col = 'black') +
      labs(x = '', 
            y = 'Maximum Daily Number of Cases') + 
      color_scale +
      scale_y_continuous(labels = scales::comma_format()) +
      coord_flip() +
      theme_classic() +
      theme(legend.position = 'none')
    p
    }
    
    ggplotly(p, tooltip = 'text') %>% 
      config(displayModeBar = FALSE) %>% 
      layout(xaxis = list(fixedrange = TRUE)) %>% 
      layout(yaxis = list(fixedrange = TRUE))
    
  })
  
  
  # Generate report ----
  output$report <- downloadHandler(
    filename = function() {
      fmt <- tolower(input$fmt)
      if (fmt=="html") {
        glue("COVID-19_report_{Sys.Date()}.html")
      } else if (fmt=="pdf") {
        glue("COVID-19_report_{Sys.Date()}.pdf") 
      } 
      },
    
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
