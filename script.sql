-- Create database
drop database if exists ChildrenCare;
CREATE DATABASE  ChildrenCare;
USE ChildrenCare;
-- Create Category table
CREATE TABLE Category (
    id INT AUTO_INCREMENT,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    status BOOLEAN DEFAULT 1,
    PRIMARY KEY (id)
);

-- Create Feature table
CREATE TABLE Feature (
    id INT AUTO_INCREMENT,
    feature_name NVARCHAR(100) NOT NULL,
    url VARCHAR(200),
    description NVARCHAR(500),
    status BOOLEAN DEFAULT 1,
    PRIMARY KEY (id)
);

-- Create Label table
CREATE TABLE Label (
    id INT,
    labelName NVARCHAR(50) NOT NULL,
    description TEXT,
    status BOOLEAN DEFAULT 1,
    PRIMARY KEY (id)
);

-- Create Role table
CREATE TABLE Role (
    id INT AUTO_INCREMENT,
    role_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200),
    status BOOLEAN DEFAULT 1,
    PRIMARY KEY (id)
);
-- Create User table
CREATE TABLE User (
    id INT AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role_id INT,
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (email),
    UNIQUE KEY (username),
    FOREIGN KEY (role_id) REFERENCES Role(id)
    
);
-- Create Profile table
CREATE TABLE Profile (
    userid INT AUTO_INCREMENT,
    full_name NVARCHAR(100),
    gender BOOLEAN,
    dob DATE,
    address NVARCHAR(200),
    phone VARCHAR(20),
    avatar VARCHAR(200),
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (userid),
    FOREIGN KEY (userid) REFERENCES User(id)
);



-- Create Post table
CREATE TABLE Post (
    id INT AUTO_INCREMENT,
    author_id INT,
    title NVARCHAR(200) NOT NULL,
    content TEXT,
    thumbnail VARCHAR(200),
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES User(id)
);

-- Create LabelPost table
CREATE TABLE LabelPost (
    label_id INT,
    post_id INT,
    PRIMARY KEY (label_id, post_id),
    FOREIGN KEY (label_id) REFERENCES Label(id),
    FOREIGN KEY (post_id) REFERENCES Post(id)
);

