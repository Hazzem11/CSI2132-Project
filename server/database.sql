CREATE DATABASE ehotels;

-- HotelChain table
CREATE TABLE HotelChain (
    central_office_address VARCHAR(255) NOT NULL,
    email_address VARCHAR(255),
    number_of_hotels INT CHECK (number_of_hotels >= 0),
    PRIMARY KEY (central_office_address)
);

-- Hotel table
CREATE TABLE Hotel (
    hotel_address VARCHAR(255) NOT NULL,
    central_office_address VARCHAR(255) NOT NULL,
    star_rating INT CHECK (star_rating >= 0 AND star_rating <= 5),
    hotel_email VARCHAR(255),
    PRIMARY KEY (hotel_address),
    FOREIGN KEY (central_office_address) REFERENCES HotelChain(central_office_address) ON DELETE CASCADE
);

-- Customer table
CREATE TABLE Customer (
    customer_ssn VARCHAR(20) NOT NULL,
    register_date DATE,
    customer_full_name VARCHAR(255),
    customer_address VARCHAR(255),
    payed_in_advance BOOLEAN
    PRIMARY KEY (customer_ssn)
);

-- Room table
CREATE TABLE Room (
    room_number INT NOT NULL,
    hotel_address VARCHAR(255) NOT NULL,
    capacity INT CHECK (capacity >= 0),
    view VARCHAR(50),
    price DECIMAL(10, 2) CHECK (price >= 0),
    extendability BOOLEAN,
    booking_start_date DATE,
    booking_end_date DATE,
    room_status VARCHAR(50),
    PRIMARY KEY (room_number, hotel_address),
    FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE
);

-- Employee table
CREATE TABLE Employee (
    employee_ssn VARCHAR(20) NOT NULL,
    hotel_address VARCHAR(255) NOT NULL,
    employee_full_name VARCHAR(255),
    employee_address VARCHAR(255),
    PRIMARY KEY (employee_ssn),
    FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE
);

-- Archive table
CREATE TABLE Archive (
    id SERIAL PRIMARY KEY,
    information TEXT
);

-- HotelPhoneNumber table (Multi-valued attribute)
CREATE TABLE HotelPhoneNumber (
    hotel_address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (hotel_address, phone_number),
    FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE
);

-- ChainPhoneNumber table (Multi-valued attribute)
CREATE TABLE ChainPhoneNumber (
    central_office_address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (central_office_address, phone_number),
    FOREIGN KEY (central_office_address) REFERENCES HotelChain(central_office_address) ON DELETE CASCADE
);

-- Defect table (Multi-valued attribute)
CREATE TABLE Defect (
    room_number INT NOT NULL,
    hotel_address VARCHAR(255) NOT NULL,
    defect_description TEXT,
    PRIMARY KEY (room_number),
    FOREIGN KEY (room_number) REFERENCES Room(room_number) ON DELETE CASCADE
);

-- Amenity table (Multi-valued attribute)
CREATE TABLE Amenity (
    amenity_id SERIAL PRIMARY KEY,
    amenity_name VARCHAR(255) NOT NULL
);

-- RoomAmenity junction table to manage the many-to-many relationship between Room and Amenity
CREATE TABLE RoomAmenity (
    room_number INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (room_number, amenity_id),
    FOREIGN KEY (room_number) REFERENCES Room(room_number) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES Amenity(amenity_id) ON DELETE CASCADE
);

-- Booking table (relationship)
CREATE TABLE Booking (
    customer_ssn VARCHAR(20) NOT NULL,
    room_number INT NOT NULL,
    PRIMARY KEY (customer_ssn, room_number),
    FOREIGN KEY (customer_ssn) REFERENCES Customer(customer_ssn) ON DELETE CASCADE,
    FOREIGN KEY (room_number) REFERENCES Room(room_number) ON DELETE CASCADE
);

--Renting table (relationship)
CREATE TABLE Renting (
    room_number INT NOT NULL,
    customer_ssn VARCHAR(20) NOT NULL,
    employee_ssn VARCHAR(20) NOT NULL,
    PRIMARY KEY (room_number, customer_ssn),
    FOREIGN KEY (room_number) REFERENCES Room(room_number) ON DELETE CASCADE,
    FOREIGN KEY (customer_ssn) REFERENCES Customer(customer_ssn) ON DELETE CASCADE,
    FOREIGN KEY (employee_ssn) REFERENCES Employee(employee_ssn) ON DELETE CASCADE
);

-- Manages table (relationship)
CREATE TABLE Manages (
    employee_ssn VARCHAR(20) NOT NULL,
    hotel_address VARCHAR(255) NOT NULL,
    PRIMARY KEY (employee_ssn, hotel_address),
    FOREIGN KEY (employee_ssn) REFERENCES Employee(employee_ssn) ON DELETE CASCADE,
    FOREIGN KEY (hotel_address) REFERENCES Hotel(hotel_address) ON DELETE CASCADE
);


