# Skin Cancer SQL Analysis Project

## Project Overview

This project analyzes the DermAI Diagnostics Skin Cancer dataset using PostgreSQL and SQL to identify patterns in skin lesion prevalence, demographic risk factors, environmental exposures, lesion characteristics, and biopsy confirmation.

The project demonstrates how SQL can be used to support healthcare analytics, clinical research, and machine learning-ready data preparation.

---

## Tools Used

- PostgreSQL
- pgAdmin 4
- SQL

---

## Project Objectives

1. Develop a SQL database for skin cancer analysis.
2. Identify environmental and demographic risk factors associated with skin lesions.
3. Analyze lesion characteristics and clinical patterns.
4. Create a machine-learning-ready dataset.
5. Support future AI and dermatological research.

---

## Dataset

The project uses two relational tables:

### Patient Information

Contains:

- Patient ID
- Age
- Gender
- Smoking Status
- Pesticide Exposure
- Family History
- Medical History

### Lesion Information

Contains:

- Lesion ID
- Diagnosis
- Body Region
- Lesion Measurements
- Biopsy Status
- Clinical Characteristics

---

## Business Questions

### Aim 1: Lesion Prevalence Analysis

1. What is the most common skin lesion type?

### Aim 2: Demographic and Environmental Risk Factors

2. Are certain lesions more common in males or females?
3. What is the average age for each diagnosis?
4. Does smoking correlate with specific lesion types?
5. Does pesticide exposure correlate with skin lesion diagnoses?

### Aim 3: Lesion Characteristics and Clinical Patterns

6. Which body region is most affected?
7. Which lesion types are largest on average?
8. How many lesions were biopsy confirmed?

---

## Key Findings

- ACK was the most common lesion type with 461 cases.
- Male patients showed higher lesion prevalence than females.
- SCC had the highest average patient age (68.5 years).
- BCC was more common among pesticide-exposed patients.
- Face and forearm were the most affected body regions.
- Melanoma had the largest average lesion size.
- 458 lesions were biopsy confirmed.

---

## Machine Learning Dataset Creation

A new table named `ml_dataset` was created by joining patient and lesion information.

The dataset includes:

- Demographic variables
- Environmental risk factors
- Lesion characteristics
- Diagnosis information
- Biopsy status

The table was verified using:

```sql
SELECT *
FROM ml_dataset
LIMIT 10;
```

---

## Project Files

- SQL Queries: `skin_cancer_queries.sql`
- PowerPoint Presentation: `Capstone Project SQL Slides.pptx`
- PDF Report: `SQL Capstone.pdf`

---

## Query Results Screenshots

### Query 1: Most Common Skin Lesion Type
screenshots/query1_most_common_lesion.png

### Query 2: Lesions by Gender
screenshots/query2_gender_vs_diagnosis.png

### Query 3: Average Age by Diagnosis
screenshots/query3_average_age.png

### Query 4: Smoking Status vs Lesion Type
screenshots/query4_smoking_vs_lesion.png

### Query 5: Pesticide Exposure vs Diagnosis
screenshots/query5_pesticide_exposure.png

### Query 6: Most Affected Body Region
screenshots/query6_body_region.png

### Query 7: Average Lesion Size by Diagnosis
screenshots/query7_average_lesion_size.png

### Query 8: Biopsy Confirmation
screenshots/query8_biopsy_confirmation.png

### ML Dataset Creation
screenshots/ml_dataset_creation.png

### ML Dataset Verification
screenshots/ml_dataset_verification.png

---

## Conclusion

This project successfully used SQL to analyze skin lesion data and identify patterns in diagnoses, demographics, risk factors, lesion characteristics, and biopsy status. The findings provide insights that can support dermatological research, healthcare decision-making, and future machine learning applications.
