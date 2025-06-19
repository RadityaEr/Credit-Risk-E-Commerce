# === 1) Setup ===
.libPaths("E:/Rlibs")  # Sesuaikan path library jika perlu

library(readr)         # Baca CSV
library(dplyr)         # Manipulasi data
library(ggplot2)       # Plot calibration curve
library(ResourceSelection)  # Hosmer-Lemeshow test

# === 2) Load CSV ===
val_data <- read_csv("E:/Coding/PEFindo/notebooks/validation_results.csv")
glimpse(val_data)

# === 3) Hosmer-Lemeshow Test ===
hltest_result <- hoslem.test(
  x = val_data$actual,
  y = val_data$predicted_prob,
  g = 10
)
print(hltest_result)

# === 4) Calibration Curve ===
calib_data <- val_data %>%
  mutate(bin = ntile(predicted_prob, 10)) %>%
  group_by(bin) %>%
  summarise(
    mean_pred = mean(predicted_prob),
    mean_actual = mean(actual)
  )

calib_plot <- ggplot(calib_data, aes(x = mean_pred, y = mean_actual)) +
  geom_point(size = 3, color = "blue") +
  geom_line(color = "blue") +
  geom_abline(linetype = "dashed", color = "red") +
  labs(
    title = "Calibration Curve",
    x = "Predicted Probability",
    y = "Observed Default Rate"
  ) +
  theme_minimal()

ggsave("calibration_curve.png", calib_plot, width = 6, height = 4, dpi = 300)

# === 5) Cari Cut-off Probability untuk Expected Default ≤ 5% ===
cutoff_candidates <- seq(0.01, 0.99, by = 0.01)  # rentang lebih luas

cutoff_results <- sapply(cutoff_candidates, function(cut) {
  selected <- val_data %>% filter(predicted_prob > cut)
  if (nrow(selected) == 0) return(NA)
  mean(selected$actual)
})

cutoff_table <- data.frame(
  cutoff_prob = cutoff_candidates,
  expected_default = cutoff_results
)

# Ambil cutoff probability terkecil yang <= 5%
best_cutoff <- cutoff_table %>%
  filter(!is.na(expected_default)) %>%
  filter(expected_default <= 0.05) %>%
  slice_min(cutoff_prob)

print(best_cutoff)

# === 6) Konversi Cut-off Probability ke Skor 300–850 ===
scorecard <- function(prob, min_score = 300, max_score = 850) {
  min_score + (1 - prob) * (max_score - min_score)
}

# Hitung skor untuk cut-off probability
cutoff_prob <- best_cutoff$cutoff_prob[1]
cutoff_score <- scorecard(cutoff_prob)

cat("=== Cut-off ===\n")
cat("Cut-off Probability :", cutoff_prob, "\n")
cat("Expected Default Rate :", best_cutoff$expected_default[1], "\n")
cat("Equivalent Cut-off Score :", cutoff_score, "\n")
