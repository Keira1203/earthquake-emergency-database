


UPDATE Hospital
SET
    name = TRIM(name),
    location = TRIM(location),
    state = UPPER(TRIM(state)),
    county = TRIM(county);

-- converting empty text values to NULL

UPDATE Hospital
SET
    name = NULLIF(TRIM(name), ''),
    location = NULLIF(TRIM(location), ''),
    state = NULLIF(UPPER(TRIM(state)), ''),
    county = NULLIF(TRIM(county), '');

-- Clean emergency services values
-- Keep only TRUE, FALSE, or NULL

UPDATE Hospital
SET emergency_services = NULL
WHERE emergency_services NOT IN (TRUE, FALSE)
  AND emergency_services IS NOT NULL;




UPDATE Hospital
SET overall_rating = NULL
WHERE overall_rating NOT BETWEEN 1 AND 5
  AND overall_rating IS NOT NULL;

-- checks for duplicate hospital ids

SELECT
    hospital_id,
    COUNT(*) AS duplicate_count
FROM Hospital
GROUP BY hospital_id
HAVING COUNT(*) > 1;

-- Check state values
SELECT DISTINCT state
FROM Hospital
ORDER BY state;

-- Check county values
SELECT DISTINCT county
FROM Hospital
WHERE county IS NOT NULL
ORDER BY county;



SELECT
    SUM(name IS NULL) AS missing_name,
    SUM(location IS NULL) AS missing_location,
    SUM(state IS NULL) AS missing_state,
    SUM(county IS NULL) AS missing_county,
    SUM(emergency_services IS NULL) AS missing_emergency_services,
    SUM(overall_rating IS NULL) AS missing_overall_rating
FROM Hospital;
