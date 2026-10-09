-- Author: Keira
-- Query 1: The top 10 ranking of hospitals with more beds
-- Question:
-- Where to transfer patients in case of an emergency? Which hospitals have the most beds available?
-- Social Relevance:
-- In case of a mass casualty event following a severe earthquake, emergency responders 
-- need instant visibility into hospital capacity to route patients efficiently and 
-- prevent regional healthcare facilities from becoming overwhelmed.
SELECT hospital_id, name, available_capacity AS available_beds
FROM Hospital
ORDER BY available_capacity DESC
LIMIT 10;

-- Query 2:The top 10 ranking of the most disaster affected areas
-- Question:
-- Which areas are most affected by disasters? Where should we focus our efforts?
-- Societal Relevance:
-- Identifying geographical hotspots with the highest concentration of affected individuals 
-- enables emergency management authorities (e.g., FEMA) to prioritize the deployment of 
-- rescue teams, food supplies, and temporary shelters to critical zones first.
SELECT address, COUNT(*) AS affected_people
FROM Person
GROUP BY address
ORDER BY affected_people DESC
LIMIT 10;


-- Author: Nicoleta Mihailov

-- Query 3: Most requested supplies
-- Question:
--    Which types of supplies are requested in the highest quantities?

-- Societal Relevance:
--    This helps emergency organizations understand which resources are needed most
--   and prioritize their supply distribution.

SELECT
    s.supply_name,
    SUM(so.quantity) AS total_requested
FROM Supplies s
         JOIN Supply_Order so ON s.supply_id = so.supply_id
GROUP BY s.supply_id, s.supply_name
ORDER BY total_requested DESC;


-- Query 4: Hospitals with emergency services in affected states
-- Question:
--    Which hospitals provide emergency services in states affected by earthquakes?
-- Societal Relevance:
--    This helps responders identify hospitals that can receive patients during an emergency.

SELECT
    name,
    state,
    county,
    overall_rating
FROM Hospital
WHERE emergency_services = TRUE
  AND state IN ('CA', 'AK', 'PR')
ORDER BY overall_rating DESC;

-- Author: Alisa Januska

-- Query 5: Emergency hospital capacity per state
-- Question:
--    How many emergency hospitals and available beds does each state have?
-- Societal Relevance:
--    After a major earthquake, authorities need to know which states can absorb
--    large numbers of injured people and which states will need to transfer
--    patients elsewhere. This supports regional coordination of patient flows
--    and helps prevent local hospitals from being overwhelmed.

SELECT
    state,
    COUNT(*)                AS emergency_hospitals,
    SUM(available_capacity) AS total_available_beds
FROM Hospital
WHERE emergency_services = TRUE
GROUP BY state
HAVING COUNT(*) > 0
ORDER BY total_available_beds DESC;


-- Query 6: Emergency hospitals with above-average free capacity
-- Question:
--    Which hospitals with emergency services have more available beds than
--    the average hospital, and how are they rated?
-- Societal Relevance:
--    Sending patients to hospitals that are already near full capacity delays
--    treatment. This query identifies the best-prepared hospitals (emergency
--    services + above-average capacity), so responders can direct ambulances
--    to facilities where patients will receive care fastest.

SELECT
    hospital_id,
    name,
    state,
    county,
    available_capacity AS available_beds,
    overall_rating
FROM Hospital
WHERE emergency_services = TRUE
  AND available_capacity > (SELECT AVG(available_capacity) FROM Hospital)
ORDER BY available_capacity DESC, overall_rating DESC;


-- Author: Iyem Pelzer

-- Query 7: Which locations have the highest number of supplies requested and how many supplies?
-- Question:
--      Where is the highest number of requests for supplies?
-- Societal Relevance:
--      Knowing which areas have the highest demand for supplies allows emergency management 
--      authorities to optimize deliveries to those areas by sending bigger shipments at ones.

SELECT Person.address AS location,
    COUNT(Supply_Order.order_id) AS total_orders,
    SUM(Supply_Order.quantity) AS total_quantity_requested
FROM Person 
JOIN Supply_Order 
    ON Person.person_id = Supply_Order.person_id
WHERE Supply_Order.status = 'Pending'
GROUP BY Person.address
ORDER BY total_quantity_requested DESC
LIMIT 10; 

-- Query 8: Affected families with children
-- Question:
--     Which locations have the most affected people with children?
-- Societal Relevance:
--     Gives priority to families with children so emergency management authorities 
--     can send resources with special aid to those areas first.

SELECT address,
    COUNT(*) AS affected_with_children
FROM Person
WHERE has_children = TRUE
GROUP BY address
ORDER BY affected_with_children DESC
LIMIT 10;