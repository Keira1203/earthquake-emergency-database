-- Insert mock data
USE disaster_management;

SELECT * FROM Person;
SELECT * FROM Patient_Record;

INSERT INTO Person(
    person_id,
    name,
    phone_number,
    emergency_contact,
    address,
    has_children,
    marital_status,
    distance_from_incident
)
VALUES
    (1,'Anna de Vries','+31612345671','Mark de Vries','Maastricht',TRUE,'Married',3),
    (2,'Lucas Janssen','+31612345672','Emma Janssen','Valkenburg',FALSE,'Single',8),
    (3,'Sofia Peters','+31612345673','Daniel Peters','Heerlen',TRUE,'Married',12),
    (4, 'Noah Smit', '+31612345674', 'Lisa Smit', 'Meerssen', FALSE, 'Single', 5),
    (5, 'Mila Bakker', '+31612345675', 'Tom Bakker', 'Gulpen', TRUE, 'Divorced', 15
    );

INSERT INTO Hospital (
    hospital_id,
    name,
    location,
    available_capacity
)
VALUES
    (1, 'Maastricht Medical Center', 'Maastricht', 120),
    (2, 'Heerlen General Hospital', 'Heerlen', 80),
    (3, 'Valkenburg Emergency Center', 'Valkenburg', 40);

INSERT INTO Supplies (
    supply_id,
    supply_name,
    quantity_left
)
VALUES
    (1, 'Drinking Water', 500),
    (2, 'Food Packages', 300),
    (3, 'Blankets', 200),
    (4, 'First Aid Kits', 100),
    (5, 'Flashlights', 150);

INSERT INTO Patient_Record (
    record_id,
    person_id,
    hospital_id,
    admission_date,
    discharge_date,
    medical_condition
)
VALUES
    (101, 1, 1, '2026-09-15 09:30:00', '2026-09-16 14:00:00', 'Minor fracture'),
    (102, 2, 3, '2026-09-15 11:00:00', NULL, 'Smoke inhalation'),
    (103, 3, 2, '2026-09-16 08:45:00', NULL, 'Head injury'),
    (104, 4, 1, '2026-09-16 12:20:00', '2026-09-17 10:00:00', 'Dehydration'),
    (105, 5, 2, '2026-09-17 07:15:00', NULL, 'Leg injury');

INSERT INTO Patient_Medication (
    medication_id,
    record_id,
    medication_name
)
VALUES
    (1, 101, 'Ibuprofen'),
    (2, 101, 'Paracetamol'),
    (3, 102, 'Salbutamol'),
    (4, 103, 'Paracetamol'),
    (5, 104, 'Electrolyte'),
    (6, 105, 'Ibuprofen');

INSERT INTO Patient_Allergy (
    allergy_id,
    record_id,
    allergy_name
)
VALUES
    (1, 101, 'Penicillin'),
    (2, 102, 'Pollen'),
    (3, 103, 'Peanuts'),
    (4, 104, 'Dust'),
    (5, 105, 'Latex');

INSERT INTO Safety_Update (
    update_id,
    person_id,
    status,
    electricity,
    gas,
    clean_water,
    timestamp
)
VALUES
    (1, 1, 'Safe', TRUE, TRUE, TRUE, '2026-09-15 08:00:00'),
    (2, 2, 'Needs assistance', FALSE, FALSE, FALSE, '2026-09-15 08:30:00'),
    (3, 3, 'Relocated', FALSE, FALSE, TRUE, '2026-09-15 09:00:00'),
    (4, 4, 'Safe', TRUE, FALSE, TRUE, '2026-09-15 09:30:00'),
    (5, 5, 'Needs shelter', FALSE, FALSE, FALSE, '2026-09-15 10:00:00'),
    (6, 2, 'Relocated', FALSE, FALSE, TRUE, '2026-09-16 10:30:00');

INSERT INTO Supply_Order (
    order_id,
    person_id,
    supply_id,
    quantity,
    order_time,
    status
)
VALUES
    (1, 1, 1, 5, '2026-09-15 10:00:00', 'Completed'),
    (2, 2, 2, 3, '2026-09-15 10:15:00', 'Pending'),
    (3, 2, 3, 2, '2026-09-15 10:20:00', 'Completed'),
    (4, 3, 4, 1, '2026-09-15 11:00:00', 'Completed'),
    (5, 4, 1, 4, '2026-09-16 09:00:00', 'Pending'),
    (6, 5, 3, 3, '2026-09-16 09:30:00', 'Processing');