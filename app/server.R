server <- function(input, output, session) {
  # US Case Distribution Data ----
  default_table <- 
    tribble(
      ~age_dist, ~case_dist, ~ac_adm, ~cc_adm,
      "0-19", 5.02, 2.05, 0,
      "20-44", 28.8, 17.55, 3.10,
      "45-54", 17.5, 24.75, 7.90,
      "55-64", 17.5, 25.30, 7.95,
      "65-74", 16.7, 36.05, 13.45,
      "75-84", 8.57, 44.60, 20.75,
      "85+", 5.88, 50.80, 17.65
    )
  
  # Welcome Modal ----
  observeEvent("", {
    showModal(modalDialog(
      includeHTML("lang/eng/intro_text.html"),
      easyClose = TRUE, size = 'm', 
      title = HTML('CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool')
    ))
  }
  )
  
  observeEvent(input$about_tool, {
    showModal(modalDialog(
      includeHTML("lang/eng/intro_text.html"),
      easyClose = TRUE, size = 'm', 
      title = HTML('CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool')
    ))
  })
  
  # Modal Resource Calculations ----
  
  tot_ac_bed <- 33511; tot_ac_av <- 25; tot_ac_sur <- 0
  tot_cc_bed <- 2053; tot_cc_av <- 25; tot_cc_sur <- 0
  tot_mv_bed <- 1311; tot_mv_av <- 25; tot_mv_sur <- 0
  
  observeEvent(input$acute, {
    
    showModal(modalDialog(
      title = "Calculate the number of acute care beds available for COVID-19 cases",
      easyClose = TRUE, size = 'm',
      numericInput('tot_ac_bed', 'Total number of acute care beds', 
                   min = 0, value = tot_ac_bed),
      sliderInput('tot_ac_av', "Percent of acute care beds available for or currently being used by COVID-19 cases",
                  min = 0, max = 100, value = tot_ac_av, step = 1,
                  post = '%'),
      numericInput('tot_ac_sur', "Acute care bed surge capacity for COVID-19 cases (number of beds)",
                   min = 0, max = 100, value = tot_ac_sur),
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
  observeEvent({
    input$tot_ac_bed
    input$tot_ac_av
    input$tot_ac_sur
  }, {
    tot_ac_bed <<- input$tot_ac_bed
    tot_ac_av <<- input$tot_ac_av
    tot_ac_sur <<- input$tot_ac_sur
  })
  
  observeEvent(input$critical, {
    
    showModal(modalDialog(
      title = "Calculate the number of critical care beds available for COVID-19 cases",
      easyClose = TRUE, size = 'm',
      numericInput('tot_cc_bed', 'Total number of critical care beds', 
                   min = 0, value = tot_cc_bed),
      sliderInput('tot_cc_av', "Percent of critical care beds available for or currently being used by COVID-19 cases",
                  min = 0, max = 100, value = tot_cc_av, step = 1,
                  post = '%'),
      numericInput('tot_cc_sur', "Critical care bed surge capacity for COVID-19 cases (number of beds)",
                   min = 0, max = 100, value = tot_cc_sur),
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
  observeEvent({
    input$tot_cc_bed
    input$tot_cc_av
    input$tot_cc_sur
  }, {
    tot_cc_bed <<- input$tot_cc_bed
    tot_cc_av <<- input$tot_cc_av
    tot_cc_sur <<- input$tot_cc_sur
  })
  
  observeEvent(input$mvent, {
    
    showModal(modalDialog(
      title = "Calculate the number of mechanical ventilators available for COVID-19 cases",
      easyClose = TRUE, size = 'm',
      numericInput('tot_mv_bed', 'Total number of mechanical ventilators', 
                   min = 0, value = tot_mv_bed),
      sliderInput('tot_mv_av', "Percent of mechanical ventilators available for or currently being used by COVID-19 cases",
                  min = 0, max = 100, value = tot_mv_av, step = 1,
                  post = '%'),
      numericInput('tot_mv_sur', "Mechanical ventilator surge capacity for COVID-19 cases (number of ventilators)",
                   min = 0, max = 100, value = tot_mv_sur),
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
  observeEvent({
    input$tot_mv_bed
    input$tot_mv_av
    input$tot_mv_sur
  }, {
    tot_mv_bed <<- input$tot_mv_bed
    tot_mv_av <<- input$tot_mv_av
    tot_mv_sur <<- input$tot_mv_sur
  })
  
  # Observe Number of CC Beds ----
  observeEvent({
    input$n_vent
    input$n_crit
  }, {
    feedbackWarning(
      inputId = 'n_crit',
      condition = input$n_crit < input$n_vent,
      text = "Warning: Number of critical care beds is less than the number of mechanical ventilators."
    )
  })
  
  # Observe Number of MV ----
  observeEvent({
    input$n_vent
    input$n_crit
    }, {
    feedbackWarning(
      inputId = 'n_vent',
      condition = input$n_vent > input$n_crit,
      text = "Warning: Number of mechanical ventilators is greater than the number of critical care beds."
    )
  })
  
  # Data Table ----
  
  x <- data.frame(default_table)
  
  output$tab_pop <- DT::renderDT(
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
        colnames = c("Age groups", 
                     "Case distribution (%)", 
                     "Acute care admission (%)", 
                     "Critical care admission (%)")
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
      shinyalert('Uh oh!', 'Admission rates cannot be less than 0% or greater than 100%. Please check your numbers!', type = 'error')
    }
    
    if (any(x[, 'cc_adm']>100 | x[, 'cc_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', 'Admission rates cannot be less than 0% or greater than 100%. Please check your numbers!', type = 'error')
      x[, 'cc_adm']
    }
    
  })
  
  # Plotly Results ----
  
  output$plot <- renderPlotly({
    input$tab_pop_cell_edit
    
    ma <- maxAcute(x[, 'case_dist'], x[, 'ac_adm'], 
                            input$n_acute, input$lou_acute)
    
    mc <- maxCrit(x[, 'case_dist'], x[, 'cc_adm'], 
                           input$n_crit, input$lou_crit)
    
    mv <- maxVent(x[, 'case_dist'], x[, 'cc_adm'], 
                           input$n_vent, input$lou_vent, input$per_vent)
    
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
      p <- ggplot(plot_data, aes(glue("{name}\n ({value} new cases/day)"), value, fill = name, text = glue("The number of available {tolower(name)}\n in this healthcare system can manage\n a maximum of {value} daily cases of COVID-19"))) +
        labs(x = '', 
             y = 'Maximum Daily Number of Cases') + 
        color_scale +
        theme_classic() +
        theme(legend.position = 'none',
              axis.text.x = element_text(angle = 25))
      p
    } else {
    
    p <- ggplot(plot_data, aes(glue("{name}\n ({scales::comma(value)} new cases/day)"), value, fill = name,
      text = glue("The number of available {tolower(name)}\n in this healthcare system can manage\n a maximum of {scales::comma(value)} daily new cases of COVID-19"))) +
      geom_col(show.legend = FALSE, col = 'black') +
      labs(x = '', 
            y = 'Maximum Daily Number of Cases') + 
      color_scale +
      scale_y_continuous(labels = scales::comma_format()) +
      theme_classic() +
      theme(legend.position = 'none',
            axis.text.x = element_text(angle = 25))
    p
    }
    
    ggplotly(p, tooltip = 'text') %>% 
      config(displayModeBar = FALSE) %>% 
      layout(xaxis = list(fixedrange = TRUE)) %>% 
      layout(yaxis = list(fixedrange = TRUE))
    
  })
  
  # Interpretation Box ----
  acute_data <- reactive(c(input$n_acute, input$lou_acute, 
                           acuteBedRate(input$n_acute, input$lou_acute))
                         )
  
  output$acute_int <- renderText({
    input$tab_pop_cell_edit
    
    glue('Based on {format(acute_data()[[1]], big.mark = ",")} available acute care beds and an average length of stay of {acute_data()[[2]]} days, at maximum capacity the expected turnover rate is {format(acute_data()[[3]], big.mark = ",", digits = 0)} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring an acute care bed is {round(rateAcute(x[, "case_dist"], x[, "ac_adm"]), 1)} percent. Given this, your healthcare environment has the capacity to manage a maximum of {format(maxAcute(x[, "case_dist"], x[, "ac_adm"], 
                                 input$n_acute, input$lou_acute), big.mark = ",", digits = 0)} incident cases of COVID-19 per day.')
  }
    )
  
  crit_data <- reactive(c(input$n_crit, input$lou_crit, 
                           critBedRate(input$n_crit, input$lou_crit)
  ))
  
  output$crit_int <- renderText({
    input$tab_pop_cell_edit
    glue('Based on {format(crit_data()[[1]], big.mark = ",", digits = 0)} available critical care beds and an average length of stay of {crit_data()[[2]]} days, at maximum capacity the expected turnover rate is {format(crit_data()[[3]], big.mark = ",", digits = 0)} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring a critical care bed is {round(rateCrit(x[, "case_dist"], x[, "cc_adm"]), 1)} percent. Given this, your healthcare environment has the capacity to manage a maximum of {format(maxCrit(x[, "case_dist"], x[, "cc_adm"], 
                input$n_crit, input$lou_crit), big.mark = ",", digits = 0)} incident cases of COVID-19 per day.')
  }
  )
  
  mv_data <- reactive(c(input$n_vent, input$lou_vent, 
                        ventBedRate(input$n_vent, input$lou_vent),
                        input$per_vent
  ))
  
  output$mv_int <- renderText({
    input$tab_pop_cell_edit
    glue('Based on {format(mv_data()[[1]], big.mark = ",", digits = 0)} available mechanical ventilators with an average duration of use of {mv_data()[[2]]} days, at maximum capacity the expected turnover rate is {format(mv_data()[[3]], big.mark = ",", digits = 0)} ventilators per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring mechanical ventilation is {round(rateVent(x[, "case_dist"], x[, "cc_adm"], mv_data()[[4]]), 1)} percent. Given this, your healthcare environment has the capacity to manage a maximum of {format(maxVent(x[, "case_dist"], x[, "cc_adm"], 
                input$n_vent, input$lou_vent, input$per_vent), big.mark = ",", digits = 0)} incident cases of COVID-19 per day.')
  }
  )
  
  # Generate Reports ----
  output$report <- downloadHandler(
    filename = function() {glue("COVID-19_report_{Sys.Date()}.pdf")},
    
      content = function(file) {
      withProgress(message = "Generating report...",
                   detail = 'Hold tight, this may take a few moments.',
                   {
      incProgress(0.25)
      tempReport <- file.path(tempdir(), "report.Rmd")
      incProgress(0.25)
      file.copy("lang/eng/report_pdf.Rmd", tempReport, 
                overwrite = TRUE)
      incProgress(0.25)
      params <- list(
        widgets = reactiveValuesToList(input),
        table = x,
        outputs = list(
          acute = acute_data(), 
          ra = rateAcute(x[, "case_dist"], x[, "ac_adm"]),
          ma = maxAcute(x[, "case_dist"], x[, "ac_adm"], 
                   input$n_acute, input$lou_acute),
          crit = crit_data(), 
          rc = rateCrit(x[, "case_dist"], x[, "cc_adm"]),
          mc = maxCrit(x[, "case_dist"], x[, "cc_adm"], 
                  input$n_crit, input$lou_crit),
          mvd = mv_data(),
          rv = rateVent(x[, "case_dist"], x[, "cc_adm"], mv_data()[[4]]),
          mv = maxVent(x[, "case_dist"], x[, "cc_adm"], 
                  input$n_vent, input$lou_vent, input$per_vent)
                    )
        )
      incProgress(0.25)
      rmarkdown::render(
        tempReport,
        output_file = file,
        params = params,
        output_format = 'pdf_document',
        envir = new.env(parent = globalenv())
        )
      })
      
    }
  )
}
