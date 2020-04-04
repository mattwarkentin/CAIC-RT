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

submit <- "Appliquer les modifications"

close <- "Fermer"

dev_by <- "Développé par"

tran_by <- "Traduction par"
tb <- "Alexandra Blair"
email <- "alexandra.blair@mail.utoronto.ca"

## Navbar ----

home <- "Acceuil"

help <- "Aide"

tutorial <- "Guide"

more_info <- "Plus d'information"

see_article <- "Afficher la référence"

see_code <- "Afficher la syntaxe"

## Panel 1 ----

last_update <- "Dernière mise à jour"

lang <- "Choisir la langue"

about_tool <- "À propos de cet outil"

contribute <- "Comment contribuer?"

p1_header <- "Utilisation prévue des ressources pour les patients atteints de la COVID-19"

lou_acute_label <- "Nombre moyen de jours en soins aigus"

lou_acute_tooltip <- "À noter: Les jours en soins aigus s'excluent mutuellement des jours en soins intensifs et sous ventilation mécanique."

lou_crit_label <- "Nombre moyen de jours en soins intensifs"

lou_crit_tooltip <- "À noter: Les jours en soins intensifs s'excluent mutuellement des jours en soins aigus. Le nombre total de jours passés en soins intensifs est égal au nombre de jours passés en soins intensifs avec ou sans ventilation mécanique."

lou_vent_label <- "Nombre moyen de jours sous ventilation mécanique"

lou_vent_tooltip <- "À noter: Il est présupposé que les jours passés sous ventilation mécanique sont passés dans un lit de soins intensifs"

p1_footnote <- "Les valeurs de défaut sont basées sur des données extraites de Zhou et al. (2020), Yang et al. (2020), et Wang et al. (2020), recueillies en Chine. Naviguez vers la page d'Aide pour visualiser les références complètes."

## Panel 2 ----

p2_header <- "Disponibilité des ressources"

n_acute_label <- "Nombre de lits de soins aigus disponibles pour les patients atteints de la COVID-19"

n_acute_tooltip <- "À noter: Ceci représente le nombre total de lits de soins aigus disponibles pour ou présentement occupés par des patients atteints de la COVID-19."

calc_acute <- "Calculer le nombre de lits de soins aigus"

acute_modal_title <- "Calculer le nombre de lits de soins aigus disponibles pour les patients atteints de la COVID-19"

acute_modal_n_acute <- "Nombre total de lits de soins aigus"

acute_modal_per_acute <- "Pourcentage de lits de soins aigus disponibles pour ou présentement occupés par des patients atteints de la COVID-19" 

acute_modal_surge <- "Capacité de pointe de lits de soins aigus pour les cas de COVID-19 (nombre de lits)"

n_crit_label <- "Nombre de lits de soins intensifs pour les patients atteints de la COVID-19"

n_crit_tooltip <- "À  noter: Ceci représente le nombre total de lits de soins intensifs disponibles pour ou présentement occupés par des patients atteints de la COVID-19."

calc_crit <- "Calculer le nombre de lits de soins intensifs"

crit_modal_title <- "Calculer le nombre de lits de soins intensifs disponibles pour les cas de COVID-19"

crit_modal_n_crit <- "Nombre total de lits de soins intensifs"

crit_modal_per_crit <- "Pourcentage de lits de soins intensifs disponibles pour ou présentement occupés par des patients atteints de la COVID-19"

crit_modal_surge <- "Capacité de pointe de lits de soins intensifs les cas de COVID-19 (nombre de lits)"

n_vent_label <- "Nombre de ventilateurs pour les patients atteints de la COVID-19"

n_vent_tooltip <- "À noter: Ceci représente le nombre de ventilateurs disponibles pour, ou présentement utilisés par, des patients atteints de la COVID-19."

calc_vent <- "Caculer le nombre de dispositifs</br> de ventilation mécanique"

