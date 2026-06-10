SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT *
FROM patient_info
LIMIT 3;

SELECT *
FROM lesion_info
LIMIT 3;


SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT
    p.patient_id,
    p.age,
    p.gender,
    p.smoke,
    p.drink,
    l.lesion_id,
    l.region,
    l.diagnostic
FROM patient_info p
JOIN lesion_info l
ON p.patient_id = l.patient_id
LIMIT 20;

--- Which skin lesion type occurs most frequently?
SELECT diagnostic,
       COUNT(*) AS total_cases
FROM lesion_info
GROUP BY diagnostic
ORDER BY total_cases DESC;

-- Are certain lesions more common in males or females?
SELECT p.gender,
       l.diagnostic,
       COUNT(*) AS total_cases
FROM patient_info p
JOIN lesion_info l
ON p.patient_id = l.patient_id
GROUP BY p.gender, l.diagnostic
ORDER BY total_cases DESC;

SELECT l.diagnostic,
       ROUND(AVG(p.age),2) AS average_age
FROM patient_info p
JOIN lesion_info l
ON p.patient_id = l.patient_id
GROUP BY l.diagnostic
ORDER BY average_age DESC;

-- Which diagnoses turn to occur in older patient?
SELECT l.diagnostic,
       ROUND(AVG(p.age),2) AS average_age
FROM patient_info p
JOIN lesion_info l
ON p.patient_id = l.patient_id
GROUP BY l.diagnostic
ORDER BY average_age DESC;

-- Is there any visible relationship between smoking and lesion type?
SELECT p.smoke,
       l.diagnostic,
       COUNT(*) AS total_cases
FROM patient_info p
JOIN lesion_info l
ON p.patient_id = l.patient_id
GROUP BY p.smoke, l.diagnostic
ORDER BY total_cases DESC;

-- Do patient's exposed to pesticide show different lesion patterns?
SELECT p.pesticide,
       l.diagnostic,
       COUNT(*) AS total_cases
FROM patient_info p
JOIN lesion_info l
ON p.patient_id = l.patient_id
GROUP BY p.pesticide, l.diagnostic
ORDER BY total_cases DESC;

-- Which body areas are most affected?
SELECT region,
       COUNT(*) AS total_cases
FROM lesion_info
GROUP BY region
ORDER BY total_cases DESC;

-- Which lesion types tends to be larger?
SELECT diagnostic,
       ROUND(
           AVG((diameter_1 + diameter_2)/2)::numeric,
           2
       ) AS avg_lesion_size
FROM lesion_info
GROUP BY diagnostic
ORDER BY avg_lesion_size DESC;

-- How many lesions were biopsy confirmed?
SELECT biopsed,
       COUNT(*) AS total_cases
FROM lesion_info
GROUP BY biopsed;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'lesion_info';

--- New table created for machine learning.
CREATE TABLE ml_dataset AS
SELECT
    p.patient_id,
    p.age,
    p.gender,
    p.smoke,
    p.pesticide,
    l.diagnostic,
    l.region,
    ROUND(((l.diameter_1 + l.diameter_2)/2)::numeric,2) AS lesion_size,
    l.biopsed

FROM patient_info p

JOIN lesion_info l
ON p.patient_id = l.patient_id;

--- New Table verification
SELECT *
FROM ml_dataset
LIMIT 10;

