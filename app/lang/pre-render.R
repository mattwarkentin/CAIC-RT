#=============================================================================
#
# Use this script to pre-render the HTML fragments for each contributed
# language. This will save time on the load times.
#
#=============================================================================

library(glue)
library(purrr)
library(rmarkdown)

# Based on ISO 639-2/B (https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)
langs <- c('English' = 'eng', 'Spanish' = 'spa')

# Help Text ----
walk(langs, ~{source(glue('app/lang/{.}/ui-lang-{.}.R')); render(
  input = 'app/lang/eng/help-text.Rmd',
  output_file = glue('../{.}/help-text.html'),
  output_format = 'html_fragment',
  params = list(
    help_welcome = help_welcome,
    contact_title = contact_title,
    contact_info = contact_info,
    thanks = thanks, 
    important_resources = important_resources,
    resource_sentence = resource_sentence
                    ))})

# Contribute ----
walk(langs, ~{source(glue('app/lang/{.}/ui-lang-{.}.R')); render(
  input = 'app/lang/eng/contribute.Rmd',
  output_file = glue('../{.}/contribute.html'),
  output_format = 'html_fragment',
  params = list(
    cont_details = cont_details,
    how_to_cont = how_to_cont,
    cont1 = cont1,
    cont2 = cont2,
    thats_it = thats_it,
    recognition = recognition,
    code = code
  ))})

# Intro Text ----
walk(langs, ~{source(glue('app/lang/{.}/ui-lang-{.}.R')); render(
  input = 'app/lang/eng/intro-text.Rmd',
  output_file = glue('../{.}/intro-text.html'),
  output_format = 'html_fragment',
  params = list(
    authors = authors,
    desc = desc,
    desc_title = desc_title,
    how_to = how_to,
    item1 = item1,
    item1_opt = item1_opt,
    item2 = item2,
    item3 = item3,
    item4 = item4
  ))})
