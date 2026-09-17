-- Create tables
-- Primary keys
-- Foreign keys
-- Constraints
-- Data types

CREATE TABLE Person (
    person_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(100),
    emergency_contact VARCHAR(100),
    address VARCHAR(200),
    has_children BOOLEAN,
    marital_status VARCHAR(100),
    distance_from_incident INT
);


CREATE TABLE Hospital (
    hospital_id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(200),
    available_capacity INT
);


CREATE TABLE Supplies (
    supply_id INT PRIMARY KEY,
    supply_name VARCHAR(100),
    quantity_left INT
);


CREATE TABLE Patient_Record (
    record_id INT PRIMARY KEY,
    person_id INT,
    hospital_id INT,
    admission_date DATETIME,
    discharge_date DATETIME,
    medical_condition VARCHAR(100),

    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);


CREATE TABLE Patient_Medication (
    medication_id INT PRIMARY KEY,
    record_id INT,
    medication_name VARCHAR(100),

    FOREIGN KEY (record_id) REFERENCES Patient_Record(record_id)
);


CREATE TABLE Patient_Allergy (
    allergy_id INT PRIMARY KEY,
    record_id INT,
    allergy_name VARCHAR(100),

    FOREIGN KEY (record_id) REFERENCES Patient_Record(record_id)
);


CREATE TABLE Safety_Update (
    update_id INT PRIMARY KEY,
    person_id INT,
    status VARCHAR(100),
    electricity BOOLEAN,
    gas BOOLEAN,
    clean_water BOOLEAN,
    timestamp DATETIME,

    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);


CREATE TABLE Supply_Order (
    order_id INT PRIMARY KEY,
    person_id INT,
    supply_id INT,
    quantity INT,
    order_time DATETIME,
    status VARCHAR(100),

    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (supply_id) REFERENCES Supplies(supply_id)
);