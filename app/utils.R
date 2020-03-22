# Acute rate
rateAcute <- function(x, y) {
  sum((x * 0.01) * (y * 0.01)) * 100
}

# Critical Rate
rateCrit <- function(x, y) {
  sum((x * 0.01) * (y * 0.01)) * 100
}

# Ventilation Rate
rateVent <- function(x, y, per_vent) {
  sum((x * 0.01) * (y * 0.01) * (per_vent * 0.01)) * 100
}

# Acute Bed Rate
acuteBedRate <- function(n_acute, lou_acute) {
  n_acute / lou_acute
}

# Critical Bed Rate
critBedRate <- function(n_crit, lou_crit) {
  n_crit / lou_crit
}

# Ventilaion Bed Rate
ventBedRate <- function(n_vent, lou_vent) {
  n_vent / lou_vent
}

# Maximum Acute
maxAcute <- function(x, y, n_acute, lou_acute) {
  stopifnot(length(x)==length(y))
  if (!dplyr::near(sum(x, na.rm = TRUE), 100, tol = 0.1)) {
    0
  } else {
    (n_acute / lou_acute) / (sum((x * 0.01) * (y * 0.01), na.rm = TRUE))
  }
}

# Maximum Critical
maxCrit <- function(x, y, n_crit, lou_crit) {
  stopifnot(length(x)==length(y))
  if (!dplyr::near(sum(x, na.rm = TRUE), 100, tol = 0.1)) {
    0
  } else {
  (n_crit / lou_crit) / (sum((x * 0.01) * (y * 0.01), na.rm = TRUE))
  }
}

# Maximum Ventilarion
maxVent <- function(x, y, n_vent, lou_vent, per_vent) {
  stopifnot(length(x)==length(y))
  if (!dplyr::near(sum(x, na.rm = TRUE), 100, tol = 0.1)) {
    0
  } else {
  ((n_vent / lou_vent)) / sum((x * 0.01) * (y * 0.01) * (per_vent * 0.01), na.rm = TRUE)
  }
}