vent_modal_title <- "Caculer le nombre de dispositifs de ventilation mécanique disponibles pour les cas de COVID-19"

vent_modal_n_vent <- "Nombre total de dispositifs de ventilation mécanique"

vent_modal_per_vent <- "Pourcentage de dispositifs de ventilation mécanique disponibles pour ou présentement utilisés par des cas de COVID-19"

vent_modal_surge <- "Capacité de pointe de dispositifs de ventilation mécanique pour les cas de COVID-19 (nombre de ventilateurs)"

per_vent_label <- "Pourcentage de patients en soins intensifs nécessitant une ventilation mécanique"


per_vent_tooltip <- "À noter: Ceci représente le pourcentage de patients atteints de la COVID-19 en soins intensifs nécessitant une ventilation mécanique" 

p2_footnote_1 <- "Les pourcentages par défaut de patients en soins intensifs nécessitant une ventilation mécanique sont basés sur des données extraites de Zhou et al. (2020) et Wang et al. (2020), recueillies en Chine. Naviguez vers la page d'Aide pour visualiser les références complètes."

p2_footnote_2 <- "Les nombres par défaut de lits de soins intensifs, lits de soins aigus, et de dispositifs de ventilation mécanique sont basés sur des données extraites de Barrett et al. (2020) recueillies en Ontario. Naviguez vers la page d'Aide pour visualiser les références complètes."

bookmark <- "Enregistrer l'état actuel des intrants </br>personnalisés sous forme d'URL"

bookmark_title <- "Ajouter l'application à vos favoris"

bookmark_sub <- "Ce lien enregistre l'état actuel de cette application."

## Panel 3 ----

table_title1 <- "Distribution et sévérité des cas stratifiés selon l'âge"

table_title2 <- "Cliquez pour visualiser"

table_source <- "Référence"

table_tip <- "ASTUCE: Double-cliquez sur une cellule du tableau pour effectuer une modification des valeurs. Utilisez la touche [TAB] de votre clavier pour naviguer entre les éléments de la colonne pendant l'édition. Appuyez simultanément sur les touches [CONTROL + ENTRÉE/ENTER] de votre clavier lorsque vous avez terminé l'édition d'une colonne."

plot_title <- "Le nombre maximal de nouveaux cas de COVID-19 par jour pouvant être gérés par le système de santé"

plot_desc <- "Les valeurs indiquées ci-dessous représentent les seuils maximaux du nombre de cas incidents de COVID-19 (nouveaux cas) qui peuvent s'ajouter par jour sans entraîner un déficit de ressources. En d'autres mots, si le nombre de cas dépasse les valeurs indiquées ci-dessous, le nombre de lits de soins aigus, de lits de soins intensifs et/ou de ventilateurs sera insuffisant pour répondre aux besoins du système de santé."

color_label <- "Choisir une palette de couleurs"

interpret_title <- "Interprétation des résultats"

acute_res_title <- "Soins aigus"

crit_res_title <- "Soins intensifs"

vent_res_title <- "Dispositifs de ventilation mécanique"

report_button <- "Générer un rapport en format PDF"

## Help Page ----

help_welcome <- "Bienvenue à la page d'Aide du CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool (Outil de ressources pour les soins aigus et intensifs de COVID-19). Cette page fournit les coordonnées pour rejoindre les développeurs de l'outil ainsi que les ressources clés qui ont été utilisées lors l'élaboration de l'outil"

contact_title <- "Coordonnées"

# {person} is the name of the persons to contact

contact_info <- "Si vous souhaitez contacter les développeurs de cet outil pour tout commentaire, question ou réaction, veuillez envoyer un courriel à {person}"

thanks <-"Merci d'utiliser notre outil ! Au plaisir de recevoir vos commentaires!"

important_resources <- "Ressources clés"

resource_sentence <- "Vous trouverez ci-dessous quelques ressources clés qui ont été utilisées lors de l'élaboration de cet outil"

