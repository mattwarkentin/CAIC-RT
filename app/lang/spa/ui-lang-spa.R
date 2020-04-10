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

submit <- "Aplicar cambios"

close <- "Cerca"

dev_by <- "Desarrollado por"

tran_by <- "Traducción por"
tb <- "Parth Patel"
email <- "parthk.patel@mail.utoronto.ca"

## Navbar ----

home <- "Hogar"

help <- "Ayuda"

tutorial <- "De tutoría"

more_info <- "Más información"

see_article <- "Ver el artículo"

see_code <- "Ver el código"

## Panel 1 ----

last_update <- "Última actualizada"

lang <- "Elige lengua"

about_tool <- "Acerca de esta herramienta"

contribute <- "¿Cómo puedo contribuir?"

p1_header <- "Utilización esperada de recursos para pacientes con COVID-19"

lou_acute_label <- "Días medios en cuidados agudos"

lou_acute_tooltip <- "Nota: Los días de cuidado agudo se excluyen mutuamente de los días de cuidado crítico y ventilador."

lou_crit_label <- "Días medios en cuidados críticos"

lou_crit_tooltip <- "Nota: Los días de cuidados críticos se excluyen mutuamente de los días de cuidados agudos. El número total de días en cuidados críticos es igual al número de días en cuidados críticos con o sin ventilador."

lou_vent_label <- "Días medios en un ventilador mecánico"

lou_vent_tooltip <- "Nota: Se supone que los días que se pasan en un ventilador mecánico se pasan en una cama de cuidados críticos."

p1_footnote <- "Los valores predeterminados se basan en datos extraídos de Grasselli et al. (2020), recogido en Italia. Vea la página de ayuda para citas completas."

## Panel 2 ----

p2_header <- "Disponibilidad de recursos"

n_acute_label <- "Número de camas de cuidados agudos para pacientes con COVID-19"

n_acute_tooltip <- "Nota: Este es el número total de camas de cuidados agudos que están disponibles o que actualmente están siendo utilizados por pacientes con COVID-19."

calc_acute <- "Calcular camas de cuidado agudo"

acute_modal_title <- "Calcule el número de camas de cuidados agudos disponibles para los casos de COVID-19"

acute_modal_n_acute <- "Número total de camas de cuidados agudos"

acute_modal_per_acute <- "Porcentaje de camas de cuidados agudos disponibles o que están siendo utilizados actualmente para los casos COVID-19"

acute_modal_surge <- "Cama para cuidados capacidad de oleada agudos  para casos COVID-19 (número de camas)"

n_crit_label <- "Número de camas de cuidados críticos para pacientes con COVID-19"

n_crit_tooltip <- "Nota: Esta es la cantidad total de camas de cuidados críticos que están disponibles o que actualmente están siendo utilizadas por pacientes con COVID-19."

calc_crit <- "Calcular camas de cuidados críticos"

crit_modal_title <- "Calcule la cantidad de camas de cuidados críticos disponibles para los casos COVID-19"

crit_modal_n_crit <- "Número total de camas de cuidados críticos"

crit_modal_per_crit <- "Porcentaje de camas de cuidados críticos disponibles o que están siendo utilizados actualmente por los casos COVID-19"

crit_modal_surge <- "Cama de cuidados críticos capacidad de oleada para COVID-19 casos (número de camas)"

n_vent_label <- "Número de ventiladores mecánicos para pacientes con COVID-19"

n_vent_tooltip <- "Nota: Este es el número total de ventiladores mecánicos que están disponibles o que actualmente están siendo utilizados por pacientes con COVID-19."

calc_vent <- "Calcular ventiladores mecánicos"

vent_modal_title <- "Calcule la cantidad de ventiladores mecánicos disponibles para los casos COVID-19"

vent_modal_n_vent <- "Número total de ventiladores mecánicos"

vent_modal_per_vent <- "Porcentaje de ventiladores mecánicos disponibles o que están siendo utilizados actualmente por los casos COVID-19"

vent_modal_surge <- "Ventilador mecánico capacidad de oleada del para COVID-19 casos (número de ventiladores)"

per_vent_label <- "Porcentaje de pacientes de cuidados críticos que requieren ventilación mecánica"

per_vent_tooltip <- "Nota: Este es el porcentaje de pacientes con cuidados críticos COVID-19 que requieren ventilación mecánica."

p2_footnote_1 <- "El porcentaje predeterminado de pacientes de cuidados críticos que requieren ventilación mecánica se basa en datos extraídos de Grasselli et al. (2020), Zhou et al. (2020), y Wang et al. (2020), recogido en Italia y China. Vea la página de ayuda para citacions completas."

