# 🧹📊 Layoffs Data Cleaning & Analysis Project (SQL)

## 📌 Overview

This project focuses on cleaning and analyzing a real-world layoffs dataset using SQL. The raw dataset contained inconsistencies, duplicate records, and missing values, which were systematically cleaned and then analyzed to extract meaningful insights.

Cleaned ~2300 raw records into a structured dataset of **1995 high-quality rows**, followed by SQL-based exploratory data analysis (EDA) to understand trends across companies, industries, and time.

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
* Replaced or handled nulls using logical assumptions

### 4. Fixed Data Types

* Converted date column into proper date format
* Ensured numeric consistency across fields

### 5. Final Clean Dataset

* Exported cleaned dataset for downstream analysis

---

## 📊 Exploratory Data Analysis (EDA)

Performed SQL-based analysis on the cleaned dataset to derive insights:

* Total layoffs by company
* Layoffs trends over time (monthly/yearly)
* Industry-wise layoffs distribution
* Country-wise layoffs comparison
* Funding vs layoffs relationship
* Top companies with highest layoffs

EDA queries are available in:
`sql/eda.sql`

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
│   ├── data_cleaning.sql
│   └── eda.sql
│
└── README.md
```

---

## 🧠 Sample Cleaning Query

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

## 📈 Sample EDA Query

```sql
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs
GROUP BY company
ORDER BY total_laid_off DESC;
```

---

## 📈 Key Insights

* Certain companies had significantly higher layoffs than others
* Layoffs peaked during specific time periods
* The tech industry showed higher layoff concentration
* Funding did not always correlate with job stability

---

## 🚀 Key Learnings

* Handling messy real-world datasets
* Writing efficient SQL queries for data cleaning and analysis
* Using window functions for deduplication
* Performing EDA using SQL
* Preparing datasets for analytics workflows

---

## 🔮 Future Work

* Build interactive dashboards using Power BI / Tableau
* Perform advanced analytics (trend forecasting, clustering)
* Integrate with Python for deeper analysis

---

## 📬 Contact

If you have suggestions or feedback, feel free to connect:

* GitHub: https://github.com/Swastiksangwan