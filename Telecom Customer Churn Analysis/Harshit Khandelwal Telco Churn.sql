-- Churn Rate by month
WITH MonthlyChurn AS (
    SELECT tenure AS Month, COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY tenure
)
SELECT Month, TotalCustomers, ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS ChurnRate
FROM MonthlyChurn
ORDER BY Month;

-- Churn rate by customer demographics

WITH DemographicChurn AS (
    SELECT gender, SeniorCitizen, Partner, Dependents,
        COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY gender, SeniorCitizen, Partner, Dependents
)
SELECT gender, SeniorCitizen, Partner, Dependents, TotalCustomers, ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS churn_Rate
FROM DemographicChurn
ORDER BY gender, SeniorCitizen, Partner, Dependents;

-- Churn rate by gender 
WITH GenderChurn AS (
    SELECT gender, COUNT(*) AS TotalCustomers, SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY gender
)
SELECT gender, TotalCustomers, ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS ChurnRate
FROM GenderChurn
ORDER BY gender;

-- Churn Rate by Phone service 

WITH PhoneServiceChurn AS (
    SELECT 
        PhoneService,
        COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY PhoneService
)
SELECT 
    PhoneService,
    TotalCustomers,
    ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS ChurnRate
    FROM 
    PhoneServiceChurn
ORDER BY 
    ChurnRate DESC;

-- Churn rate by Internet service 

WITH InternetServiceChurn AS (
    SELECT 
        InternetService,
        COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY InternetService
)
SELECT 
    InternetService,
    TotalCustomers,
    ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS ChurnRate
FROM InternetServiceChurn
ORDER BY ChurnRate DESC;

-- Combined 
WITH PhoneServiceChurn AS (
    SELECT 'PhoneService' AS ServiceType, PhoneService AS Service,COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY PhoneService
),
InternetServiceChurn AS (
    SELECT 'InternetService' AS ServiceType , InternetService AS Service, COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
    FROM customer_churn
    GROUP BY InternetService
)
SELECT ServiceType, Service, TotalCustomers, ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS ChurnRate
FROM PhoneServiceChurn
UNION ALL
SELECT ServiceType, Service, TotalCustomers, ChurnedCustomers,
    (ChurnedCustomers * 1.0 / TotalCustomers) AS ChurnRate
FROM InternetServiceChurn
ORDER BY ChurnRate DESC;
    
-- Average Tenure of Churned vs. Non-churned customers 

SELECT Churn, AVG(tenure) AS AverageTenure
FROM customer_churn
GROUP BY Churn;