-- Create ReservationStatus table
CREATE TABLE ReservationStatus (
    id INT AUTO_INCREMENT,
    status_name NVARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- Create Reservation table
CREATE TABLE Reservation (
    id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    status_id INT NOT NULL,
    reserved_date DATETIME NOT NULL,
    notes NVARCHAR(500),
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES User(id),
    FOREIGN KEY (status_id) REFERENCES ReservationStatus(id)
);

-- Create Service table
CREATE TABLE Service (
    id INT AUTO_INCREMENT,
    category_id INT,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(500),
    brief_info NVARCHAR(200),
    price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(5, 2),
    thumbnail VARCHAR(200),
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- Create ReservationDetail table
CREATE TABLE ReservationDetail (
    id INT AUTO_INCREMENT,
    reservation_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(10, 2),
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(id),
    FOREIGN KEY (service_id) REFERENCES Service(id)
);

-- Create Feedback table
CREATE TABLE Feedback (
    reservationdetail_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(500),
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (reservationdetail_id),
    FOREIGN KEY (reservationdetail_id) REFERENCES ReservationDetail(id)
);

-- Create MedicalExamination table
CREATE TABLE MedicalExamination (
    id INT AUTO_INCREMENT,
    reservation_id INT,
    staff_id INT,
    examination_date DATETIME,
    diagnosis NVARCHAR(500),
    notes TEXT,
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(id),
    FOREIGN KEY (staff_id) REFERENCES User(id)
);

-- Create MedicalPrescription table
CREATE TABLE MedicalPrescription (
    id INT,
    examination_id INT NOT NULL,
    medicine_name NVARCHAR(200),
    dosage INT,
    instructions TEXT,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (examination_id) REFERENCES MedicalExamination(id)
);

-- Create RoleFeature table
CREATE TABLE RoleFeature (
    role_id INT,
    feature_id INT,
    status BOOLEAN DEFAULT 1,
    PRIMARY KEY (role_id, feature_id),
    FOREIGN KEY (role_id) REFERENCES Role(id),
    FOREIGN KEY (feature_id) REFERENCES Feature(id)
);

-- Create Setting table
CREATE TABLE Setting (
    id INT AUTO_INCREMENT,
    setting_key VARCHAR(100) NOT NULL,
    setting_value TEXT,
    setting_type VARCHAR(50),
    description NVARCHAR(500),
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (setting_key)
);

-- Create Slider table
CREATE TABLE Slider (
    id INT AUTO_INCREMENT,
    title NVARCHAR(200),
    image_url VARCHAR(200),
    back_link VARCHAR(200),
    author_id INT,
    status BOOLEAN DEFAULT 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES User(id)
);

-- Create indexes
CREATE INDEX IX_Service_Category ON Service(category_id);
CREATE INDEX IX_User_Email ON User(email);
CREATE INDEX IX_User_Username ON User(username);
CREATE INDEX IX_Reservation_Customer ON Reservation(customer_id);
CREATE INDEX IX_Reservation_Date ON Reservation(reserved_date);
CREATE INDEX IX_MedicalExamination_Reservation ON MedicalExamination(reservation_id);


INSERT INTO Role (role_name, description) VALUES
('Admin', 'Administrator with full access to the system.'),
('Doctor', 'Medical professional providing health services.'),
('Parent', 'Parent or guardian of a child using the services.'),
('Staff', 'Support staff assisting in the operations.');

INSERT INTO User (username, password, email, role_id) VALUES
('admin', 'admin123', 'admin@childrencare.com', 1),
('doctor1', 'doctor123', 'doctor1@childrencare.com', 2),
('parent1', 'parent123', 'parent1@childrencare.com', 3),
('staff1', 'staff123', 'staff1@childrencare.com', 4);

INSERT INTO Profile (userid, full_name, gender, dob, address, phone, avatar) VALUES
(1, 'Admin User', 1, '1980-01-01', '123 Admin Street', '123-456-7890', 'admin.jpg'),
(2, 'Dr. John Doe', 1, '1975-05-15', '456 Health Lane', '234-567-8901', 'doctor1.jpg'),
(3, 'Jane Smith', 0, '1985-08-20', '789 Parent Road', '345-678-9012', 'parent1.jpg'),
(4, 'Staff Member', 1, '1990-03-10', '101 Staff Avenue', '456-789-0123', 'staff1.jpg');

INSERT INTO Category (name, description) VALUES
('General Checkup', 'Regular health checkups for children to monitor growth and development.'),
('Vaccination', 'Vaccination services to protect children from various diseases.'),
('Nutrition', 'Nutritional advice and dietary plans for children.'),
('Dental Care', 'Dental health services for children, including checkups and treatments.'),
('Emergency Care', 'Emergency medical services for children.'),
('Physical Therapy', 'Physical therapy services to support children with physical disabilities or injuries.'),
('Mental Health', 'Mental health support and counseling for children.');

INSERT INTO Service (category_id, name, description, brief_info, price, discount, thumbnail) VALUES
-- Dịch vụ thuộc danh mục General Checkup (category_id = 1)
(1, 'Advanced Health Checkup', 'A detailed health checkup including blood tests, urine tests, and more.', 'Advanced health checkup for children', 100.00, 0.00, 'advanced_checkup.jpg'),
(1, 'Annual Health Screening', 'Comprehensive annual health screening for children.', 'Annual health screening', 150.00, 5.00, 'annual_screening.jpg'),

-- Dịch vụ thuộc danh mục Vaccination (category_id = 2)
(2, 'Flu Vaccination', 'Annual flu vaccination to protect children from seasonal flu.', 'Flu vaccination for children', 40.00, 0.00, 'flu_vaccination.jpg'),
(2, 'MMR Vaccination', 'Vaccination against Measles, Mumps, and Rubella.', 'MMR vaccination', 60.00, 0.00, 'mmr_vaccination.jpg'),
(2, 'Hepatitis B Vaccination', 'Vaccination to protect against Hepatitis B.', 'Hepatitis B vaccination', 70.00, 0.00, 'hepatitis_b_vaccination.jpg'),

-- Dịch vụ thuộc danh mục Nutrition (category_id = 3)
(3, 'Weight Management Consultation', 'Consultation for children struggling with weight issues.', 'Weight management for children', 90.00, 0.00, 'weight_management.jpg'),
(3, 'Allergy Testing and Diet Plan', 'Testing for food allergies and creating a safe diet plan.', 'Allergy testing and diet plan', 120.00, 0.00, 'allergy_testing.jpg'),

-- Dịch vụ thuộc danh mục Dental Care (category_id = 4)
(4, 'Tooth Extraction', 'Safe and painless tooth extraction for children.', 'Tooth extraction for children', 80.00, 0.00, 'tooth_extraction.jpg'),
(4, 'Braces Consultation', 'Consultation for orthodontic treatment and braces.', 'Braces consultation', 50.00, 0.00, 'braces_consultation.jpg'),
(4, 'Teeth Whitening', 'Teeth whitening treatment for children.', 'Teeth whitening', 100.00, 10.00, 'teeth_whitening.jpg'),

-- Dịch vụ thuộc danh mục Emergency Care (category_id = 5)
(5, '24/7 Emergency Consultation', 'Round-the-clock emergency consultation for children.', '24/7 emergency consultation', 250.00, 0.00, 'emergency_consultation.jpg'),
(5, 'Injury Treatment', 'Treatment for minor injuries and wounds.', 'Injury treatment for children', 150.00, 0.00, 'injury_treatment.jpg'),

-- Dịch vụ thuộc danh mục Physical Therapy (category_id = 6)
(6, 'Post-Surgery Rehabilitation', 'Rehabilitation services for children after surgery.', 'Post-surgery rehabilitation', 120.00, 0.00, 'rehabilitation.jpg'),
(6, 'Sports Injury Therapy', 'Therapy for children recovering from sports injuries.', 'Sports injury therapy', 110.00, 0.00, 'sports_therapy.jpg'),
(6, 'Developmental Delay Therapy', 'Therapy for children with developmental delays.', 'Developmental delay therapy', 130.00, 0.00, 'developmental_therapy.jpg'),

-- Dịch vụ thuộc danh mục Mental Health (category_id = 7)
(7, 'Anxiety Counseling', 'Counseling for children dealing with anxiety.', 'Anxiety counseling', 110.00, 0.00, 'anxiety_counseling.jpg'),
(7, 'Behavioral Therapy', 'Therapy for children with behavioral issues.', 'Behavioral therapy', 120.00, 0.00, 'behavioral_therapy.jpg'),
(7, 'ADHD Management', 'Counseling and management for children with ADHD.', 'ADHD management', 130.00, 0.00, 'adhd_management.jpg'),

-- Dịch vụ thuộc danh mục General Checkup (category_id = 1)
(1, 'Newborn Health Checkup', 'Comprehensive health checkup for newborns.', 'Newborn health checkup', 70.00, 0.00, 'newborn_checkup.jpg'),
(1, 'Growth Monitoring', 'Regular monitoring of child growth and development.', 'Growth monitoring', 60.00, 0.00, 'growth_monitoring.jpg'),

-- Dịch vụ thuộc danh mục Vaccination (category_id = 2)
(2, 'Chickenpox Vaccination', 'Vaccination to protect against chickenpox.', 'Chickenpox vaccination', 50.00, 0.00, 'chickenpox_vaccination.jpg'),
(2, 'Pneumococcal Vaccination', 'Vaccination to protect against pneumococcal diseases.', 'Pneumococcal vaccination', 80.00, 0.00, 'pneumococcal_vaccination.jpg');

INSERT INTO ReservationStatus (status_name) VALUES
('Pending'),
('Confirmed'),
('Completed'),
('Cancelled');


INSERT INTO Reservation (customer_id, status_id, reserved_date, notes) VALUES
(3, 1, '2023-10-15 10:00:00', 'Regular checkup for my child.'),
(3, 2, '2023-10-20 14:00:00', 'Vaccination appointment.'),
(3, 3, '2023-10-25 09:00:00', 'Nutrition consultation.');


INSERT INTO ReservationDetail (reservation_id, service_id, quantity, price) VALUES
(1, 1, 1, 50.00),
(2, 2, 1, 120.00),
(3, 3, 1, 80.00);


INSERT INTO MedicalExamination (reservation_id, staff_id, examination_date, diagnosis, notes) VALUES
(1, 2, '2023-10-15 10:30:00', 'Healthy', 'No issues found during the checkup.'),
(2, 2, '2023-10-20 14:30:00', 'Vaccinated', 'Child received all scheduled vaccinations.'),
(3, 2, '2023-10-25 09:30:00', 'Nutritional Advice', 'Provided dietary recommendations.');


INSERT INTO MedicalPrescription (id, examination_id, medicine_name, dosage, instructions) VALUES
(1, 1, 'Multivitamin', 1, 'Take once daily with meals.'),
(2, 3, 'Calcium Supplement', 1, 'Take once daily with breakfast.');

INSERT INTO Slider (title, image_url, back_link, author_id) VALUES
('Welcome to Children Care', 'welcome.jpg', '/', 1),
('Healthy Kids, Happy Parents', 'healthy_kids.jpg', '/services', 1),
('Book an Appointment Today', 'appointment.jpg', '/appointment', 1);


INSERT INTO Post (author_id, title, content, thumbnail) VALUES
(1, 'Importance of Regular Checkups', 'Regular health checkups are essential for monitoring the growth and development of children.', 'checkup.jpg'),
(2, 'Vaccination Schedule for Children', 'Ensure your child is up-to-date with their vaccinations to protect them from diseases.', 'vaccination.jpg'),
(3, 'Nutrition Tips for Kids', 'A balanced diet is crucial for the healthy development of children.', 'nutrition.jpg');


INSERT INTO Label (id, labelName, description) VALUES
(1, 'Health Tips', 'Posts related to health tips for children.'),
(2, 'Vaccination', 'Posts related to vaccination information.'),
(3, 'Nutrition', 'Posts related to child nutrition.');

INSERT INTO LabelPost (label_id, post_id) VALUES
(1, 1),
(2, 2),
(3, 3);