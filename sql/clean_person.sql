UPDATE person
SET name = TRIM(name),
    phone_number = TRIM(phone_number),
    emergency_contact = TRIM(emergency_contact),
    address = TRIM(address),
    marital_status = TRIM(marital_status);

UPDATE person
SET marital_status = 'Unknown'
WHERE marital_status IS NULL OR marital_status = '';

UPDATE person
SET emergency_contact = 'none specified'
WHERE emergency_contact IS NULL OR emergency_contact = '';