-- Data for the 5 Hotel Chains
INSERT INTO HotelChain (central_office_address, email_address, number_of_hotels)
VALUES 
    ('Hezi Grand Heights HQ, New York, New York, United States', 'info@hezigrandhotels.com', 12),
    ('Emerald Hills Inc. HQ, Los Angeles, California, United States', 'info@emeraldhills.com', 8),
    ('Mounir Luxury Resorts HQ, Miami, Florida, United States', 'info@mounirluxuryresorts.com', 15),
    ('Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 'info@sunsetvistahotels.com', 8),
    ('ZouZou International HQ, Beirut, Lebanon', 'info@zouzouinternational.com', 19);

-- Data for all Hotels
INSERT INTO Hotel (hotel_address, central_office_address, star_rating, hotel_email)
VALUES
    ('001 Hezi St, Montreal, Quebec, Canada', 'Hezi Grand Heights HQ, New York, New York, United States', 4, 'info1@hezigrandhotels.com'),
    ('002 Hezi St, New York, New York, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 4, 'info2@hezigrandhotels.com'),
    ('003 Hezi Blvd, Toronto, Ontario, Canada', 'Hezi Grand Heights HQ, New York, New York, United States', 4, 'info3@hezigrandhotels.com'),
    ('004 Hezi Rd, New York, New York, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 4, 'info4@hezigrandhotels.com'),
    ('005 Hezi Ave, Los Angeles, California, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 5, 'info5@hezigrandhotels.com'),
    ('006 Hezi St, New York, New York, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 5, 'info6@hezigrandhotels.com'),
    ('007 Hezi St, Toronto, Ontario, Canada', 'Hezi Grand Heights HQ, New York, New York, United States', 5, 'info7@hezigrandhotels.com'),
    ('008 Hezi Rd, New York, New York, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 3, 'info8@hezigrandhotels.com'),
    ('009 Hezi St, Ottawa, Ontario, Canada', 'Hezi Grand Heights HQ, New York, New York, United States', 3, 'info9@hezigrandhotels.com'),
    ('010 Hezi Ave, Toronto, Ontario, Canada', 'Hezi Grand Heights HQ, New York, New York, United States', 3, 'info10@hezigrandhotels.com'),
    ('011 Hezi St, Los Angeles, California, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 4, 'info11@hezigrandhotels.com'),
    ('012 Hezi St, Las Vegas, Nevada, United States', 'Hezi Grand Heights HQ, New York, New York, United States', 4, 'info12@hezigrandhotels.com');

INSERT INTO Hotel (hotel_address, central_office_address, star_rating, hotel_email)
VALUES
    ('101 Emerald Blvd, Ottawa, Ontario, Canada', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 4, 'info1@emeraldhills.com'),
    ('102 Emerald Rd, New York, New York, United States', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 4, 'info2@emeraldhills.com'),
    ('103 Emerald Ave, Los Angeles, California, United States', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 4, 'info3@emeraldhills.com'),
    ('104 Emerald St, Los Angeles, California, United States', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 4, 'info4@emeraldhills.com'),
    ('105 Emerald Blvd, Los Angeles, California, United States', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 5, 'info5@emeraldhills.com'),
    ('106 Emerald Rd, New York, New York, United States', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 5, 'info6@emeraldhills.com'),
    ('107 Emerald Ave, Las Vegas, Nevada, United States', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 5, 'info7@emeraldhills.com'),
    ('108 Emerald St, Montreal, Quebec, Canada', 'Emerald Hills Inc. HQ, Los Angeles, California, United States', 3, 'info8@emeraldhills.com');

INSERT INTO Hotel (hotel_address, central_office_address, star_rating, hotel_email)
VALUES
    ('201 Luxury Blvd, Miami, Florida, United States', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info1@mounirluxuryresorts.com'),
    ('202 Luxury Rd, Miami, Florida, United States', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info2@mounirluxuryresorts.com'),
    ('203 Luxury Ave, Miami, Florida, United States', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info3@mounirluxuryresorts.com'),
    ('204 Luxury St, Miami, Florida, United States', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info4@mounirluxuryresorts.com'),
    ('205 Ocean Blvd, Miami Beach, Florida, United States', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 5, 'info5@mounirluxuryresorts.com'),
    ('206 Beach Rd, Phuket, Thailand', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 5, 'info6@mounirluxuryresorts.com'),
    ('207 Paradise Ave, Bali, Indonesia', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 5, 'info7@mounirluxuryresorts.com'),
    ('208 Sunset St, Barcelona, Spain', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 3, 'info8@mounirluxuryresorts.com'),
    ('209 Bayview Blvd, Paris, France', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 3, 'info9@mounirluxuryresorts.com'),
    ('210 Harbor Rd, Sydney, Australia', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 3, 'info10@mounirluxuryresorts.com'),
    ('211 Lakeside Ave, Zurich, Switzerland', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info11@mounirluxuryresorts.com'),
    ('212 Riverwalk St, Amsterdam, Netherlands', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info12@mounirluxuryresorts.com'),
    ('213 Island Blvd, Dubai, United Arab Emirates', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 4, 'info13@mounirluxuryresorts.com'),
    ('214 Gulf Rd, Cape Town, South Africa', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 5, 'info14@mounirluxuryresorts.com'),
    ('215 Mountain Ave, Queenstown, New Zealand', 'Mounir Luxury Resorts HQ, Miami, Florida, United States', 5, 'info15@mounirluxuryresorts.com');

INSERT INTO Hotel (hotel_address, central_office_address, star_rating, hotel_email)
VALUES
    ('301 Sunset Blvd, Los Angeles, California, United States', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 4, 'info1@sunsetvistahotels.com'),
    ('302 Sunrise Rd, Los Angeles, California, United States', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 4, 'info2@sunsetvistahotels.com'),
    ('303 Dusk Ave, Miami, Florida, United States', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 4, 'info3@sunsetvistahotels.com'),
    ('304 Twilight St, Chicago, Illinois, United States', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 4, 'info4@sunsetvistahotels.com'),
    ('305 Ocean View Dr, Sydney, Australia', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 5, 'info5@sunsetvistahotels.com'),
    ('306 Mountain Rd, Queenstown, New Zealand', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 5, 'info6@sunsetvistahotels.com'),
    ('307 Island Ave, Bali, Indonesia', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 5, 'info7@sunsetvistahotels.com'),
    ('308 Hilltop Blvd, Cape Town, South Africa', 'Sunset Vista Hotels HQ, Ottawa, Ontario, Canada', 3, 'info8@sunsetvistahotels.com');

INSERT INTO Hotel (hotel_address, central_office_address, star_rating, hotel_email)
VALUES
    ('401 ZouZou Blvd, New York, New York, United States', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info1@zouzouinternational.com'),
    ('402 ZouZou Rd, New York, New York, United States', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info2@zouzouinternational.com'),
    ('403 ZouZou Ave, Miami, Florida, United States', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info3@zouzouinternational.com'),
    ('404 ZouZou St, Chicago, Illinois, United States', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info4@zouzouinternational.com'),
    ('405 ZouZou Blvd, Toronto, Ontario, Canada', 'ZouZou International HQ, Beirut, Lebanon', 5, 'info5@zouzouinternational.com'),
    ('406 ZouZou Rd, London, United Kingdom', 'ZouZou International HQ, Beirut, Lebanon', 5, 'info6@zouzouinternational.com'),
    ('407 ZouZou Ave, Paris, France', 'ZouZou International HQ, Beirut, Lebanon', 5, 'info7@zouzouinternational.com'),
    ('408 ZouZou St, Tokyo, Japan', 'ZouZou International HQ, Beirut, Lebanon', 3, 'info8@zouzouinternational.com'),
    ('409 ZouZou Blvd, Sydney, Australia', 'ZouZou International HQ, Beirut, Lebanon', 3, 'info9@zouzouinternational.com'),
    ('410 ZouZou Rd, Rio de Janeiro, Brazil', 'ZouZou International HQ, Beirut, Lebanon', 3, 'info10@zouzouinternational.com'),
    ('411 ZouZou Ave, Cape Town, South Africa', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info11@zouzouinternational.com'),
    ('412 ZouZou St, Dubai, United Arab Emirates', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info12@zouzouinternational.com'),
    ('413 ZouZou Blvd, Shanghai, China', 'ZouZou International HQ, Beirut, Lebanon', 4, 'info13@zouzouinternational.com'),
    ('414 ZouZou Rd, Moscow, Russia', 'ZouZou International HQ, Beirut, Lebanon', 5, 'info14@zouzouinternational.com'),
    ('415 ZouZou Ave, Rome, Italy', 'ZouZou International HQ, Beirut, Lebanon', 5, 'info15@zouzouinternational.com'),
    ('416 ZouZou St, Istanbul, Turkey', 'ZouZou International HQ, Beirut, Lebanon', 5, 'info16@zouzouinternational.com'),
    ('417 ZouZou Blvd, Athens, Greece', 'ZouZou International HQ, Beirut, Lebanon', 3, 'info17@zouzouinternational.com'),
    ('418 ZouZou Rd, Vancouver, Canada', 'ZouZou International HQ, Beirut, Lebanon', 3, 'info18@zouzouinternational.com'),
    ('419 ZouZou Ave, Madrid, Spain', 'ZouZou International HQ, Beirut, Lebanon', 3, 'info19@zouzouinternational.com');

-- Rooms for each Hotel
INSERT INTO Room (room_number, hotel_address, capacity, view, price, extendability, booking_start_date, booking_end_date, room_status)
VALUES

    (1, '001 Hezi St, Montreal, Quebec, Canada', 2, 'City View', 150.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '001 Hezi St, Montreal, Quebec, Canada', 4, 'Mountain View', 250.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '001 Hezi St, Montreal, Quebec, Canada', 3, 'Lake View', 200.00, TRUE, '2024-03-12', '2024-03-23', 'Occupied'),
    (4, '001 Hezi St, Montreal, Quebec, Canada', 5, 'Ocean View', 350.00, FALSE, '2024-03-18', '2024-04-01', 'Occupied'),
    (5, '001 Hezi St, Montreal, Quebec, Canada', 6, 'Garden View', 400.00, TRUE, '2024-03-20', '2024-04-03', 'Occupied'),
    (6, '001 Hezi St, Montreal, Quebec, Canada', 2, 'City View', 150.00, TRUE, NULL, NULL, 'Available'),
    (7, '001 Hezi St, Montreal, Quebec, Canada', 4, 'Mountain View', 250.00, FALSE, NULL, NULL, 'Available'),
    (8, '001 Hezi St, Montreal, Quebec, Canada', 3, 'Lake View', 200.00, TRUE, NULL, NULL, 'Available'),

    (1, '002 Hezi St, New York, New York, United States', 2, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '002 Hezi St, New York, New York, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '002 Hezi St, New York, New York, United States', 3, 'Lake View', 250.00, TRUE, '2024-03-12', '2024-03-23', 'Occupied'),
    (4, '002 Hezi St, New York, New York, United States', 5, 'Ocean View', 400.00, FALSE, '2024-03-18', '2024-04-01', 'Occupied'),
    (5, '002 Hezi St, New York, New York, United States', 6, 'Garden View', 450.00, TRUE, '2024-03-20', '2024-04-03', 'Occupied'),
    (6, '002 Hezi St, New York, New York, United States', 2, 'City View', 200.00, TRUE, NULL, NULL, 'Available'),
    (7, '002 Hezi St, New York, New York, United States', 4, 'Mountain View', 300.00, FALSE, NULL, NULL, 'Available'),
    (8, '002 Hezi St, New York, New York, United States', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),

    (1, '003 Hezi Blvd, Toronto, Ontario, Canada', 2, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '003 Hezi Blvd, Toronto, Ontario, Canada', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '003 Hezi Blvd, Toronto, Ontario, Canada', 3, 'Lake View', 250.00, TRUE, '2024-03-12', '2024-03-23', 'Available'),
    (4, '003 Hezi Blvd, Toronto, Ontario, Canada', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '003 Hezi Blvd, Toronto, Ontario, Canada', 6, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '004 Hezi Rd, New York, New York, United States', 2, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '004 Hezi Rd, New York, New York, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '004 Hezi Rd, New York, New York, United States', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '004 Hezi Rd, New York, New York, United States', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '004 Hezi Rd, New York, New York, United States', 6, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '005 Hezi Ave, Los Angeles, California, United States', 5, 'City View', 250.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '005 Hezi Ave, Los Angeles, California, United States', 3, 'Mountain View', 350.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '005 Hezi Ave, Los Angeles, California, United States', 5, 'Lake View', 300.00, TRUE, NULL, NULL, 'Available'),
    (4, '005 Hezi Ave, Los Angeles, California, United States', 6, 'Ocean View', 450.00, FALSE, NULL, NULL, 'Available'),
    (5, '005 Hezi Ave, Los Angeles, California, United States', 4, 'Garden View', 500.00, TRUE, NULL, NULL, 'Available'),

    (1, '006 Hezi St, New York, New York, United States', 5, 'City View', 300.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '006 Hezi St, New York, New York, United States', 2, 'Mountain View', 400.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '006 Hezi St, New York, New York, United States', 5, 'Lake View', 350.00, TRUE, NULL, NULL, 'Available'),
    (4, '006 Hezi St, New York, New York, United States', 3, 'Ocean View', 500.00, FALSE, NULL, NULL, 'Available'),
    (5, '006 Hezi St, New York, New York, United States', 5, 'Garden View', 550.00, TRUE, NULL, NULL, 'Available'),

    (1, '007 Hezi St, Toronto, Ontario, Canada', 5, 'City View', 300.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '007 Hezi St, Toronto, Ontario, Canada', 3, 'Mountain View', 400.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '007 Hezi St, Toronto, Ontario, Canada', 4, 'Lake View', 350.00, TRUE, NULL, NULL, 'Available'),
    (4, '007 Hezi St, Toronto, Ontario, Canada', 5, 'Ocean View', 500.00, FALSE, NULL, NULL, 'Available'),
    (5, '007 Hezi St, Toronto, Ontario, Canada', 6, 'Garden View', 550.00, TRUE, NULL, NULL, 'Available'),

    (1, '008 Hezi Rd, New York, New York, United States', 2, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '008 Hezi Rd, New York, New York, United States', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '008 Hezi Rd, New York, New York, United States', 6, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '008 Hezi Rd, New York, New York, United States', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '008 Hezi Rd, New York, New York, United States', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '009 Hezi St, Ottawa, Ontario, Canada', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '009 Hezi St, Ottawa, Ontario, Canada', 2, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '009 Hezi St, Ottawa, Ontario, Canada', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '009 Hezi St, Ottawa, Ontario, Canada', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '009 Hezi St, Ottawa, Ontario, Canada', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '010 Hezi Ave, Toronto, Ontario, Canada', 4, 'City View', 250.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '010 Hezi Ave, Toronto, Ontario, Canada', 3, 'Mountain View', 350.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '010 Hezi Ave, Toronto, Ontario, Canada', 5, 'Lake View', 300.00, TRUE, NULL, NULL, 'Available'),
    (4, '010 Hezi Ave, Toronto, Ontario, Canada', 6, 'Ocean View', 450.00, FALSE, NULL, NULL, 'Available'),
    (5, '010 Hezi Ave, Toronto, Ontario, Canada', 4, 'Garden View', 500.00, TRUE, NULL, NULL, 'Available'),

    (1, '011 Hezi St, Los Angeles, California, United States', 5, 'City View', 300.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '011 Hezi St, Los Angeles, California, United States', 3, 'Mountain View', 400.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '011 Hezi St, Los Angeles, California, United States', 5, 'Lake View', 350.00, TRUE, NULL, NULL, 'Available'),
    (4, '011 Hezi St, Los Angeles, California, United States', 3, 'Ocean View', 500.00, FALSE, NULL, NULL, 'Available'),
    (5, '011 Hezi St, Los Angeles, California, United States', 5, 'Garden View', 550.00, TRUE, NULL, NULL, 'Available'),

    (1, '012 Hezi St, Las Vegas, Nevada, United States', 5, 'City View', 300.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '012 Hezi St, Las Vegas, Nevada, United States', 3, 'Mountain View', 400.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '012 Hezi St, Las Vegas, Nevada, United States', 5, 'Lake View', 350.00, TRUE, NULL, NULL, 'Available'),
    (4, '012 Hezi St, Las Vegas, Nevada, United States', 3, 'Ocean View', 500.00, FALSE, NULL, NULL, 'Available'),
    (5, '012 Hezi St, Las Vegas, Nevada, United States', 5, 'Garden View', 550.00, TRUE, NULL, NULL, 'Available'),
    
    (1, '101 Emerald Blvd, Ottawa, Ontario, Canada', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '101 Emerald Blvd, Ottawa, Ontario, Canada', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '101 Emerald Blvd, Ottawa, Ontario, Canada', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '101 Emerald Blvd, Ottawa, Ontario, Canada', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '101 Emerald Blvd, Ottawa, Ontario, Canada', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '102 Emerald Rd, New York, New York, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '102 Emerald Rd, New York, New York, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '102 Emerald Rd, New York, New York, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '102 Emerald Rd, New York, New York, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '102 Emerald Rd, New York, New York, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '103 Emerald Ave, Los Angeles, California, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '103 Emerald Ave, Los Angeles, California, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '103 Emerald Ave, Los Angeles, California, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '103 Emerald Ave, Los Angeles, California, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '103 Emerald Ave, Los Angeles, California, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '104 Emerald St, Los Angeles, California, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '104 Emerald St, Los Angeles, California, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '104 Emerald St, Los Angeles, California, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '104 Emerald St, Los Angeles, California, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '104 Emerald St, Los Angeles, California, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '105 Emerald Blvd, Los Angeles, California, United States', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '105 Emerald Blvd, Los Angeles, California, United States', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '105 Emerald Blvd, Los Angeles, California, United States', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '105 Emerald Blvd, Los Angeles, California, United States', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '105 Emerald Blvd, Los Angeles, California, United States', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '106 Emerald Rd, New York, New York, United States', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '106 Emerald Rd, New York, New York, United States', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '106 Emerald Rd, New York, New York, United States', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '106 Emerald Rd, New York, New York, United States', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '106 Emerald Rd, New York, New York, United States', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '107 Emerald Ave, Las Vegas, Nevada, United States', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '107 Emerald Ave, Las Vegas, Nevada, United States', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '107 Emerald Ave, Las Vegas, Nevada, United States', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '107 Emerald Ave, Las Vegas, Nevada, United States', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '107 Emerald Ave, Las Vegas, Nevada, United States', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '108 Emerald St, Montreal, Quebec, Canada', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '108 Emerald St, Montreal, Quebec, Canada', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '108 Emerald St, Montreal, Quebec, Canada', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '108 Emerald St, Montreal, Quebec, Canada', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '108 Emerald St, Montreal, Quebec, Canada', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '201 Luxury Blvd, Miami, Florida, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '201 Luxury Blvd, Miami, Florida, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '201 Luxury Blvd, Miami, Florida, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '201 Luxury Blvd, Miami, Florida, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '201 Luxury Blvd, Miami, Florida, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '202 Luxury Rd, Miami, Florida, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '202 Luxury Rd, Miami, Florida, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '202 Luxury Rd, Miami, Florida, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '202 Luxury Rd, Miami, Florida, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '202 Luxury Rd, Miami, Florida, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '203 Luxury Ave, Miami, Florida, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '203 Luxury Ave, Miami, Florida, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '203 Luxury Ave, Miami, Florida, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '203 Luxury Ave, Miami, Florida, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '203 Luxury Ave, Miami, Florida, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '204 Luxury St, Miami, Florida, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '204 Luxury St, Miami, Florida, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '204 Luxury St, Miami, Florida, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '204 Luxury St, Miami, Florida, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '204 Luxury St, Miami, Florida, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '205 Ocean Blvd, Miami Beach, Florida, United States', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '205 Ocean Blvd, Miami Beach, Florida, United States', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '205 Ocean Blvd, Miami Beach, Florida, United States', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '205 Ocean Blvd, Miami Beach, Florida, United States', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '205 Ocean Blvd, Miami Beach, Florida, United States', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '206 Beach Rd, Phuket, Thailand', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '206 Beach Rd, Phuket, Thailand', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '206 Beach Rd, Phuket, Thailand', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '206 Beach Rd, Phuket, Thailand', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '206 Beach Rd, Phuket, Thailand', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '207 Paradise Ave, Bali, Indonesia', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '207 Paradise Ave, Bali, Indonesia', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '207 Paradise Ave, Bali, Indonesia', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '207 Paradise Ave, Bali, Indonesia', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '207 Paradise Ave, Bali, Indonesia', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '208 Sunset St, Barcelona, Spain', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '208 Sunset St, Barcelona, Spain', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '208 Sunset St, Barcelona, Spain', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '208 Sunset St, Barcelona, Spain', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '208 Sunset St, Barcelona, Spain', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '209 Bayview Blvd, Paris, France', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '209 Bayview Blvd, Paris, France', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '209 Bayview Blvd, Paris, France', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '209 Bayview Blvd, Paris, France', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '209 Bayview Blvd, Paris, France', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '210 Harbor Rd, Sydney, Australia', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '210 Harbor Rd, Sydney, Australia', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '210 Harbor Rd, Sydney, Australia', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '210 Harbor Rd, Sydney, Australia', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '210 Harbor Rd, Sydney, Australia', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '301 Ocean Blvd, Sydney, Australia', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '301 Ocean Blvd, Sydney, Australia', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '301 Ocean Blvd, Sydney, Australia', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '301 Ocean Blvd, Sydney, Australia', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '301 Ocean Blvd, Sydney, Australia', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '302 Mountain Rd, Queenstown, New Zealand', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '302 Mountain Rd, Queenstown, New Zealand', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '302 Mountain Rd, Queenstown, New Zealand', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '302 Mountain Rd, Queenstown, New New Zealand', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '302 Mountain Rd, Queenstown, New Zealand', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '303 Island Ave, Bali, Indonesia', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '303 Island Ave, Bali, Indonesia', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '303 Island Ave, Bali, Indonesia', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '303 Island Ave, Bali, Indonesia', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '303 Island Ave, Bali, Indonesia', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '304 Beach St, Phuket, Thailand', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '304 Beach St, Phuket, Thailand', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '304 Beach St, Phuket, Thailand', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '304 Beach St, Phuket, Thailand', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '304 Beach St, Phuket, Thailand', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '305 Sunset Blvd, Barcelona, Spain', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '305 Sunset Blvd, Barcelona, Spain', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '305 Sunset Blvd, Barcelona, Spain', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '305 Sunset Blvd, Barcelona, Spain', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '305 Sunset Blvd, Barcelona, Spain', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '306 Bayview Rd, Paris, France', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '306 Bayview Rd, Paris, France', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '306 Bayview Rd, Paris, France', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '306 Bayview Rd, Paris, France', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '306 Bayview Rd, Paris, France', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '307 Harbor Ave, Sydney, Australia', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '307 Harbor Ave, Sydney, Australia', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '307 Harbor Ave, Sydney, Australia', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '307 Harbor Ave, Sydney, Australia', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '307 Harbor Ave, Sydney, Australia', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '308 Ocean Rd, Sydney, Australia', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '308 Ocean Rd, Sydney, Australia', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '308 Ocean Rd, Sydney, Australia', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '308 Ocean Rd, Sydney, Australia', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '308 Ocean Rd, Sydney, Australia', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '401 ZouZou Blvd, New York, New York, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '401 ZouZou Blvd, New York, New York, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '401 ZouZou Blvd, New York, New York, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '401 ZouZou Blvd, New York, New York, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '401 ZouZou Blvd, New York, New York, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '402 ZouZou Rd, New York, New York, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '402 ZouZou Rd, New York, New York, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '402 ZouZou Rd, New York, New York, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '402 ZouZou Rd, New York, New York, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '402 ZouZou Rd, New York, New York, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '403 ZouZou Ave, Miami, Florida, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '403 ZouZou Ave, Miami, Florida, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '403 ZouZou Ave, Miami, Florida, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '403 ZouZou Ave, Miami, Florida, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '403 ZouZou Ave, Miami, Florida, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '404 ZouZou St, Chicago, Illinois, United States', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '404 ZouZou St, Chicago, Illinois, United States', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '404 ZouZou St, Chicago, Illinois, United States', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '404 ZouZou St, Chicago, Illinois, United States', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '404 ZouZou St, Chicago, Illinois, United States', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '405 ZouZou Blvd, Toronto, Ontario, Canada', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '405 ZouZou Blvd, Toronto, Ontario, Canada', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '405 ZouZou Blvd, Toronto, Ontario, Canada', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '405 ZouZou Blvd, Toronto, Ontario, Canada', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '405 ZouZou Blvd, Toronto, Ontario, Canada', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '406 ZouZou Rd, London, United Kingdom', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '406 ZouZou Rd, London, United Kingdom', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '406 ZouZou Rd, London, United Kingdom', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '406 ZouZou Rd, London, United Kingdom', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '406 ZouZou Rd, London, United Kingdom', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '407 ZouZou Ave, Paris, France', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '407 ZouZou Ave, Paris, France', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '407 ZouZou Ave, Paris, France', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '407 ZouZou Ave, Paris, France', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '407 ZouZou Ave, Paris, France', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '408 ZouZou St, Tokyo, Japan', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '408 ZouZou St, Tokyo, Japan', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '408 ZouZou St, Tokyo, Japan', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '408 ZouZou St, Tokyo, Japan', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '408 ZouZou St, Tokyo, Japan', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '409 ZouZou Blvd, Sydney, Australia', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '409 ZouZou Blvd, Sydney, Australia', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '409 ZouZou Blvd, Sydney, Australia', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '409 ZouZou Blvd, Sydney, Australia', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '409 ZouZou Blvd, Sydney, Australia', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '410 ZouZou Rd, Rio de Janeiro, Brazil', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '410 ZouZou Rd, Rio de Janeiro, Brazil', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '410 ZouZou Rd, Rio de Janeiro, Brazil', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '410 ZouZou Rd, Rio de Janeiro, Brazil', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '410 ZouZou Rd, Rio de Janeiro, Brazil', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '411 ZouZou Ave, Cape Town, South Africa', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '411 ZouZou Ave, Cape Town, South Africa', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '411 ZouZou Ave, Cape Town, South Africa', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '411 ZouZou Ave, Cape Town, South Africa', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '411 ZouZou Ave, Cape Town, South Africa', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '412 ZouZou St, Dubai, United Arab Emirates', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '412 ZouZou St, Dubai, United Arab Emirates', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '412 ZouZou St, Dubai, United Arab Emirates', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '412 ZouZou St, Dubai, United Arab Emirates', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '412 ZouZou St, Dubai, United Arab Emirates', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '413 ZouZou Blvd, Shanghai, China', 4, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '413 ZouZou Blvd, Shanghai, China', 4, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '413 ZouZou Blvd, Shanghai, China', 4, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '413 ZouZou Blvd, Shanghai, China', 4, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '413 ZouZou Blvd, Shanghai, China', 4, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '414 ZouZou Rd, Moscow, Russia', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '414 ZouZou Rd, Moscow, Russia', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '414 ZouZou Rd, Moscow, Russia', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '414 ZouZou Rd, Moscow, Russia', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '414 ZouZou Rd, Moscow, Russia', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '415 ZouZou St, Rome, Italy', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '415 ZouZou St, Rome, Italy', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '415 ZouZou St, Rome, Italy', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '415 ZouZou St, Rome, Italy', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '415 ZouZou St, Rome, Italy', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '416 ZouZou St, Istanbul, Turkey', 5, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '416 ZouZou St, Istanbul, Turkey', 5, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '416 ZouZou St, Istanbul, Turkey', 5, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '416 ZouZou St, Istanbul, Turkey', 5, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '416 ZouZou St, Istanbul, Turkey', 5, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '417 ZouZou Blvd, Athens, Greece', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '417 ZouZou Blvd, Athens, Greece', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '417 ZouZou Blvd, Athens, Greece', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '417 ZouZou Blvd, Athens, Greece', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '417 ZouZou Blvd, Athens, Greece', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '418 ZouZou Rd, Vancouver, Canada', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '418 ZouZou Rd, Vancouver, Canada', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '418 ZouZou Rd, Vancouver, Canada', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '418 ZouZou Rd, Vancouver, Canada', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '418 ZouZou Rd, Vancouver, Canada', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available'),

    (1, '419 ZouZou Ave, Madrid, Spain', 3, 'City View', 200.00, TRUE, '2024-03-10', '2024-03-20', 'Occupied'),
    (2, '419 ZouZou Ave, Madrid, Spain', 3, 'Mountain View', 300.00, FALSE, '2024-03-15', '2024-03-28', 'Occupied'),
    (3, '419 ZouZou Ave, Madrid, Spain', 3, 'Lake View', 250.00, TRUE, NULL, NULL, 'Available'),
    (4, '419 ZouZou Ave, Madrid, Spain', 3, 'Ocean View', 400.00, FALSE, NULL, NULL, 'Available'),
    (5, '419 ZouZou Ave, Madrid, Spain', 3, 'Garden View', 450.00, TRUE, NULL, NULL, 'Available');

-- All possible amenities
INSERT INTO Amenity (amenity_name)
VALUES 
    ('WiFi'), 
    ('Swimming Pool'), 
    ('Gym'), 
    ('Restaurant'), 
    ('Spa'), 
    ('Bar'), 
    ('Fitness Center'), 
    ('Beach Access'), 
    ('Concierge Service'), 
    ('Room Service'), 
    ('Business Center'), 
    ('Parking'), 
    ('Laundry Service'), 
    ('Airport Shuttle'), 
    ('Pet Friendly'), 
    ('Kids Club'), 
    ('Meeting Rooms'), 
    ('Jacuzzi'), 
    ('Sauna'), 
    ('Tennis Court');

-- Temporary table to store random amenities to add to each room
CREATE TEMPORARY TABLE RandomAmenities AS
SELECT 
    room_number, 
    amenity_id 
FROM 
    Room 
CROSS JOIN (
    SELECT 
        amenity_id 
    FROM 
        Amenity 
    ORDER BY 
        RANDOM() 
    LIMIT 
        ROUND(RAND() * 9) + 1
) AS random_amenities;

-- Add the randomly generated amenities for each hotel
INSERT INTO RoomAmenity (room_number, amenity_id)
SELECT 
    ra.room_number, 
    ra.amenity_id
FROM 
    RandomAmenities ra
JOIN 
    Room r ON ra.room_number = r.room_number
JOIN 
    Hotel h ON r.hotel_address = h.hotel_address;


-- 4 random queries this can be changed though depending on frontend:

-- Query to find the hotel with the most rooms:
SELECT 
    hotel_address,
    COUNT(*) AS num_rooms
FROM 
    Room
GROUP BY 
    hotel_address
ORDER BY 
    num_rooms DESC
LIMIT 
    1;

-- Query to find the hotel with the highest number of amenities:
SELECT 
    hotel_address,
    COUNT(*) AS num_amenities
FROM
    RoomAmenity  
JOIN
    Room ON RoomAmenity.room_number = Room.room_number
GROUP BY
    hotel_address
ORDER BY
    num_amenities DESC
LIMIT
    1;

-- Query to find the hotel with the lowest number of occupied rooms:
SELECT 
    hotel_address,
    COUNT(*) AS num_occupied_rooms
FROM
    Room
WHERE
    room_status = 'Occupied'
GROUP BY
    hotel_address
ORDER BY
    num_occupied_rooms ASC
LIMIT
    1;

--Query to find rooms with a price lower than the average price of rooms in their respective hotels:

SELECT 
    r.room_number,
    r.price,
    r.hotel_address
FROM 
    Room r
INNER JOIN (
    SELECT 
        hotel_address,
        AVG(price) AS avg_price
    FROM 
        Room
    GROUP BY 
        hotel_address
) AS avg_prices ON r.hotel_address = avg_prices.hotel_address
WHERE 
    r.price < avg_prices.avg_price;
