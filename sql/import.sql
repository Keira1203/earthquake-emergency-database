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

INSERT IGNORE INTO Hospital (
    hospital_id,
    name,
    location,
    state,
    county,
    emergency_services,
    overall_rating,
    available_capacity
)
SELECT
    TRIM(REPLACE(facility_id, '\r', '')),
    TRIM(facility_name),
    CONCAT_WS(', ',
              TRIM(address),
              TRIM(city_town),
              TRIM(state),
              TRIM(zip_code)
    ),
    TRIM(state),
    TRIM(county_parish),

    CASE
        WHEN UPPER(TRIM(emergency_services)) = 'YES' THEN TRUE
        WHEN UPPER(TRIM(emergency_services)) = 'NO' THEN FALSE
        ELSE NULL
        END,

    CASE
        WHEN TRIM(overall_rating) = 'Not Available'
            OR TRIM(overall_rating) = ''
            THEN NULL
        ELSE CAST(TRIM(overall_rating) AS UNSIGNED)
        END,

    0
FROM HospitalTemp
WHERE TRIM(REPLACE(facility_id, '\r', '')) <> '';

DROP TEMPORARY TABLE HospitalTemp;

DROP TEMPORARY TABLE IF EXISTS SuppliesTemp;
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


INSERT IGNORE INTO FEMA_Registration (
    fema_id,
    disaster_number,
    state,
    county,
    city,
    zip_code,
    total_valid_registrations,
    ihp_amount
)
SELECT
    TRIM(REPLACE(fema_id, '\r', '')),
    CAST(disaster_number AS UNSIGNED),
    TRIM(state),
    TRIM(county),
    TRIM(city),
    TRIM(zip_code),
    CAST(total_valid_registrations AS UNSIGNED),
    CAST(ihp_amount AS DECIMAL(15,2))
FROM SuppliesTemp
WHERE TRIM(REPLACE(fema_id, '\r', '')) <> '';

DROP TEMPORARY TABLE SuppliesTemp;