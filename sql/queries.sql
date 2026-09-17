-- SELECT
-- INSERT
-- UPDATE
-- DELETE

-- Advanced queries
-- Query 1: Hospital occupation and available capacity analysis
SELECT 
    h.hospital_id,
    h.name AS hospital_name,
    h.location,
    h.available_capacity AS max_capacity,
    COUNT(pr.record_id) AS current_patients,
    (h.available_capacity - COUNT(pr.record_id)) AS available_beds
FROM Hospital h
LEFT JOIN Patient_Record pr ON h.hospital_id = pr.hospital_id
GROUP BY h.hospital_id, h.name, h.location, h.available_capacity
ORDER BY available_beds DESC;

-- Query 2: Patient medication and allergy details
SELECT 
    pr.record_id,
    p.name AS patient_name,
    p.phone_number,
    p.emergency_contact,
    pr.medical_condition,
    pr.admission_date,
    GROUP_CONCAT(DISTINCT pm.medication_name SEPARATOR ', ') AS medications,
    GROUP_CONCAT(DISTINCT pa.allergy_name SEPARATOR ', ') AS allergies
FROM Person p
JOIN Patient_Record pr ON p.person_id = pr.person_id
LEFT JOIN Patient_Medication pm ON pr.record_id = pm.record_id
LEFT JOIN Patient_Allergy pa ON pr.record_id = pa.record_id
GROUP BY p.person_id, pr.record_id, p.name, p.phone_number, p.emergency_contact, pr.medical_condition, pr.admission_date
ORDER BY pr.admission_date DESC;

-- Query 3: Supply inventory status
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