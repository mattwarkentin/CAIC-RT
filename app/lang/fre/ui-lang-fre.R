#==============================================================================
#
# Instructions for Editing:
#
# We recommend opening the file/script in a full-featured text editor,
# such as RStudio, atom, or notepad++. These tools support text
# highlighting and spell-check, which makes editing easier.
#
# Do NOT edit anything on the left-hand side of the assignment (<-) arrow
#
# When editing the text, you will sometimes see words wrapped in curly
# braces (e.g. {var}). You can move these around as needed, but do not
# change the text inside the braces. These are used for string interpolation.
#
# Example:
# apples <- There are {number} apples in the basket.
# apples <- The number of apples in the basket is {number}.
#
# Contacts:
# Matt Warkentin <warkentin@lunenfeld.ca>
# Deepit Bhatia <deepitbhatia@gmail.com>
#
# Contributor Code of Conduct
# https://github.com/mattwarkentin/CAIC-RT/blob/master/CODE_OF_CONDUCT.md
#
#==============================================================================

# User Interface ====

## Misc ----

submit <- "Apply Changes"

close <- "Close"

dev_by <- "Developed by"

## Navbar ----

home <- "Home"

help <- "Help"

tutorial <- "Tutorial"

more_info <- "More Info"

see_article <- "See the article"

see_code <- "See the code"

## Panel 1 ----

last_update <- "Last Updated"

lang <- "Choose Language"

about_tool <- "About This Tool"

contribute <- "How can I contribute?"

p1_header <- "Expected Resource Utilization for COVID-19 Patients"

lou_acute_label <- "Mean days in acute care"

lou_acute_tooltip <- "Note: Acute care days are mutually exclusive of critical care and ventilator days."

lou_crit_label <- "Mean days in critical care"

lou_crit_tooltip <- "Note: Critical care days are mutually exclusive of acute care days. Total number of days spent in critical care are equal to the number of days spent in critical care with or without a ventilator."

lou_vent_label <- "Mean days on a mechanical ventilator"

lou_vent_tooltip <- "Note: Days spent on a mechanical ventilator are assumed to be spent in a critical care bed."

p1_footnote <- "Default values are based on data extracted from Zhou et al. (2020), Yang et al. (2020), and Wang et al. (2020), collected in China. See Help page for full citations."

## Panel 2 ----

p2_header <- "Resource Availability"

n_acute_label <- "Number of acute care beds for COVID-19 patients"

n_acute_tooltip <- "Note: This is the total number of acute care beds that are available for or are currently being used by COVID-19 patients."

calc_acute <- "Calculate Acute Care Beds"

acute_modal_title <- "Calculate the number of acute care beds available for COVID-19 cases"

acute_modal_n_acute <- "Total number of acute care beds"

acute_modal_per_acute <- "Percent of acute care beds available for or currently being used by COVID-19 cases"

acute_modal_surge <- "Acute care bed surge capacity for COVID-19 cases (number of beds)"

n_crit_label <- "Number of critical care beds for COVID-19 patients"

n_crit_tooltip <- "Note: This is the total number of critical care beds that are available for or are currently being used by COVID-19 patients."

calc_crit <- "Calculate Critical Care Beds"

crit_modal_title <- "Calculate the number of critical care beds available for COVID-19 cases"

crit_modal_n_crit <- "Total number of critical care beds"

crit_modal_per_crit <- "Percent of critical care beds available for or currently being used by COVID-19 cases"

crit_modal_surge <- "Critical care bed surge capacity for COVID-19 cases (number of beds)"

n_vent_label <- "Number of mechanical ventilators for COVID-19 patients"

n_vent_tooltip <- "Note: This is the total number of mechanical ventilators that are available for or are currently being used by COVID-19 patients."

calc_vent <- "Calculate Mechanical Ventilators"

vent_modal_title <- "Calculate the number of mechanical ventilators available for COVID-19 cases"

vent_modal_n_vent <- "Total number of mechanical ventilators"

vent_modal_per_vent <- "Percent of mechanical ventilators available for or currently being used by COVID-19 cases"

vent_modal_surge <- "Mechanical ventilator surge capacity for COVID-19 cases (number of ventilators)"

per_vent_label <- "Percent of critical care patients requiring mechanical ventilation"

per_vent_tooltip <- "Note: This is the percentage of COVID-19 critical care patients requiring mechanical ventilation."

p2_footnote_1 <- "Default percent of critical care patients requiring mechanical ventilation are based on data extracted from Zhou et al. (2020) and Wang et al. (2020), collected in China. See Help page for full citations."

p2_footnote_2 <- "Default number of acute care beds, critical care beds, and mechanical ventilators are based data extracted from Barrett et al. (2020), collected in Ontario. See Help page for full citations."

## Panel 3 ----

table_title1 <- "Age-stratified Case Distribution and Severity"

table_title2 <- "click to toggle visibility"

table_source <- "Source"

table_tip <- "TIP: Double-click a cell to begin editing. Use [TAB] to navigate through column items while editing. Press [CONTROL + ENTER] when done editing a column."

plot_title <- "Maximum daily number of incident COVID-19 cases manageable by healthcare system"

