CREATE DATABASE ehotels;

-- Create HotelChain table
CREATE TABLE HotelChain (
    central_office_address VARCHAR(255) NOT NULL,
    email_address VARCHAR(255),
    chain_phone_number VARCHAR(20),
    number_of_hotels INT CHECK (number_of_hotels >= 0),
    PRIMARY KEY (central_office_address)
);

-- Create Hotel table
CREATE TABLE Hotel (
    hotel_address VARCHAR(255) NOT NULL,
    central_office_address VARCHAR(255) NOT NULL,
    star_rating INT CHECK (star_rating >= 0 AND star_rating <= 5),
    hotel_phone_numbers VARCHAR(255),
    hotel_email VARCHAR(255),
    PRIMARY KEY (hotel_address),
    FOREIGN KEY (central_office_address) REFERENCES HotelChain(central_office_address) ON DELETE CASCADE
);

-- Create Customer table
CREATE TABLE Customer (
    customer_ssn VARCHAR(20) NOT NULL,
    register_date DATE,
    customer_full_name VARCHAR(255),
    customer_address VARCHAR(255),
    PRIMARY KEY (customer_ssn)
);

-- Create Room table
CREATE TABLE Room (
    room_number INT NOT NULL,
    hotel_address VARCHAR(255) NOT NULL,
    capacity INT CHECK (capacity >= 0),
    view VARCHAR(50),
    price DECIMAL(10, 2) CHECK (price >= 0),
    amenities VARCHAR(255),
    defects VARCHAR(255),
    extendability BOOLEAN,
    PRIMARY KEY (room_number, hotel_address),
    FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE
);

-- Create Employee table
CREATE TABLE Employee (
    employee_ssn VARCHAR(20) NOT NULL,
    hotel_address VARCHAR(255) NOT NULL,
    employee_full_name VARCHAR(255),
    employee_address VARCHAR(255),
    PRIMARY KEY (employee_ssn),
    FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE
);

-- Create Archive table
CREATE TABLE Archive (
    id SERIAL PRIMARY KEY,
    information TEXT
);

-- Add constraint: FK is either NULL or matches a PK
ALTER TABLE Room
ADD CONSTRAINT fk_hotel_address_null FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE;

-- Add constraint: No hotel-room.hotel-address has a NULL value
ALTER TABLE Room
ALTER COLUMN hotel_address SET NOT NULL;


-- Add constraint: No hotel-chain.Central-Office-Address has a NULL value
ALTER TABLE HotelChain
ALTER COLUMN central_office_address SET NOT NULL;

