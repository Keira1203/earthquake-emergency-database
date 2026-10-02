UPDATE FEMA_Registration
SET
    county = UPPER(TRIM(county)),
    city = UPPER(TRIM(city)),
    state = UPPER(TRIM(state));

UPDATE FEMA_Registration
SET county = UPPER(TRIM(SUBSTRING_INDEX(county, ' (', 1)))
WHERE county LIKE '% (%';


-- checks whether any county names still contains brackets
SELECT county
FROM FEMA_Registration
WHERE county LIKE '%(%'
LIMIT 20;

-- checking state formatting
SELECT DISTINCT state
FROM FEMA_Registration
ORDER BY state;

-- checking missing important values
SELECT
    SUM(state IS NULL OR state = '') AS missing_state,
    SUM(county IS NULL OR county = '') AS missing_county,
    SUM(city IS NULL OR city = '') AS missing_city,
    SUM(total_valid_registrations IS NULL) AS missing_registrations,
    SUM(ihp_amount IS NULL) AS missing_ihp_amount
FROM FEMA_Registration;
