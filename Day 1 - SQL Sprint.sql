create database complaint_analysis;

USE complaint_analysis;

CREATE TABLE complaints (
    complaint_id INT PRIMARY KEY,
    device_name VARCHAR(100),
    product_category VARCHAR(100),
    region VARCHAR(50),
    complaint_date DATE,
    imdrf_code VARCHAR(20),
    root_cause VARCHAR(255),
    closure_days INT,
    reportable VARCHAR(10)
);

INSERT INTO complaints VALUES
(1, 'Infusion Pump', 'Pump', 'US', '2025-01-10', 'A100', 'Battery Failure', 12, 'Yes'),
(2, 'ECG Monitor', 'Monitor', 'India', '2025-01-15', 'E200', NULL, 8, 'No'),
(3, 'Ventilator', 'Respiratory', 'Germany', '2025-02-01', 'F300', 'Software Bug', 15, 'Yes'),
(4, 'Infusion Pump', 'Pump', 'US', '2025-02-18', 'A100', 'User Error', 6, 'No'),
(5, 'Defibrillator', 'Cardiac', 'UK', '2025-03-02', 'E200', 'Electrical Issue', 20, 'Yes'),
(6, 'Ventilator', 'Respiratory', 'India', '2025-03-10', 'F300', NULL, 11, 'No');

select * from complaints;

# 1) Query 1 — Top IMDRF Codes

select imdrf_code,
count(*) as Total_Complaints
from complaints
group by imdrf_code
order by Total_Complaints desc;

# 2) Query 2 — Region Wise Complaint Count

select region,
count(*) as complaint_count
from complaints
group by region;

# 3) Query 3 — MDR Reportable Ratio
SELECT 
    reportable,
    COUNT(*) AS total
FROM complaints
GROUP BY reportable;

# 4) Query 4 — Average Closure Time
SELECT 
    product_category,
    AVG(closure_days) AS avg_closure_time
FROM complaints
GROUP BY product_category;

# 5) Query 5 — Complaints With No Root Cause

SELECT *
FROM complaints
WHERE root_cause IS NULL;


# 6) - 

SELECT
    complaint_id,
    device_name,
    closure_days,
    ROW_NUMBER() OVER(
        PARTITION BY device_name
        ORDER BY closure_days DESC
    ) AS row_num
FROM complaints;
