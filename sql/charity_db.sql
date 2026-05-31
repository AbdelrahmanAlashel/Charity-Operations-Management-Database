CREATE DATABASE charity_db;

USE charity_db;

CREATE TABLE donors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_code VARCHAR(50),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    type VARCHAR(50)
);

CREATE TABLE campaigns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    goal_amount DECIMAL(10,2),
    status VARCHAR(50)
);

CREATE TABLE donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    campaign_id INT,
    amount DECIMAL(10,2) NOT NULL,
    donation_type VARCHAR(50),
    date DATE,
    payment_method VARCHAR(50),
    
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id)
);

CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_id INT,
    name VARCHAR(100),
    type VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    description TEXT,
    
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id)
);

CREATE TABLE beneficiaries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    beneficiary_code VARCHAR(50),
    region VARCHAR(100),
    household_size INT
);

CREATE TABLE distributions (
    donation_id INT,
    beneficiary_id INT,
    type VARCHAR(50),
    amount DECIMAL(10,2),
    date DATE,
    
    PRIMARY KEY (donation_id, beneficiary_id),
    
    FOREIGN KEY (donation_id) REFERENCES donations(id),
    FOREIGN KEY (beneficiary_id) REFERENCES beneficiaries(id)
);

CREATE TABLE shifts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    start_time DATETIME,
    end_time DATETIME,
    
    FOREIGN KEY (event_id) REFERENCES events(id)
);

CREATE TABLE volunteers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    skills VARCHAR(255),
    availability BOOLEAN
);

CREATE TABLE volunteer_shift (
    volunteer_id INT,
    shift_id INT,
    role VARCHAR(50),
    attendance_status BOOLEAN,
    
    PRIMARY KEY (volunteer_id, shift_id),
    
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(id),
    FOREIGN KEY (shift_id) REFERENCES shifts(id)
);

CREATE TABLE partners (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    contact_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    type VARCHAR(50)
);

CREATE TABLE event_partner (
    event_id INT,
    partner_id INT,
    
    PRIMARY KEY (event_id, partner_id),
    
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (partner_id) REFERENCES partners(id)
);

-- ========================
-- Donors
-- ========================
INSERT INTO donors (donor_code, name, email, phone, address, type) VALUES
('DNR-1001', 'Alice Johnson', 'alice@example.com', '123-456-7890', '123 Main St', 'Individual'),
('DNR-1002', 'Bob Smith', 'bob@example.com', '234-567-8901', '456 Oak Ave', 'Individual'),
('DNR-1003', 'Helping Hands Org', 'contact@helpinghands.org', '345-678-9012', '789 Pine Rd', 'Organization');

-- ========================
-- Campaigns
-- ========================
INSERT INTO campaigns (name, description, start_date, end_date, goal_amount, status) VALUES
('Winter Food Drive', 'Providing food supplies during winter', '2026-01-01', '2026-02-28', 10000, 'Active'),
('Ramadan Aid', 'Support for families during Ramadan', '2026-03-01', '2026-04-15', 15000, 'Planned');

-- ========================
-- Donations
-- ========================
INSERT INTO donations (donor_id, campaign_id, amount, donation_type, date, payment_method) VALUES
(1, 1, 200.00, 'Cash', '2026-01-10', 'Credit Card'),
(2, 1, 150.00, 'Cash', '2026-01-15', 'Debit Card'),
(3, 2, 500.00, 'In-Kind', '2026-03-05', 'N/A');

-- ========================
-- Events
-- ========================
INSERT INTO events (campaign_id, name, type, location, date, description) VALUES
(1, 'Food Distribution Day 1', 'Distribution', 'Community Center', '2026-01-20', 'first round of distribution'),
(1, 'Food Distribution Day 2', 'Distribution', 'Downtown Hall', '2026-02-05', 'Second round of distribution'),
(2, 'Ramadan Kickoff', 'Fundraising', 'City Mosque', '2026-03-10', 'Launching Ramadan campaign');

-- ========================
-- Beneficiaries
-- ========================
INSERT INTO beneficiaries (beneficiary_code, region, household_size) VALUES
('BEN-001', 'Charlottetown Area', 4),
('BEN-002', 'Summerside Area', 3),
('BEN-003', 'Charlottetown Area', 5);

-- ========================
-- Distributions
-- ========================
INSERT INTO distributions (donation_id, beneficiary_id, type, amount, date) VALUES
(1, 1, 'Food', 50.00, '2026-01-20'),
(1, 2, 'Food', 30.00, '2026-01-20'),
(2, 3, 'Food', 40.00, '2026-02-05');

-- ========================
-- Shifts
-- ========================
INSERT INTO shifts (event_id, start_time, end_time) VALUES
(1, '2026-01-20 09:00:00', '2026-01-20 12:00:00'),
(1, '2026-01-20 12:00:00', '2026-01-20 15:00:00'),
(2, '2026-02-05 10:00:00', '2026-02-05 14:00:00');

-- ========================
-- Volunteers
-- ========================
INSERT INTO volunteers (name, email, phone, address, skills, availability) VALUES
('John Doe', 'john@example.com', '555-1111', '12 Elm St', 'Cooking, Driving', TRUE),
('Jane Smith', 'jane@example.com', '555-2222', '34 Maple St', 'Organizing', TRUE),
('Mike Brown', 'mike@example.com', '555-3333', '56 Birch St', 'Packing', FALSE);

-- ========================
-- Volunteer_Shift
-- ========================
INSERT INTO volunteer_shift (volunteer_id, shift_id, role, attendance_status) VALUES
(1, 1, 'Driver', TRUE),
(2, 1, 'Coordinator', TRUE),
(3, 2, 'Helper', FALSE);

-- ========================
-- Partners
-- ========================
INSERT INTO partners (name, contact_name, email, phone, address, type) VALUES
('Northside Catering', 'Ali Khan', 'northside@example.com', '555-4444', '78 King St', 'Supplier'),
('Fresh Foods Inc.', 'Sara Lee', 'fresh@example.com', '555-5555', '90 Queen St', 'Sponsor');

-- ========================
-- Event_Partner
-- ========================
INSERT INTO event_partner (event_id, partner_id) VALUES
(1, 1),
(2, 1),
(3, 2);
