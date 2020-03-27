#==============================================================================

# Instructions for Editing:
#
# We recommend opening the file in a full-featured text editor,
# such as atom or notepad++. These tools support code
# highlighting which makes editing easier.
# 
# Do NOT edit anything on the left side of the assignment arrow
# 
# When editing the server-side code, you will sometimes see words
# wrapped in curly brace, {}. You can move these around as needed
# But do not change the text inside the braces. These are used for
# string interpolation.

# Contacts: 
# Matt Warkentin <warkentin@lunenfeld.ca>
# Deepit Bhatia <deepitbhatia@gmail.com>

# Conrtibutor Code of Conduct
# https://github.com/mattwarkentin/CAIC-RT/blob/master/CODE_OF_CONDUCT.md

#==============================================================================

# User Interface ====

## Panel 1 ----

lang <- "Choose Language"

contribtue <- "How can I contribute?"

last_update <- "Last Updated"

about_tool <- "About This Tool"

p1_header <- "Expected Resource Utilization for COVID-19 Patients"

lou_acute_label <- "Mean days in acute care"
lou_acute_tooltip <- "Note: Acute care days are mutually exclusive of critical care and ventilator days."

lou_crit_label <- "Mean days in critical care"
lou_crit_tooltip <- "Note: Critical care days are mutually exclusive of acute care days. Total number of days spent in critical care are equal to the number of days spent in critical care with or without a ventilator."

lou_vent_label <- "Mean days on a mechanical ventilator"
lou_crit_tooltip <- "Note: Days spent on a mechanical ventilator are assumed to be spent in a critical care bed."

p1_footnote <- "Default values are based on data extracted from Zhou et al. (2020), Yang et al. (2020), and Wang et al. (2020), collected in China. See Help page for full citations."

## Panel 2 ----

p2_header <- "Resource Availability"

n_acute_label <- "Number of acute care beds for COVID-19 patients"
n_acute_tooltip <- "Note: This is the total number of acute care beds that are available for or are currently being used by COVID-19 patients."
calc_acute <- "Calculate Acute Care Beds"

n_crit_label <- "Number of critical care beds for COVID-19 patients"
n_crit_tooltip <- "Note: This is the total number of critical care beds that are available for or are currently being used by COVID-19 patients."
calc_crit <- "Calculate Critical Care Beds"

n_vent_label <- "Number of mechanical ventilators for COVID-19 patients"
n_vent_tooltip <- "Note: This is the total number of mechanical ventilators that are available for or are currently being used by COVID-19 patients."
calc_vent <- "Calculate Mechanical Ventilators"

per_vent_label <- "Percent of critical care patients requiring mechanical ventilation"
per_vent_tooltip <- "Note: This is the percentage of COVID-19 critical care patients requiring mechanical ventilation."

p2_footnote_1 <- "Default values are based on data extracted from Zhou et al. (2020) and Wang et al. (2020), collected in China. See Help page for full citations."
p2_footnote_2 <- "Default values are based on data extracted from Barrett et al. (2020), collected in Ontario. See Help page for full citations."

## Panel 3 ----

table_title <- "Age-stratified Case Distribution and Severity (click to toggle visibility)"

table_source <- "Source"
table_tip <- "TIP: Double-click a cell to begin editing. Use [TAB] to navigate through column items while editing. Press [CONTROL + ENTER] when done editing a column."

plot_title <- "Maximum daily number of incident COVID-19 cases manageable by healthcare system"
plot_desc <- "The values shown below are thresholds for the maximum daily number of incident COVID-19 cases that can occur without causing a resource deficit. In other words, if more cases occur than the values shown below, the amount of acute care beds, critical care beds, and/or mechanical ventilators would be insufficient to meet the healthcare system's needs."

color_label <- "Choose Colour Palette"

interpret_title <- "Interpreting the Results"
acute_res_title <- "Acute Care"
crit_res_title <- "Critical Care"
vent_res_title <- "Mechanical Ventilators"

report_title <- "PDF Report"
report_button <- "Generate Report"

## Help Page ----

help_tab <- "Help"

## More Info ----

see_article <- "See the article"
see_code <- "See the code"

# Server Side ====

## Language Modal ----

lang_title <- "How can I contribute?"
lang_content <- ""

## Welcome Modal ----

welcome_title <- "CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool"
welcome_content <- ""

## Feedback ----

n_crit_feedback <- "Warning: Number of critical care beds is less than the number of mechanical ventilators."

n_vent_feedback <- "Warning: Number of mechanical ventilators is greater than the number of critical care beds."

## Data Table ----

table_col1 <- "Age groups"
table_col2 <- "Case distribution (%)"
table_col3 <- "Acute care admission (%)"
table_col4 <- "Critical care admission (%)"

table_modal_txt <- "This column can only accept numeric inputs. Please check your numbers!"

table_modal_sum <- "The case distribution column must sum to 100%. Please check your numbers!"

table_modal_adm <- "Admission rates cannot be less than 0% or greater than 100%. Please check your numbers!"

## Plot ----

ylab <- "Maximum Daily Number of Cases"

xlab_acute <- "Acute Care Beds"
xlab_crit <- "Critical Care Beds"
xlab_vent <- "Mechanical Ventilators"

xlab_suffix <- "new cases/day"

plot_tooltip <- "The number of available {tolower(name)}\n in this healthcare system can manage\n a maximum of {value} daily cases of COVID-19"

## Interpretations ----

summary_acute <- 'Based on {format(n_acute(), big.mark = ",")} available acute care beds and an average length of stay of {lou_acute()} days, at maximum capacity the expected turnover rate is {format(acuteBedRateR(), big.mark = ",", digits = 0)} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring an acute care bed is {round(rateAcuteR(), 1)} percent. Given this, your healthcare environment has the capacity to manage a maximum of {format(maxAcuteR(), big.mark = ",", digits = 0)} incident cases of COVID-19 per day.'

summary_crit <- 'Based on {format(n_crit(), big.mark = ",", digits = 0)} available critical care beds and an average length of stay of {lou_crit()} days, at maximum capacity the expected turnover rate is {format(critBedRateR(), big.mark = ",", digits = 0)} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring a critical care bed is {round(rateCritR(), 1)} percent. Given this, your healthcare environment has the capacity to manage a maximum of {format(maxCritR(), big.mark = ",", digits = 0)} incident cases of COVID-19 per day.'

summary_vent <- 'Based on {format(n_vent(), big.mark = ",", digits = 0)} available mechanical ventilators with an average duration of use of {lou_vent()} days, at maximum capacity the expected turnover rate is {format(ventBedRateR(), big.mark = ",", digits = 0)} ventilators per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring mechanical ventilation is {round(rateVentR(), 1)} percent. Given this, your healthcare environment has the capacity to manage a maximum of {format(maxVentR(), big.mark = ",", digits = 0)} incident cases of COVID-19 per day.'

## Report ----

progress_1 <- "Generating report..."
prorgess_2 <- "Hold tight, this may take a few moments."
