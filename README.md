# 📊 E-commerce & Credit Risk Analysis

This project demonstrates practical data analysis and predictive modeling using **SQL**, **Python**, and **R**. It covers customer segmentation, anomaly detection, loan approval modeling, and probability calibration.

---

##  Project Contents

### 1 E-commerce Customer Segmentation (SQL)
- Segments e-commerce customers into **6 segments** based on RFM metrics.
- Detects anomalies in transaction data.
- Identifies repeat orders for each customer in each month.
- Query written in standard SQL (PostgreSQL).

### 2 Loan Approval Modeling (Python)
- Predicts whether a loan application would be approved.
- Machine Learning models: **Logistic Regression**, **Gradient Boosting**, with **SMOTE** for class imbalance.
- Includes data cleaning, feature engineering, model training, prediction, and output of a validation dataset (`actual` vs `predicted_prob`).

### 3 Credit Risk Validation & Calibration (R)
- Uses the validation dataset generated in Python.
- Validates model calibration with:
  - **Hosmer-Lemeshow Test** (`ResourceSelection::hoslem.test`).
  - **Calibration Curve** (`ggplot2`).
  - Determines cut-off probability and equivalent credit score for **Expected Default Rate ≤ 5%**.
- Converts predicted probability into an industry-standard scorecard scale (300–850).

---

## ⚙️ How to Run

- **SQL:** Run queries directly in your SQL editor (tested on PostgreSQL).
- **Python:** Execute the Jupyter Notebook or `.py` script to train models and create the validation set.
- **R:** Run `validation.R` to perform the Hosmer-Lemeshow test, plot the calibration curve, and find the cut-off score.

---

## ✅ Key Highlights

- Combines **segmentation**, **predictive modeling**, and **risk calibration** in one workflow.
- Demonstrates real-world data science steps with clear outputs.
- Produces actionable cut-off scores for credit decision-making.

---

## 📌 Dependencies

**SQL:** PostgreSQL  
**Python:** `pandas`, `numpy`, `scikit-learn`, `imblearn`  
**R:** `readr`, `dplyr`, `ggplot2`, `ResourceSelection`

---