# Server Side ====

## Language Modal ----

lang_title <- "Comment contribuer?"

# {CoC} is a named-link to the Contributor Code of Conduct [Un code de conduite des contributeurs]

cont_details <- "Nous sommes reconnaissants de l'intérêt que vous portez à ce projet. En ce moment, nous souhaitons collaborer à la traduction de cet outil dans le plus grand nombre de langues possible. Tout d'abord, veuillez lire le {CoC}."
  
how_to_cont <- "Afin de pouvoir contribuer, veuillez vous assurer que vous remplissez les critères suivants:"

cont1 <- "Vous maîtrisez plusieurs langues, dont l'une doit être l'anglais"

cont2 <- "Vous avez une formation technique dans l'un des domaines suivants: la médecine, l'épidémiologie, les sciences médicales, la santé publique ou un domaine connexe"

# {deepit} and {matt} are links to our names/emails

thats_it <- "C'est tout! Si vous remplissez les deux critères ci-dessus, nous serions heureux que vous contribuiez à ce projet. Si vous êtes intéressé à contribuer aux efforts de traduction de cet outil, veuillez contacter {deepit} ou {matt} pour obtenir des instructions concernant la démarche à suivre."

recognition <-"Enfin, si vous contribuez à ce projet, nous serions heureux de publier votre nom dans l'outil afin de reconnaître votre contribution."
  
# {CoC} is a named-link to the Contributor Code of Conduct [Un code de conduite des contributeurs]

code <- "Veuillez noter que le projec âCAIC-RTâ  est publié avec un {CoC}. En contribuant à ce projet, vous acceptez de respecter les conditions stipulées."

## Welcome Modal ----

welcome_title <- "CAIC-RT: COVID-19 Acute and Intensive Care Resource Tool (Outil de ressources pour les soins aigus et intensifs de COVID-19)"

authors <- "Auteurs"

desc_title <- "Description"

desc <- "Un outil en ligne capable d'estimer le nombre maximal de nouveaux cas de COVID-19 par jour qu'un système de santé pourrait gérer en fonction de la répartition des cas selon leur âge et de leur sévérité, ainsi que du nombre de ressources disponibles pour les soins aigus et intensifs."
  
how_to <- "Comment utiliser cet outil:"

# {CDC} is a link to the CDC resource

item1 <- "Visualiser la distribution par défaut des cas, stratifiés selon l'âge et la sévérité, qui est basée sur les données américaines du {CDC}."
  
item1_opt <- "Facultatif : vous pouvez entrer vos propres données dans le tableau en fonction de vos données cliniques ou de votre expérience locale."

# We recommend being consistent with p1_header and p2_header

item2 <- "Modifiez les données relatives à l'utilisation prévue des ressources et à la disponibilité des ressources, selon le contexte de votre système de santé."

item3 <- "Examinez les résultats dans l'histogramme (graphique à colonnes), qui affiche le nombre maximal de nouveaux cas de COVID-19 par jour qu'un système de santé pourrait gérer en fonction de la disponibilité des ressources."

item4 <- "Visualisez en temps réel la manière dont les résultats changent lorsque vous modifiez les paramètres."
  

## Feedback ----

n_crit_feedback <- "Attention: le nombre de lits de soins intensifs est inférieur au nombre de dispositifs de ventilation mécanique."

n_vent_feedback <- "Attention: le nombre de dispositifs de ventilation mécanique est supérieur au nombre de lits de soins intensifs."


## Data Table ----

input_label <- "Télécharger un document (CSV, Excel)"

input_btn <- "Parcourir"

input_placehold <- "Aucun document sélectionné"

input_text <- "Le tableau ci-dessous est modifiable. Cependant, vous souhaiterez peut-être télécharger vos propres données. Si oui, le fichier doit avoir quatre colonnes, placées dans le même ordre que celles dans le tableau ci-dessous. La première rangée du tableau sera considérée comme l'en-tête, bien que les étiquettes d'en-tête seront ignorées."

