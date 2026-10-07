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
