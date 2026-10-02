USE disaster_management;
SELECT DATABASE();

-- =========================================================
-- Basic operations on Person
-- Week 5 changes:
-- - removed CREATE DATABASE (the database is already created before schema.sql)
-- - moved SELECT after INSERT so it actually shows the new row
-- - used a fictional name and an id that is not used by the mock data
-- - DELETE by person_id instead of name (names are not unique)
-- =========================================================

-- INSERT
INSERT INTO Person (
    person_id,
    name,
    phone_number,
    emergency_contact,
    address,
    has_children,
    marital_status,
    distance_from_incident
)
VALUES (
    999001,
    'Test Person',
    '+32470000000',
    'mother',
    'Kerkstraat 1, 3500 Hasselt',
    TRUE,
    'Single',
    10
);

-- SELECT
SELECT * FROM Person WHERE person_id = 999001;

-- UPDATE
UPDATE Person
SET distance_from_incident = 20
WHERE person_id = 999001;

SELECT * FROM Person WHERE person_id = 999001;

-- DELETE
DELETE FROM Person WHERE person_id = 999001;


-- =========================================================
-- Data checks (Week 5)
-- Run these first to see if the real data was loaded correctly
-- =========================================================

-- Number of rows in each table
-- Expected: about 5,411 hospitals (5,419 in the CSV) and 225,352 FEMA rows
SELECT COUNT(*) AS hospitals FROM Hospital;
SELECT COUNT(*) AS fema_rows FROM FEMA_Registration;

-- Hospitals without a rating ('Not Available' in the CSV, should be NULL now)
-- Expected: about 2,245
SELECT COUNT(*) AS hospitals_without_rating
FROM Hospital
WHERE overall_rating IS NULL;


-- =========================================================
-- Advanced queries
-- =========================================================

-- Query 1: Hospitals with emergency services per state
-- Week 5: rewritten. The original query calculated free beds, but the
-- real hospital data (CMS) has no bed counts, so the result was meaningless.
-- Now the query uses emergency services and rating, which the data does have.
SELECT
    state,
    COUNT(*) AS er_hospitals,
    AVG(overall_rating) AS avg_rating
FROM Hospital
WHERE emergency_services = TRUE
GROUP BY state
ORDER BY er_hospitals ASC;


-- Query 2: Patient medication and allergy details
-- Week 5: added the hospital name
SELECT
    pr.record_id,
    p.name AS patient_name,
    p.phone_number,
    p.emergency_contact,
    h.name AS hospital_name,
    pr.medical_condition,
    pr.admission_date,
    GROUP_CONCAT(DISTINCT pm.medication_name SEPARATOR ', ') AS medications,
    GROUP_CONCAT(DISTINCT pa.allergy_name SEPARATOR ', ') AS allergies
FROM Person p
JOIN Patient_Record pr ON p.person_id = pr.person_id
LEFT JOIN Hospital h ON pr.hospital_id = h.hospital_id
LEFT JOIN Patient_Medication pm ON pr.record_id = pm.record_id
LEFT JOIN Patient_Allergy pa ON pr.record_id = pa.record_id
GROUP BY pr.record_id, p.name, p.phone_number, p.emergency_contact,
         h.name, pr.medical_condition, pr.admission_date
ORDER BY pr.admission_date DESC;


-- Query 3: Supply inventory status
-- Week 5: no changes (uses mock data only)
SELECT
    s.supply_id,
    s.supply_name,
    s.quantity_left AS current_stock,
    COALESCE(SUM(so.quantity), 0) AS total_requested_quantity,
    COUNT(so.order_id) AS total_orders
FROM Supplies s
LEFT JOIN Supply_Order so ON s.supply_id = so.supply_id
GROUP BY s.supply_id, s.supply_name, s.quantity_left
ORDER BY current_stock ASC;


-- Query 4: Hospitals with emergency services in earthquake areas
-- Week 5: new query that combines both real datasets.
-- For every hospital in an area hit by an earthquake, it shows how many
-- people in that county registered for FEMA aid.
-- The FEMA dataset has no disaster type, so we filter on the disaster numbers
-- of the earthquakes in the data (checked on fema.gov):
--   4193 = South Napa earthquake (California, 2014)
--   4413 = Alaska earthquake (2018)
--   4473 = Puerto Rico earthquakes (2020)
SELECT
    h.name AS hospital_name,
    h.state,
    h.county,
    SUM(f.total_valid_registrations) AS registrations_in_county
FROM Hospital h
JOIN FEMA_Registration f
    ON h.state = f.state
   AND h.county = f.county
WHERE f.disaster_number IN (4193, 4413, 4473)
  AND h.emergency_services = TRUE
GROUP BY h.hospital_id, h.name, h.state, h.county
ORDER BY registrations_in_county DESC;