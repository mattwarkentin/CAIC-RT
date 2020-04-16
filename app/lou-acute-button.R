
actionButton('calc_lou_acute', 
             'Calculate Length of Stay',
             icon = icon('bed'), 
             class = 'bg-dark-gray white f5 f5-l f7-m'),
hr(),


updateButton(session, 'calc_lou_acute', glue(' {calc_lou_label}'))

# Modal Length of Stay Calculations ----

lou_acute_only <- reactiveVal(10) 
lou_acute_extra <- reactiveVal(5)
lou_prop <- reactiveVal()

observeEvent(input$calc_lou_acute, {
  
  showModal(modalDialog(
    title = acute_lou_modal_title,
    easyClose = TRUE, size = 'm',
    footer = modalButton(close),
    numericInput('lou_acute_only', acute_modal_lou_acute, 
                 min = 0, value = lou_acute_only()),
    hr(),
    numericInput('lou_acute_extra', acute_modal_lou_extra,
                 min = 0, value = lou_acute_extra()),
    sliderInput('lou_prop', acute_modal_prop, min = 0, max = 100,
                value = 50, post = '%'),
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