p2_footnote_2 <- "El número predeterminado de camas de cuidados agudos, camas de cuidados críticos y ventiladores mecánicos se basa en datos extraídos de Barrett et al. (2020), recogido en Ontario. Vea la página de ayuda para citacións completas."

bookmark <- "Marcapágina valores personalizados"

bookmark_title <- "Marcada Aplicación Enlace"

bookmark_sub <- "Este enlace almacena el estado actual de esta aplicación."

## Panel 3 ----

table_title1 <- "Distribución de casos y gravedad estratificada por edad"

table_title2 <- "haga clic para alternar la visibilidad"

table_source <- "Fuente"

table_tip <- "SUGERENCIA: haga doble clic en una celda para comenzar a editar. Use [TAB] para navegar por los elementos de la columna mientras edita. Presione [CONTROL + ENTER] cuando termine de editar una columna."

plot_title <- "Número diario máximo de casos incidentes de COVID-19 manejables por el sistema de salud"

plot_desc <- "Los valores que se muestran a continuación son umbrales para el número máximo diario de casos COVID-19 incidentes que pueden ocurrir sin causar un déficit de recursos. En otras palabras, si ocurren más casos que los valores que se muestran a continuación, la cantidad de camas de cuidados agudos, camas de cuidados críticos y / o ventiladores mecánicos sería insuficiente para satisfacer las necesidades del sistema de salud."

color_label <- "Elegir paleta de colores"

interpret_title <- "Interpretando los resultados"

acute_res_title <- "Cuidados agudos"

crit_res_title <- "Cuidado crítico"

vent_res_title <- "Ventiladores mecanicas"

report_button <- "Generar informe PDF"

## Help Page ----

help_welcome <- "Bienvenido a la página de ayuda de la COVID-19 Acute and Intensive Care Resource Tool (CAIC-RT). Esta página proporciona información de contacto y importantes recursos que se utilizaron al desarrollar esta herramienta."

contact_title <- 'Contacto'

# {person} is the name of the persons to contact
contact_info <- "Si desea ponerse en contacto con los desarrolladores de esta herramienta con cualquier comentario, pregunta o realimentación, envíe un correo electrónico a {person}."

thanks <- '¡Gracias por usar nuestra herramienta! ¡Esperamos con interés escuchar de usted!'

important_resources <- "Recursos importantes"

resource_sentence <- "A continuación se presentan algunos recursos clave que se utilizaron al desarrollar esta herramienta."

# Server Side ====

## Language Modal ----

lang_title <- "¿Cómo puedo contribuir?"

# {CoC} is a named-link to the Contributor Code of Conduct
cont_details <- "Nos honra que esté interesado en contribuir a este proyecto. En este momento, estamos muy interesados en colaborar para traducir esta herramienta a tantos idiomas como sea posible. Primero, por favor lea el {CoC}."

how_to_cont <- "Para contribuir, por favor asegúrese de cumplir con los siguientes criterios:"

cont1 <- "Eres multilingüe, donde uno de los idiomas es el inglés."
cont2 <- "Tiene capacitación técnica en una de las siguientes áreas: medicina, epidemiología, ciencias médicas, salud pública o un campo relacionado."

# {deepit} and {matt} are links to our names/emails
thats_it <- "¡Eso is! Si cumple con los ambas criterios anteriores, nos complacerá tenerte contribuya a este proyecto. Si todavía está interesado en contribuir a este esfuerzo de traducción, comuníquese con {deepit} o {matt} para obtener instrucciones sobre cómo contribuir."

recognition <- "Por último, si usted contribuye a este proyecto, estaremos encantados de presentar su nombre dentro de la herramienta para poder darle el reconocimiento adecuado"

# {CoC} is a named-link to the Contributor Code of Conduct
code <- "Tenga por favor en cuenta que el proyecto 'CAIC-RT' se publicada con un {CoC}. Al contribuir a este proyecto, acepta cumplir con sus términos."

## Welcome Modal ----

welcome_title <- "CAIC-RT: COVID-19 herramienta de recursos de cuidados agudos e intensivos"

authors <- "Autoras"

desc_title <- "Descripción"

desc <- "Una herramienta en línea capaz de estimar la cantidad máxima diaria de casos de COVID-19 incidentes que un sistema de atención médica podría manejar en función de la casos distribución y la gravedad de los casos edad-según, y la cantidad de disponibles de para agudos y cuidados críticos recursos."

how_to <- "Cómo utilizar esta herramienta:"

# {CDC} is a link to the CDC resource
item1 <- "Revise los datos edad-estratificados de distribución de casos y gravedad predeterminados, que se basan en los datos de US del {CDC}."

