# 🧹 Layoffs Data Cleaning Project (SQL)

## 📌 Overview

This project focuses on cleaning and preparing a real-world layoffs dataset using SQL. The raw dataset contained inconsistencies, duplicate records, and missing values, which were systematically cleaned to make it suitable for analysis.

Cleaned ~2300 raw records into a structured dataset of **1995 high-quality rows**, ready for further analysis and visualization.

---

## ⚙️ Tools Used

* MySQL
* SQL
* Excel (for initial inspection)

---

## 🧹 Data Cleaning Steps

### 1. Removed Duplicates

* Used `ROW_NUMBER()` window function
* Partitioned data based on key columns (company, location, industry)
* Identified and removed duplicate records

### 2. Standardized Data

* Trimmed and cleaned company names
* Standardized inconsistent industry labels
* Unified country and location formats

### 3. Handled Null Values

* Identified missing values across columns
* Replaced or handled nulls using logical assumptions where applicable

### 4. Fixed Data Types

* Converted date column into proper date format
* Ensured numeric consistency across fields like layoffs and funding

### 5. Final Clean Dataset

* Exported cleaned dataset for downstream analysis

---

## 📊 Dataset

* Raw dataset: `data/raw_layoffs.csv`
* Cleaned dataset: `data/cleaned_layoffs_dataset.csv`

---

## 📂 Project Structure

```
layoffs-data-cleaning-sql/
│
├── data/
│   ├── raw_layoffs.csv
│   └── cleaned_layoffs_dataset.csv
│
├── sql/
│   └── data_cleaning.sql
│
└── README.md
```

---

## 🧠 Sample Query Used

```sql
WITH cte AS (
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry 
        ORDER BY total_laid_off
    ) AS row_num
    FROM layoffs
)
DELETE FROM cte WHERE row_num > 1;
```

---

## 🚀 Key Learnings

* Handling messy real-world datasets
* Writing efficient SQL queries for data cleaning
* Using window functions for deduplication
* Preparing datasets for analytics workflows

---

## 🔮 Future Work

* Perform Exploratory Data Analysis (EDA)
* Build interactive dashboards using Power BI / Tableau
* Derive insights on layoffs trends across industries and countries

---

## 📬 Contact

If you have suggestions or feedback, feel free to connect:

* GitHub: https://github.com/Swastiksangwan