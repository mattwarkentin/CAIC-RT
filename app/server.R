server <- function(input, output, session) {
  # Lanuage Rendering ----

  load_lang <- function(lang) {
    source(glue('lang/{lang}/ui-lang-{lang}.R'))
  }
  
  observeEvent(input$lang, {
    req(input$lang)
    choose_lang <- input$lang
    
    switch(choose_lang,
      'eng' = load_lang('eng'),
      'spa' = load_lang('spa'),
      'fre' = load_lang('fre')
    )
    
    output$home <- renderUI(span(icon('toolbox'), home))
    
    ## Footer ----
    
    track_twitter <- function(name, handle, label, value = 1) {
      a(
        glue('{name}'),
        href = glue('https://www.twitter.com/{handle}'),
        target = '_blank',
        #onclick = glue('ga("send", "event", "click", "link", "{label}", {value})')
      )
    }
    
    tran_foot <- function(name) {
      if (is.na(name)) {
        ""
      } else {
        paste0(tran_by, 
        a(
          glue(' {name}.'),
          href = glue('mailto:', '{email}')
        ))
      }
    }
    
    footer <- 
      HTML(
        glue(" ",
             "{track_twitter('Vasily Giannakeas', 'vasilepi', 'twitter_vg', 1)}, ",
             "{track_twitter('Deepit Bhatia', 'BreslowDay', 'twitter_db', 1)}, ",
             "{track_twitter('Matthew T. Warkentin', 'mattwrkntn', 'twitter_mtw', 1)}, ",
             "{track_twitter('Isaac I. Bogoch', 'BogochIsaac', 'twitter_iib', 1)}, ",
             "and ",
             "{track_twitter('Nathan M. Stall', 'NathanStall', 'twitter_nms', 1)}",
             " (Toronto, Canada). {tran_foot(tb)}<p/></footer>"
        ))
    
    output$dev_by <- renderUI(HTML(glue('<hr /><footer><p>', dev_by, footer)))
    
    ## Panel 1 ----
    output$last_update <- renderUI(HTML(glue("{strong(last_update)}: {Sys.Date()}")))
    updateSelectInput(session, 'lang', lang)
    updateButton(session, 'about_tool', glue(' {about_tool}'))
    updateButton(session, 'contribute', glue(' {contribute}'))
    output$p1_header <- renderUI(h4(p1_header,
                                    class = 'f3 f4-m f3-l'))
    output$lou_acute_label <- renderUI(p(lou_acute_label, class = 'f5-m f4-l f4'))
    output$lou_crit_label <- renderUI(p(lou_crit_label, class = 'f5-m f4-l f4'))
    output$lou_vent_label <- renderUI(p(lou_vent_label, class = 'f5-m f4-l f4'))
    
    output$p1_footnote <- renderUI(p(p1_footnote, class = 'f5 f5-l f6-m'))
    
    
    addTooltip(session, "lou_acute", lou_acute_tooltip, 
               placement = "bottom", trigger = 'hover',
               options = list(container = "body"))
    
    addTooltip(session, "lou_crit", lou_crit_tooltip, 
               placement = "bottom", trigger = 'hover',
               options = list(container = "body"))
    
    addTooltip(session, "lou_vent", lou_vent_tooltip, 
               placement = "bottom", trigger = 'hover',
               options = list(container = "body"))
    
    updateButton(session, 'calc_lou_acute', glue(' {calc_lou_label}'))
    
    ## Panel 2 ----
    
    output$p2_header <- renderUI(h4(p2_header,
                                    class = 'f3 f4-m f3-l'))
    
    output$n_acute_label <- renderUI(p(n_acute_label, class = 'f5-m f4-l f4'))
    updateButton(session, 'acute', glue(' {calc_acute}'))
    
    output$n_crit_label <- renderUI(p(n_crit_label, class = 'f5-m f4-l f4'))
    updateButton(session, 'critical', glue(' {calc_crit}'))
    
    output$n_vent_label <- renderUI(p(n_vent_label, class = 'f5-m f4-l f4'))
    updateButton(session, 'mvent', glue(' {calc_vent}'))
    
    output$per_vent_label <- renderUI(p(per_vent_label, class = 'f5-m f4-l f4'))
    
    output$p2_footnote_1 <- renderUI(p(p2_footnote_1, class = 'f5 f5-l f6-m'))
    output$p2_footnote_2 <- renderUI(p(p2_footnote_2, class = 'f5 f5-l f6-m'))
    
    addTooltip(session, "n_acute", n_acute_tooltip, 
               placement = "bottom", trigger = 'hover',
               options = list(container = "body"))
    addTooltip(session, "n_crit", n_crit_tooltip, 
              placement = "bottom", trigger = 'hover',
              options = list(container = "body"))
    addTooltip(session, "n_vent", n_vent_tooltip, 
              placement = "bottom", trigger = 'hover',
              options = list(container = "body"))
    addTooltip(session, "per_vent", per_vent_tooltip, 
              placement = "bottom", trigger = 'hover',
              options = list(container = "body"))
    
    ## Panel 3 ----
    
    output$table_title <- renderUI(p(HTML(glue("{icon('sort')} {table_title1} ({table_title2})")), class = 'f3 f4-m f3-l'))
    output$table_tip <- renderUI(p(table_tip, class = 'f5'))
    output$table_source <- renderUI(p(glue('{table_source}: CDC COVID-19 Response Team. Severe Outcomes Among Patients with Coronavirus Disease 2019 (COVID-19) — United States, February 12–March 16, 2020. MMWR Morb Mortal Wkly Rep. 2020.'), class='f5'))
    
    output$input_data <- renderUI(
      fileInput('data', 
                label = span(p(input_label, class = 'f4'), 
                             p(input_text, class = 'f5')),
                buttonLabel = input_btn,
                placeholder = input_placehold,
                accept = c('.csv', '.xlsx')))
    updateActionButton(session, 'reset', label = reset)
    
    output$plot_title <- renderUI(h4(plot_title, class = 'f3 f4-m f3-l'))
    output$plot_desc <- renderUI(p(plot_desc, class = 'navy f4 f4-l f5-m'))
    
    updateSelectInput(session, 'colors', color_label)
    
    output$interpret_title <- renderUI(h4(interpret_title,
                                          class = 'f3 f4-m f3-l'))
    output$acute_res_title <- renderUI(p(acute_res_title, 
                                         class = 'f3 f4-m f3-l'))
    output$crit_res_title <- renderUI(p(crit_res_title,
                                        class = 'f3 f4-m f3-l'))
    output$vent_res_title <- renderUI(p(vent_res_title, 
                                        class = 'f3 f4-m f3-l'))

    output$report <- renderUI({
      downloadButton('report_btn', report_button, 
                     class = 'btn-primary f4 f4-l f5-m')
    })
    
    ## Help Page ----
    
    output$help <- renderUI(span(icon('question-circle'), help))
    
    output$help_text <- renderUI(includeHTML(glue('lang/{input$lang}/help-text.html')))
    
    ## Whats New? ----
    
    output$whats_new <- renderUI(span(icon('history'), whats_new))
    
    output$whats_new_text <- renderUI(includeHTML(glue('lang/NEWS.html')))
    
    ## More Info ----
    
    output$tutorial <- renderUI(span(icon('youtube'), tutorial))
    
    output$more_info <- renderUI(more_info)
    
    output$see_article <- renderUI(span(icon('file-medical-alt'), 
                                          see_article))
    
    output$see_code <- renderUI(span(icon('github'), see_code))
    
  })
  
  # Language Contribution ----
  
  observeEvent(input$contribute, {
    showModal(modalDialog(title = h4(lang_title), 
                          size = 'm', 
                          easyClose = TRUE, footer = modalButton('Close'),
                          includeHTML(glue('lang/{input$lang}/contribute.html'))))
  })
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
      includeHTML("lang/eng/intro-text.html"),
      easyClose = TRUE, size = 'm', 
      footer = modalButton(close),
      title = "CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool")
    )
  }
  )
  
  observeEvent(input$about_tool, {
    showModal(modalDialog(
      includeHTML(glue("lang/{input$lang}/intro-text.html")),
      easyClose = TRUE, size = 'm', 
      footer = modalButton(close),
      title = "CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool")
    )
  })
  
  
  # Bookmark Button ----
  
  observeEvent({
    input$lang
    n_acute(); lou_acute()
    n_crit(); lou_crit()
    n_vent(); lou_vent()
    per_vent()
    input$colors
  }, {
    output$bookmark <- renderUI(bookmarkButton(
      class = 'btn-success mb4 f4 f4-l f5-m', 
      label = HTML(bookmark)))
    
    onBookmarked(function(url) {
      showModal(urlModal(url, 
                         title = bookmark_title, 
                         subtitle = bookmark_sub))
    })
    
  }, ignoreInit = TRUE)
  
  setBookmarkExclude(
    names = c('about_tool', 'interpretations',
              'mvent', 'global', 'plotly_afterplot-A',
              '.clientValue-default-plotlyCrosstalkOpts',
              'contribute', 'critical', 'acute',
              'tab_pop_cell_clicked', 'plotly_relayout-A', 'data',
              'plotly_click-A', 'plotly_doubleclick-A',
              'plotly_hover-A',
              'reset', 'tab_pop_rows_current', 
              'tab_pop_rows_all', 'tab_pop_state',
              'tab_pop_search', 'tab_pop_cell_edit',
              'calc_lou_acute', 'submit_lou_ac',
              'submit_mv', 'submit_cc', 'submit_ac'
              ),
    session = session
  )
  
  # Modal Length of Stay Calculations ----
  lou_acute_only <- reactiveVal(10) 
  lou_acute_extra <- reactiveVal(5)
  
  observeEvent(input$calc_lou_acute, {
    
    showModal(modalDialog(
      title = acute_lou_modal_title,
      easyClose = TRUE, size = 'm',
      footer = modalButton(close),
      numericInput('lou_acute_only', acute_modal_lou_acute, 
                   min = 0, value = lou_acute_only()),
      numericInput('lou_acute_extra', acute_modal_lou_extra,
                   min = 0, value = lou_acute_extra()),
      actionButton('submit_lou_ac', submit, 
                   class = 'btn-success')
    ))
  })
  
  observeEvent(input$submit_lou_ac, {
    lou_acute_only(input$lou_acute_only)
    lou_acute_extra(input$lou_acute_extra)
    updateNumericInput(session, 'lou_acute', 
                       value = round(lou_acute_only() + 
                         (lou_acute_extra() * rateAcuteR() / 100)))
    removeModal()
  })
  
  # Modal Resource Calculations ----
  
  tot_ac_bed <- reactiveVal(33511)
  tot_ac_av <- reactiveVal(25)
  tot_ac_sur <- reactiveVal(0)
  tot_cc_bed <- reactiveVal(2053)
  tot_cc_av <- reactiveVal(25)
  tot_cc_sur <- reactiveVal(0)
  tot_mv <- reactiveVal(1311)
  tot_mv_av <- reactiveVal(25)
  tot_mv_sur <- reactiveVal(0)
  
  observeEvent(input$acute, {
    
    showModal(modalDialog(
      title = acute_modal_title,
      easyClose = TRUE, size = 'm',
      footer = modalButton(close),
      numericInput('tot_ac_bed', acute_modal_n_acute, 
                   min = 0, value = tot_ac_bed()),
      sliderInput('tot_ac_av', acute_modal_per_acute,
                  min = 0, max = 100, value = tot_ac_av(), 
                  step = 1,
                  post = '%'),
      numericInput('tot_ac_sur', acute_modal_surge,
                   min = 0, max = 100, value = tot_ac_sur()),
      actionButton('submit_ac', submit, 
                   class = 'btn-success')
    ))
  })
  observeEvent(input$submit_ac, {
    tot_ac_bed(input$tot_ac_bed)
    tot_ac_av(input$tot_ac_av)
    tot_ac_sur(input$tot_ac_sur)
    updateNumericInput(session, 'n_acute', 
                       value = floor((tot_ac_bed() * 
                                  (tot_ac_av() / 100)) + 
                                  (tot_ac_sur()))
                       )
    removeModal()
  })
  
  observeEvent(input$critical, {
    
    showModal(modalDialog(
      title = crit_modal_title,
      easyClose = TRUE, size = 'm',
      footer = modalButton(close),
      numericInput('tot_cc_bed', crit_modal_n_crit, 
                   min = 0, value = tot_cc_bed()),
      sliderInput('tot_cc_av', crit_modal_per_crit,
                  min = 0, max = 100, value = tot_cc_av(), step = 1,
                  post = '%'),
      numericInput('tot_cc_sur', crit_modal_surge,
                   min = 0, max = 100, value = tot_cc_sur()),
      actionButton('submit_cc', submit, 
                   class = 'btn-success')
    ))
  })
  observeEvent(input$submit_cc, {
    tot_cc_bed(input$tot_cc_bed)
    tot_cc_av(input$tot_cc_av)
    tot_cc_sur(input$tot_cc_sur)
    updateNumericInput(session, 'n_crit', 
                       value = floor((tot_cc_bed() * 
                                        (tot_cc_av() / 100)) + 
                                       (tot_cc_sur()))
    )
    removeModal()
  })
  
  observeEvent(input$mvent, {
    
    showModal(modalDialog(
      title = vent_modal_title,
      easyClose = TRUE, size = 'm',
      footer = modalButton(close),
      numericInput('tot_mv', vent_modal_n_vent, 
                   min = 0, value = tot_mv()),
      sliderInput('tot_mv_av', vent_modal_per_vent,
                  min = 0, max = 100, value = tot_mv_av(), step = 1,
                  post = '%'),
      numericInput('tot_mv_sur', vent_modal_surge,
                   min = 0, max = 100, value = tot_mv_sur()),
      actionButton('submit_mv', submit, 
                   class = 'btn-success')
    ))
  })
  observeEvent(input$submit_mv, {
    tot_mv(input$tot_mv)
    tot_mv_av(input$tot_mv_av)
    tot_mv_sur(input$tot_mv_sur)
    updateNumericInput(session, 'n_vent', 
                       value = floor((tot_mv() * 
                                        (tot_mv_av() / 100)) + 
                                       (tot_mv_sur()))
    )
    removeModal()
  })
  
  # Observe Number of CC Beds ----
  observeEvent({
    input$n_vent
    input$n_crit
  }, {
    feedbackWarning(
      inputId = 'n_crit',
      condition = input$n_crit < input$n_vent,
      text = n_crit_feedback
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
      text = n_vent_feedback
    )
  })
  
  # Data Table ----
  
  x <- reactiveVal(default_table)
  
  observe({
    file <- input$data
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    
    switch (ext,
      csv = x(read_csv(file$datapath, col_names = c('age_dist', 
                                                    'case_dist', 
                                                    'ac_adm', 
                                                    'cc_adm'), skip = 1)),
      xlsx = x(read_xlsx(file$datapath, col_names = c('age_dist', 
                                                     'case_dist', 
                                                     'ac_adm', 
                                                     'cc_adm'), skip = 1))
    )
  })
  
  observeEvent(input$reset, {
    x(default_table)
  })
  
  output$tab_pop <- DT::renderDT(
      DT::datatable(
        x(),
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
        colnames = c(table_col1, 
                     table_col2, 
                     table_col3, 
                     table_col4)
      ) %>% 
        formatString(columns = c(2,3,4), suffix = '%')
    )
  
  proxy <- dataTableProxy('tab_pop')
  
  observeEvent(input$tab_pop_cell_edit, {
    new <- editData(x(), input$tab_pop_cell_edit, 'proxy', rownames = FALSE)
    x(new)
    
    if (any(is.na(x()[, 2:4]), na.rm = TRUE)) {
      shinyalert('Uh oh!', table_modal_txt, type = 'error')
    } 
    
    if (!dplyr::near(sum(x()[, 'case_dist'], na.rm = TRUE), 100, tol = 0.1)) {
      shinyalert('Uh oh!', table_modal_sum, type = 'error')
    }
    
    if (any(x()[, 'ac_adm']>100 | x()[, 'ac_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', table_modal_adm, type = 'error')
    }
    
    if (any(x()[, 'cc_adm']>100 | x()[, 'cc_adm']<0, na.rm = TRUE)) {
      shinyalert('Uh oh!', table_modal_adm, type = 'error')
    }
    
  })
  
  # Output Results ----
  
  # Acute Care Data
  n_acute <- reactive(input$n_acute)
  lou_acute <- reactive(input$lou_acute)
  rateAcuteR <- reactive({rateAcute(x()[, "case_dist"], x()[, "ac_adm"])})
  acuteBedRateR <- reactive({acuteBedRate(input$n_acute, input$lou_acute)})
  maxAcuteR <- reactive({maxAcute(x()[, 'case_dist'], x()[, 'ac_adm'], 
                                input$n_acute, input$lou_acute)})
  
  # Critical Care Data
  n_crit <- reactive(input$n_crit)
  lou_crit <- reactive(input$lou_crit)
  rateCritR <- reactive({rateCrit(x()[, "case_dist"], x()[, "cc_adm"])})
  critBedRateR <- reactive({critBedRate(input$n_crit, input$lou_crit)})
  maxCritR <- reactive({maxCrit(x()[, 'case_dist'], x()[, 'cc_adm'], 
                          input$n_crit, input$lou_crit)})
  
  # Mechanical Ventilator Data
  n_vent <- reactive(input$n_vent)
  lou_vent <- reactive(input$lou_vent)
  per_vent <- reactive(input$per_vent)
  rateVentR <- reactive({rateVent(x()[, "case_dist"], x()[, "cc_adm"], 
                       input$per_vent)})
  ventBedRateR <- reactive({ventBedRate(input$n_vent, input$lou_vent)})
  maxVentR <- reactive({maxVent(x()[, 'case_dist'], x()[, 'cc_adm'], 
                           input$n_vent, input$lou_vent, input$per_vent)})
  
  # Plot Data
  
  format_tooltip <- function(resource, value, text) {
    resource <- tolower(resource)
    value <- format(floor(value), big.mark = ",")
    
    glue(text)
  }
  
  plot_data <- reactive({
    input$tab_pop_cell_edit
    input$lang
    
    tribble(
      ~resource, ~value,
      xlab_acute, maxAcuteR(),
      xlab_crit, maxCritR(),
      xlab_vent, maxVentR()
    ) %>% 
      mutate(
        tooltip = format_tooltip(resource, value, plot_tooltip),
        resource = factor(resource,
                          levels = c(xlab_acute, xlab_crit,
                                          xlab_vent)))
    
    }
  )
  
  y_lab <- reactive({input$lang; ylab})
  
  # Plotly Results ----
  
  plot <- reactive({
    
    color_scale <- switch(input$colors,
                          YlOrRd = scale_fill_manual(values = c('#FFEC19', '#FF9800', '#F6412D')),
                          Viridis = scale_fill_viridis_d(),
                          Grayscale = scale_fill_grey(),
                          Pastel = scale_fill_brewer(palette = 'Set2'),
                          Brewer = scale_fill_brewer(),
                          Default = scale_fill_hue()
    )
    
    if (all(is.na(maxAcuteR()), is.na(maxCritR()), is.na(maxVentR()))) {
      p <- ggplot(plot_data(), aes(resource, value, fill = resource, text = str_wrap(tooltip, width = 40))) +
        labs(x = '', 
             y = y_lab()) + 
        color_scale +
        theme_classic() +
        theme(legend.position = 'none',
              axis.text.x = element_text(angle = 25))
      p
    } else {
    
      p <- 
        plot_data() %>% 
        ggplot(aes(resource, value, fill = resource,
                                   text = str_wrap(tooltip, width = 40))) +
        geom_col(show.legend = FALSE, col = 'black') +
        geom_hline(aes(yintercept = min(value, na.rm = TRUE)), 
                   lty = 3) +
        labs(x = '', 
             y = y_lab()) + 
        color_scale +
        scale_x_discrete(labels = with(plot_data(), glue("{resource}\n ({str_trim(format(floor(value), big.mark = ','))} {xlab_suffix})"))) +
        scale_y_continuous(labels = scales::comma_format()) +
        theme_classic() +
        theme(legend.position = 'none', 
              axis.text.x = element_text(angle = 25))
      p
    }
  })
  
  output$plot <- renderPlotly({

  ggplotly(plot(), tooltip = 'text') %>% 
    config(displayModeBar = FALSE) %>% 
    layout(xaxis = list(fixedrange = TRUE)) %>% 
    layout(yaxis = list(fixedrange = TRUE))
    
  })
  
  # Interpretation Box ----
  
  sanitize_acute <- function(n_acute, lou_acute,
    acuteBedRate, rateAcute, maxAcute) {
    
    n_acute = format(n_acute, big.mark = ",")
    acuteBedRate = format(floor(acuteBedRate), big.mark = ",")
    rateAcute = round(rateAcute, 1)
    maxAcute = format(floor(maxAcute), big.mark = ",")
    
    glue(summary_acute)
  }
  
  acute_int <- reactive({
    input$lang
    sanitize_acute(n_acute(), lou_acute(), acuteBedRateR(),
                   rateAcuteR(), maxAcuteR())})
  
  output$acute_int <- renderUI({
    input$tab_pop_cell_edit
    
    p(acute_int(), class = 'f3 f4-m f3-l')
  }
  )
  
  sanitize_crit <- function(n_crit, lou_crit,
                             critBedRate, rateCrit, maxCrit) {
    
    n_crit = format(n_crit, big.mark = ",")
    critBedRate = format(floor(critBedRate), big.mark = ",")
    rateCrit = round(rateCrit, 1)
    maxCrit = format(floor(maxCrit), big.mark = ",")
    
    glue(summary_crit)
  }
  
  crit_int <- reactive({
    input$lang
    sanitize_crit(n_crit(), lou_crit(), critBedRateR(),
                  rateCritR(), maxCritR())}
  )
  
  output$crit_int <- renderUI({
    input$tab_pop_cell_edit
    
    p(crit_int(), class = 'f3 f4-m f3-l')
  }
  )
  
  sanitize_vent <- function(n_vent, lou_vent,
                            ventBedRate, rateVent, maxVent) {
    
    n_vent = format(n_vent, big.mark = ",")
    ventBedRate = format(floor(ventBedRate), big.mark = ",")
    rateVent = round(rateVent, 1)
    maxVent = format(floor(maxVent), big.mark = ",")
    
    glue(summary_vent)
  }
  
  vent_int <- reactive({
    input$lang
    sanitize_vent(n_vent(), lou_vent(), ventBedRateR(),
                  rateVentR(), maxVentR())}
  )
  
  output$mv_int <- renderUI({
    input$tab_pop_cell_edit

    p(vent_int(), class = 'f3 f4-m f3-l')
  }
  )
  
  # Generate Reports ----
  output$report_btn <- downloadHandler(
    filename = function() {glue("CAIC-RT_report_{Sys.Date()}.pdf")},
    
    content = function(file) {

      withProgress(message = progress_1,
                   detail = progress_2,
                   {
                     tempReport <- file.path(tempdir(), "report.Rmd")
                     incProgress(0.25)
                     file.copy("lang/eng/report-pdf.Rmd", tempReport, 
                               overwrite = TRUE)
                     incProgress(0.25)
                     params <- list(
                       widgets = reactiveValuesToList(input),
                       table = x(),
                       outputs = list(
                         acute = list(
                           n_acute = n_acute(),
                           lou_acute = lou_acute(),
                           rateAcute = rateAcuteR(),
                           acuteBedRate = acuteBedRateR(),
                           maxAcute = maxAcuteR()
                         ),
                         crit = list(
                           n_crit = n_crit(),
                           lou_crit = lou_crit(),
                           rateCrit = rateCritR(),
                           critBedRate = critBedRateR(),
                           maxCrit = maxCritR()
                         ), 
                         mvent = list(
                           n_vent = n_vent(),
                           lou_vent = lou_vent(),
                           per_vent = per_vent(),
                           rateVent = rateVentR(),
                           ventBedRate = ventBedRateR(),
                           maxVent = maxVentR()
                         )
                       ), 
                       plot = plot(),
                       acute_int = acute_int(),
                       crit_int = crit_int(),
                       vent_int = vent_int(),
                       report_type = report_type,
                       report_date = report_date,
                       authors = authors,
                       tool_info = tool_info,
                       desc = desc,
                       desc_title = desc_title,
                       custom_inputs = custom_inputs,
                       lou_acute_label = lou_acute_label,
                       lou_crit_label = lou_crit_label,
                       lou_vent_label = lou_vent_label,
                       caption1 = p1_header,
                       caption2 = caption2,
                       caption3 = table_title1,
                       col_name1 = col_name1,
                       col_name2 = col_name2,
                       n_acute_label = n_acute_label,
                       n_crit_label = n_crit_label,
                       n_vent_label = n_vent_label,
                       per_vent_label = per_vent_label,
                       table_col1 = table_col1,
                       table_col2 = table_col2,
                       table_col3 = table_col3,
                       table_col4 = table_col4,
                       plot_title = plot_title,
                       interpret_title = interpret_title,
                       acute_res_title = acute_res_title,
                       crit_res_title = crit_res_title,
                       vent_res_title = vent_res_title
                       )
                     incProgress(0.25)
                     rmarkdown::render(
                       tempReport,
                       output_file = file,
                       params = params,
                       output_format = 'pdf_document',
                       envir = new.env(parent = globalenv())
                     )
                     incProgress(0.25)
                   })
      
    }
  )
}