item1_opt <- "Opcional: puede ingresar su propia información en la tabla en función de los datos clínicos locales y la experiencia."

# We recommend being consistent with p1_header and p2_header
item2 <- "Ajuste las esperadas de utilización de recursos y disponibilidad de recursos entradas a propio entorno de atención médica."

item3 <- "Inspeccione los resultados en el gráfico de barras, que muestra el número máximo diario de casos de COVID-19 incidentes que un sistema de atención médica podría gestionar en función de la disponibilidad de recursos."

item4 <- "Visualice en tiempo real cómo cambian los resultados cuando modificar los parámetros de entrada."

## Feedback ----

n_crit_feedback <- "Advertencia: El número de camas de cuidados críticos es menor que el número de ventiladores mecánicos."

n_vent_feedback <- "Advertencia: El número de ventiladores mecánicos es mayor que el número de camas de cuidados críticos."

## Data Table ----

input_label <- "Subir archivo (CSV, Excel)"

input_btn <- "Ramoneo"

input_placehold <- "Ningún archivo seleccionado"

input_text <- "La continuación tabla es editable. Sin embargo, es posible que desee cargar sus propios datos. Las columnas deben estar en el mismo orden que la tabla a continuación. Se supone que el archivo tiene un encabezado, aunque las etiquetas de encabezado se ignoran."

table_col1 <- "Grupos de edad"

table_col2 <- "Distribución de casos (%)"

table_col3 <- "Admisión de atención aguda (%)"

table_col4 <- "Admisión de cuidados críticos (%)"

table_modal_txt <- "Esta columna solo puede aceptar entradas numéricas. Por favor revise sus números!"

table_modal_sum <- "La columna de distribución de casos debe sumar 100%. Por favor revise sus números!"

table_modal_adm <- "Las tasas de admisión no pueden ser inferiores al 0% ni superiores al 100%. Por favor revise sus números!"

reset <- "Reajustar"

## Plot ----

ylab <- "Número diario máximo de casos"

xlab_acute <- "Camas para cuidados agudos"

xlab_crit <- "Camas de cuidados críticos"

xlab_vent <- "Ventiladores mecanicas"

xlab_suffix <- "casos/día"

# {resource} is either acute care beds, critical care beds, or mechanical ventilators
# {value} is the maximum number of cases for any {resource}
plot_tooltip <- "El número de disponible {resource} en este sistema de atención médica puede administrar un máximo de {value} casos diarios de COVID-19"

## Interpretations ----

# n_* is the number of each resource available
# lou_* is the number of days using a resource
# *BedRate is the resource turnover rate
# rate* is the rate of COVID-19 patients requiring a resource
# max* is the maximum number of manageable COVID-19 cases

summary_acute <- 'Según las {n_acute} disponible camas de cuidados agudos y una estadía promedio de {lou_acute} días, a la capacidad máxima, la tasa de rotación esperada es de {acuteBedRate} camas por día. Según la distribución de casos estratificada por edad, la proporción de casos de COVID-19 que requieren una cama para cuidados agudos es del {rateAcute} por ciento. Dado esto, su entorno de atención médica tiene la capacidad de gestionar un máximo de {maxAcute} casos incidentes de COVID-19 por día.'

summary_crit <- 'Según las {n_crit} disponible camas de cuidados críticos y una estadía promedio de {lou_crit} días, a la capacidad máxima, la tasa de rotación esperada es de {critBedRate} camas por día. Según la distribución de casos estratificada por edad, la proporción de casos de COVID-19 que requieren una cama de cuidados críticos es del {rateCrit} por ciento. Dado esto, su entorno de atención médica tiene la capacidad de gestionar un máximo de {maxCrit} casos incidentes de COVID-19 por día.'

summary_vent <- 'Según las {n_vent} disponible camas de atención ventical y una estadía promedio de {lou_vent} días, a la capacidad máxima, la tasa de rotación esperada es de {ventBedRate} camas por día. Según la distribución de casos estratificada por edad, la proporción de casos de COVID-19 que requieren una cama de atención ventical es {rateVent} por ciento. Dado esto, su entorno de atención médica tiene la capacidad de gestionar un máximo de {maxVent} casos incidentes de COVID-19 por día.'

## Report ----

progress_1 <- "Generando informe..."

progress_2 <- "Mantener apretada, esto puede tomar unos minutos."

report_type <- "Informe general"

report_date <- "Informe generado"

tool_info <- "Información de herramienta"

custom_inputs <- "Entradas personalizables"

# This should be partially consistent with p2_header
caption2 <- "Disponibilidad de recursos para pacientes con COVID-19."

col_name1 <- "Parámetro de input"

col_name2 <- "Valor"
