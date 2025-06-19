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
