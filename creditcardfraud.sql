CREATE TABLE credit_card_transactions (
    transaction_id INT PRIMARY KEY,
    transaction_amount DECIMAL(10,2),
    transaction_hour INT,
    transactions_per_day INT,
    country_risk_score DECIMAL(4,2),
    is_fraud BIT
);

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
BULK INSERT credit_card_transactions
FROM 'C:\temp\credit_card_transactions.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT COUNT(*) FROM credit_card_transactions;
SELECT TOP 10 *
FROM credit_card_transactions;
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN transaction_amount IS NULL THEN 1 ELSE 0 END) AS null_amounts
FROM credit_card_transactions;


SELECT 
    is_fraud,
    COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY is_fraud;

SELECT 
    is_fraud,
    AVG(transaction_amount) AS avg_amount
FROM credit_card_transactions
GROUP BY is_fraud;

SELECT 
    transaction_hour,
    COUNT(*) AS fraud_count
FROM credit_card_transactions
WHERE is_fraud = 1
GROUP BY transaction_hour
ORDER BY fraud_count DESC;

SELECT *
FROM credit_card_transactions
WHERE transaction_amount > 400
  AND transactions_per_day > 6
  AND country_risk_score > 0.85;

  WITH RiskSummary AS (
    SELECT
        CASE
            WHEN country_risk_score >= 0.8 THEN 'High Risk'
            WHEN country_risk_score >= 0.5 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_category,
        COUNT(*) AS total_transactions,
        SUM(is_fraud) AS fraud_transactions
    FROM credit_card_transactions
    GROUP BY
        CASE
            WHEN country_risk_score >= 0.8 THEN 'High Risk'
            WHEN country_risk_score >= 0.5 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END
)
SELECT *,
       CAST(fraud_transactions * 100.0 / total_transactions AS DECIMAL(5,2)) AS fraud_rate_percent
FROM RiskSummary
ORDER BY fraud_rate_percent DESC;

