SET GLOBAL local_infile = 1;

-- Hospital data
CREATE TEMPORARY TABLE HospitalTemp (
    facility_id VARCHAR(255),
    facility_name VARCHAR(255),
    address VARCHAR(255),
    city_town VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(255),
    county_parish VARCHAR(255),
    telephone_number VARCHAR(255),
    hospital_type VARCHAR(255),
    hospital_ownership VARCHAR(255),
    emergency_services VARCHAR(255),
    birthing_friendly VARCHAR(255),
    overall_rating VARCHAR(255),
    overall_rating_footnote VARCHAR(255),
    mort_group_count VARCHAR(255),
    facility_mort_count VARCHAR(255),
    mort_better VARCHAR(255),
    mort_no_different VARCHAR(255),
    mort_worse VARCHAR(255),
    mort_footnote VARCHAR(255),
    safety_group_count VARCHAR(255),
    facility_safety_count VARCHAR(255),
    safety_better VARCHAR(255),
    safety_no_different VARCHAR(255),
    safety_worse VARCHAR(255),
    safety_footnote VARCHAR(255),
    readm_group_count VARCHAR(255),
    facility_readm_count VARCHAR(255),
    readm_better VARCHAR(255),
    readm_no_different VARCHAR(255),
    readm_worse VARCHAR(255),
    readm_footnote VARCHAR(255),
    ptexp_group_count VARCHAR(255),
    facility_ptexp_count VARCHAR(255),
    ptexp_footnote VARCHAR(255),
    te_group_count VARCHAR(255),
    facility_te_count VARCHAR(255),
    te_footnote VARCHAR(255)
);

LOAD DATA LOCAL INFILE 'data/Hospital_General_Information.csv'
INTO TABLE HospitalTemp
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

INSERT IGNORE INTO Hospital (hospital_id, name, location, available_capacity)
SELECT 
    CAST(NULLIF(REGEXP_REPLACE(REPLACE(facility_id, '\r', ''), '[^0-9]', ''), '') AS UNSIGNED),
    facility_name,
    CONCAT_WS(', ', address, city_town, state, zip_code),
    0
FROM HospitalTemp
WHERE NULLIF(REGEXP_REPLACE(REPLACE(facility_id, '\r', ''), '[^0-9]', ''), '') IS NOT NULL;

DROP TEMPORARY TABLE HospitalTemp;

CREATE TEMPORARY TABLE SuppliesTemp (
    disaster_number VARCHAR(255),
    state VARCHAR(255),
    county VARCHAR(255),
    city VARCHAR(255),
    zip_code VARCHAR(255),
    total_valid_registrations VARCHAR(255),
    valid_call_center_registrations VARCHAR(255),
    valid_web_registrations VARCHAR(255),
    valid_mobile_registrations VARCHAR(255),
    ihp_referrals VARCHAR(255),
    ihp_eligible VARCHAR(255),
    ihp_amount VARCHAR(255),
    ha_referrals VARCHAR(255),
    ha_eligible VARCHAR(255),
    ha_amount VARCHAR(255),
    ona_referrals VARCHAR(255),
    ona_eligible VARCHAR(255),
    ona_amount VARCHAR(255),
    fema_id VARCHAR(255)
);

LOAD DATA LOCAL INFILE 'data/RegistrationIntakeIndividualsHouseholdPrograms.csv'
INTO TABLE SuppliesTemp
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SET @row_num = 0;

INSERT IGNORE INTO Person (person_id, name, phone_number, emergency_contact, address, has_children, marital_status, distance_from_incident)
SELECT 
    (@row_num := @row_num + 1) AS person_id,
    CONCAT('Applicant_', REPLACE(fema_id, '\r', '')),
    NULL,
    NULL,
    CONCAT_WS(', ', city, county, state, zip_code),
    NULL,
    NULL,
    NULL
FROM SuppliesTemp;

DROP TEMPORARY TABLE SuppliesTemp;