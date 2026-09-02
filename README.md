# Sales Performance Analysis

## Project Status

**In Progress**

This project is being developed as an end-to-end business data analysis of sales performance. Current completed work includes data validation and exploratory business analysis using Python and pandas. SQL, Excel, Power BI, and final business recommendations are still in development.

## Business Objective

Analyze sales and profitability performance to identify important trends, underperforming areas, and potential drivers of weak profitability that can support better business decision-making.

## Dataset

This project uses the Sample Superstore dataset, containing approximately 10,194 records and 21 fields covering orders from 2023 through 2026.

The raw source dataset is maintained locally and is not included in this repository.

## Current Technology Stack

- Python
- pandas
- NumPy
- Matplotlib
- Jupyter
- Visual Studio Code
- Git / GitHub

SQL, Excel, and Power BI evidence will be added as those stages of the project are completed and verified.

## Analytical Approach

Current analysis follows a business-focused progression:

1. Validate the dataset and assess data quality.
2. Establish overall sales and profitability performance.
3. Identify category and sub-category performance issues.
4. Investigate potential drivers of weak profitability.
5. Translate findings into business implications.

## Data Validation

Validation identified:

- No missing values
- No exact duplicate records
- No nonpositive sales or quantities
- Discount values within expected bounds
- No shipping dates preceding order dates
- 1,901 negative-profit transactions

The negative-profit transactions were retained because they represent potentially valid business outcomes rather than data-quality errors. No corrective data cleaning was justified.

## Current Verified Findings

- Total sales: approximately **$2.327M**
- Total profit: approximately **$292.3K**
- Total orders: **5,111**
- Units sold: **38,654**
- Overall profit margin: approximately **12.56%**
- Furniture generated substantial revenue but comparatively weak profitability.
- Tables, Bookcases, and Supplies emerged as important profitability concerns.
- Every observed discount level of **30% or greater** produced a negative aggregate profit margin.
- Sales, orders, and total profit increased from 2023 through 2026, while overall profit margin declined from approximately **13.46% in 2025 to 12.87% in 2026**.
- Further investigation identified deterioration in Furniture profitability, particularly Tables.

The relationship between higher discounts and weaker profitability is treated as an association and not evidence of causation.

## Repository Structure

- `notebooks/` — Python/pandas analysis
- `sql/` — SQL analysis as it is completed
- `data/` — local data organization; raw source data is excluded from version control
- `dashboards/` — dashboard assets as they are completed
- `images/` — project visuals as they are produced
- `src/` — supporting code if required

## SQL Analysis

SQL analysis was completed in PostgreSQL as part of the same business investigation. The analysis includes KPI aggregation, category and sub-category profitability, time-based performance, discount segmentation, CTEs, and window-function ranking.

The SQL queries are available in `sql/sales_performance_analysis.sql`.

## Excel Analysis

Excel analysis was completed as part of the same business investigation. The workbook demonstrates structured data analysis, PivotTables, calculated business metrics, SUMIFS, COUNTIFS, XLOOKUP, profitability analysis, and validation of findings established through Python/pandas and PostgreSQL.

The completed Excel workbook is available in `Excel/sales_performance_analysis.xlsx`.