plot_desc <- "The values shown below are thresholds for the maximum daily number of incident COVID-19 cases that can occur without causing a resource deficit. In other words, if more cases occur than the values shown below, the amount of acute care beds, critical care beds, and/or mechanical ventilators would be insufficient to meet the healthcare system's needs."

color_label <- "Choose Colour Palette"

interpret_title <- "Interpreting the Results"

acute_res_title <- "Acute Care"

crit_res_title <- "Critical Care"

vent_res_title <- "Mechanical Ventilators"

report_button <- "Generate PDF Report"

## Help Page ----

help_welcome <- "Welcome to the Help page for the COVID-19 Acute and Intensive Care Resource Tool (CAIC-RT). This page provides contact information and important resources that were used when developing this tool."

contact_title <- 'Contact'

# {person} is the name of the persons to contact
contact_info <- "If you would like to contact the developers of this tool with any comments, questions, or feedback, please send an email to {person}."

thanks <- 'Thank you for using our tool! We look forward to hearing from you!'

important_resources <- "Important Resources"

resource_sentence <- "Below are some key resources that were used when developing this tool."

# Server Side ====

## Language Modal ----

lang_title <- "How can I contribute?"

# {CoC} is a named-link to the Contributor Code of Conduct
cont_details <- "We are honoured that you are interested in contributing to this project. Right now, we are very interested in collaborating to translate this tool into as many languages as possible. First, please read the {CoC}."

how_to_cont <- "In order to contribute, please make sure you meet the following criteria:"

cont1 <- "You are multi-lingual, where one of the languages is English"
cont2 <- "You have technical training in one of the following areas: medicine, epidemiology, medical sciences, public health, or a related field"

# {deepit} and {matt} are links to our names/emails
thats_it <- "That's it! If you meet both of the above criteria, we would be happy to have you contribute to this project. If you are still interested in contributing to this translation effort, please contact {deepit} or {matt} for instructions on how to contribute."

recognition <- "Lastly, if you contribute to this project we would be happy to feature your name within the tool in order to give you the proper recognition."

# {CoC} is a named-link to the Contributor Code of Conduct
code <- "Please note that the ‘CAIC-RT’ project is released with a {CoC}. By contributing to this project, you agree to abide by its terms."

## Welcome Modal ----

welcome_title <- "CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool"

authors <- "Authors"

desc_title <- "Description"

desc <- "An online tool capable of estimating the maximum daily number of incident COVID-19 cases that a healthcare system could manage based on age-based case distribution and severity, and the number of available acute and critical care resources."

how_to <- "How to use this tool:"

# {CDC} is a link to the CDC resource
item1 <- "Review the default age-stratified case distribution and severity data, which are based on US data from the {CDC}."

item1_opt <- "Optional: You may enter your own information into the table based on local clinical data and experience."

# We recommend being consistent with p1_header and p2_header
item2 <- "Tune the Expected Resource Utilization and Resource Availability inputs to your own healthcare environment."

item3 <- "Inspect the results in the bar graph, which displays the maximum daily number of incident COVID-19 cases that a healthcare system could manage based on resource availability."

item4 <- "Visualize in real-time how the results change when modifying the input parameters."

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

# {resource} is either acute care beds, critical care beds, or mechanical ventilators
# {value} is the maximum number of cases for any {resource}
plot_tooltip <- "The number of available {resource} in this healthcare system can manage a maximum of {value} daily cases of COVID-19"

## Interpretations ----

# n_* is the number of each resource available
# lou_* is the number of days using a resource
# *BedRate is the resource turnover rate
# rate* is the rate of COVID-19 patients requiring a resource
# max* is the maximum number of manageable COVID-19 cases

summary_acute <- 'Based on {n_acute} available acute care beds and an average length of stay of {lou_acute} days, at maximum capacity the expected turnover rate is {acuteBedRate} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring an acute care bed is {rateAcute} percent. Given this, your healthcare environment has the capacity to manage a maximum of {maxAcute} incident cases of COVID-19 per day.'

summary_crit <- 'Based on {n_crit} available critical care beds and an average length of stay of {lou_crit} days, at maximum capacity the expected turnover rate is {critBedRate} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring a critical care bed is {rateCrit} percent. Given this, your healthcare environment has the capacity to manage a maximum of {maxCrit} incident cases of COVID-19 per day.'

summary_vent <- 'Based on {n_vent} available ventical care beds and an average length of stay of {lou_vent} days, at maximum capacity the expected turnover rate is {ventBedRate} beds per day. Based on the age-stratified case distribution, the proportion of COVID-19 cases requiring a ventical care bed is {rateVent} percent. Given this, your healthcare environment has the capacity to manage a maximum of {maxVent} incident cases of COVID-19 per day.'

## Report ----

progress_1 <- "Generating report..."

progress_2 <- "Hold tight, this may take a few moments."

report_type <- "General Report"

report_date <- "Report Generated"

tool_info <- "Tool Information"

custom_inputs <- "Customizable Inputs"

# This should be partially consistent with p2_header
caption2 <- "Resource Availability for COVID-19 Patients."

col_name1 <- "Input Parameter"

col_name2 <- "Value"
