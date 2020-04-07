
# CAIC-RT

-----

## v1.1.0 (2020-04-07)

### Major Changes

  - Default length of stay in Critical Care and duration of use for
    Mechanical Ventilators have been updated to **9 days** from **20
    days** based on emegring data from Italy, [Grasselli et
    al. (2020)](https://jamanetwork.com/journals/jama/fullarticle/2764365?utm_source=twitter).

  - Default percent of critical care patients requiring mechanical
    ventilation has been updated to **70%** from **50%** based on
    emerging data from Italy, [Grasselli et
    al. (2020)](https://jamanetwork.com/journals/jama/fullarticle/2764365?utm_source=twitter).

### New Features

  - Age-stratified case distribution and severity table now supports
    users uploading CSV or Excel files with custom data

  - Multilingual: CAIC-RT now supports French and Spanish language
    translations, in addition to English (\#2).

  - Walkthrough: Added a tutorial video explaining how to use and
    interpret CAIC-RT

  - Added a bookmark button to allow users to generate a URL that
    captures the current state of the inputs
    
      - The URL allows users to return to the tool with the same inputs
        used previously.

  - Added a new modal widget for aiding users to compute the mean length
    of stay in acute care for COVID-19 patients
    
      - The widget accounts for patient-time for those who only spent
        time in acute care, and also those who spent time in acute care
        before or after spending time in critical care.

-----

## v1.0.2 (2020-03-28)

  - PDF report generation feature was added to tool

-----

## v1.0.1 (2020-03-25)

  - Minor bug fix for updating the feedback warning generated when the
    number of critical care beds was less than the number of mechanical
    ventilators
      - Previously, if the feedback warning was triggered when changing
        the critical care input, the feedback warning was not properly
        removed when the mechanical ventilator input was updated (and
        vice versa).

-----

## v1.0.0 (2020-03-24)

  - Initial public tool deployment