table_col1 <- "Groupes d'âge"

table_col2 <- "Distribution des cas (%)"

table_col3 <- "Admis aux soins aigus (%)"

table_col4 <- "Admis aux soins intensifs (%)"

table_modal_txt <- "Cette colonne ne peut accepter que des entrées numériques. Veuillez vérifier vos chiffres!"

table_modal_sum <- "La somme des valeurs dans la colonne de la distribution de cas doit être égale à 100%. Veuillez vérifier vos chiffres!"

table_modal_adm <- "Le pourcentage de cas admis ne peut être inférieur à 0% ou supérieur à 100%. Veuillez vérifier vos chiffres!"

reset <- "Réinitialiser"

## Plot ----

ylab <- "Nombre maximal de cas par jour"

xlab_acute <- "Lits de soins aigus"

xlab_crit <- "Lits de soins intensifs"

xlab_vent <- "Dispositifs de ventilation mécanique"

xlab_suffix <- "nouveaux cas/jour"

# {resource} is either acute care beds, critical care beds, or mechanical ventilators
# {value} is the maximum number of cases for any {resource}

plot_tooltip <- "Les {resource} disponibles dans ce système de santé peuvent gérer un maximum de {value} nouveaux cas par jour de COVID-19"

## Interpretations ----

# n_* is the number of each resource available
# lou_* is the number of days using a resource
# *BedRate is the resource turnover rate
# rate* is the rate of COVID-19 patients requiring a resource
# max* is the maximum number of manageable COVID-19 cases

summary_acute <- "Ayant {n_acute} lits de soins aigus disponibles et présupposant une durée moyenne de séjour de {lou_acute} jours en soins aigus, à capacité maximale, le taux de rotation prévu pour ce système de soins est de {acuteBedRate} lits de soins aigus libérés par jour. Selon la distribution d'âge des cas, la proportion de cas de COVID-19 nécessitant un lit de soins aigus est de {rateAcute}%. Compte tenu de cela, ce système de santé a la capacité de gérer un maximum de {maxAcute} nouveaux cas de COVID-19 par jour."

summary_crit <- "Ayant {n_crit} lits de soins intensifs disponibles et présupposant une durée moyenne de séjour de {lou_crit} jours en soins intensifs, à capacité maximale, le taux de rotation prévu pour ce système de soins est de  {critBedRate} lits de soins intensifs libérés par jour. Selon la distribution d'âge des cas, la proportion de cas de COVID-19 nécessitant un lit de soins intensifs est de {rateCrit}%. Compte tenu de cela, ce système de santé a la capacité de gérer un maximum de {maxCrit} nouveaux cas de COVID-19 par jour."

summary_vent <- "Ayant {n_vent} dispositifs de ventilation mécanique et présupposant une durée moyenne de {lou_crit} jours sous ventilation mécanique, à capacité maximale, le taux de rotation prévu pour ce système de soins est de {ventBedRate} dispositifs de ventilation mécanique libérés par jour. Selon la distribution d'âge des cas, la proportion de cas de COVID-19 nécessitant un dispositif de ventilation mécanique est de {rateVent}%. Compte tenu de cela, ce système de santé a la capacité de gérer un maximum de {maxVent} nouveaux cas de COVID-19 par jour."
  
## Report ----

progress_1 <- "Génération du rapport..."

progress_2 <- "Patientez, cela peut prendre quelques instants."

report_type <- "Rapport global"

report_date <- "Rapport généré:"

tool_info <- "Renseignements relatifs à l'outil"

custom_inputs <- "Intrants personnalisés"

# This should be partially consistent with p2_header

caption2 <- "Disponibilité des ressources pour les patients atteints de la COVID-19"

col_name1 <- "Intrant"

col_name2 <- "Valeur"
