UPDATE FEMA_Registration
SET county = TRIM(county),
    city = TRIM(city),
    state = TRIM(state);

-- Take away the brackets and what is inside them
UPDATE FEMA_Registration
SET county = TRIM(REGEXP_REPLACE(county, '\\s*\\([^)]*\\)', ''))
WHERE county LIKE '%(%';
