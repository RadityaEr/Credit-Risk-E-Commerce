# === 1) Load libraries ===
library(readr)         # untuk read_csv
library(dplyr)         # untuk manipulasi data
library(ggplot2)       # untuk plot calibration curve
library(glmtoolbox)    # untuk Hosmer-Lemeshow test

# === 2) Load CSV ===
val_data <- read_csv("E:\Coding\PEFindo\notebooks")

# Cek data
glimpse(val_data)