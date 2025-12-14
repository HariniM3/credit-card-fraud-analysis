# credit-card-fraud-analysis
SQL-based credit card fraud analysis using synthetic data

## Project Overview
This project analyzes credit card transaction data to identify fraudulent patterns using SQL.
The dataset contains 50,000 synthetic transactions generated to simulate real-world fraud behavior.

## Tools Used
- SQL Server (SSMS)
- Python (for data generation)
- Power BI (for visualization)

## Dataset
Each transaction includes:
- Transaction amount
- Transaction hour
- Daily transaction frequency
- Country risk score
- Fraud flag

## Key Analysis Performed
- Fraud vs non-fraud transaction comparison
- Average transaction value analysis
- Time-based fraud pattern detection
- Risk categorization using CASE statements
- Fraud rate calculation using CTEs

## Key Insights
- Fraudulent transactions tend to have higher average amounts
- High-risk regions show significantly higher fraud rates
- Fraud frequency increases during late-night hours

## SQL Concepts Used
- Aggregations
- CASE statements
- Common Table Expressions (CTEs)
- Data validation checks

## Conclusion
This analysis demonstrates how SQL can be used to detect fraud patterns and support risk-based decision making.
