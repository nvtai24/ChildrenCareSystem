-- Create database
CREATE DATABASE IF NOT EXISTS ChildrenCare;
USE ChildrenCare;
-- Create Category table
CREATE TABLE Category (
    id INT AUTO_INCREMENT,
    type VARCHAR(20),
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
    PRIMARY KEY (userid)
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
    FOREIGN KEY (role_id) REFERENCES Role(id),
    FOREIGN KEY (id) REFERENCES Profile(userid)
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

-- Insert data vào bảng Slider
INSERT INTO Slider (title, image_url, back_link, status)
VALUES
('Welcome to Children Care', 'slider1.jpg', 'home', 1),
('Health Check Promotion', 'slider2.jpg', 'services', 1),
('Vaccination Updates', 'slider3.jpg', 'news', 1),
('Nutrition Tips for Kids', 'slider4.jpg', 'blog', 1),
('Emergency Services Available', 'slider5.jpg', 'services', 1);

-- Insert data vào bảng Service
INSERT INTO Service ( name, description, brief_info, price, discount, thumbnail, status)
VALUES
( 'Health Checkup', 'Comprehensive health checkup for children.', 'General health checkup', 50.00, 10.00, 'service1.jpg', 1),
( 'Vaccination', 'Vaccination services for all ages.', 'Vaccines available', 30.00, 5.00, 'service2.jpg', 1),
( 'Nutritional Guidance', 'Expert advice on child nutrition.', 'Nutrition tips', 40.00, 15.00, 'service3.jpg', 1),
( 'Home Health Services', 'Doctor visits at home.', 'Home visits', 100.00, 20.00, 'service4.jpg', 1),
( 'Behavioral Counseling', 'Counseling for child behavioral issues.', 'Counseling services', 70.00, 10.00, 'service5.jpg', 1);



-- Insert data vào bảng Profile
INSERT INTO Profile (full_name, gender, dob, address, phone, avatar)
VALUES
('Admin User', 1, '1985-05-05', '123 Elm Street', '1234567890', 'admin_avatar.jpg'),
('Doctor Mike', 1, '1980-03-03', '101 Pine Lane', '0987654321', 'doctor_avatar.jpg'),
('Nurse Anna', 0, '1990-07-10', '456 Maple Avenue', '1122334455', 'nurse_avatar.jpg'),
('Jane Smith', 0, '1995-12-25', '789 Oak Drive', '5566778899', 'jane_avatar.jpg'),
('John Doe', 1, '1990-06-15', '202 Cedar Road', '6677889900', 'john_avatar.jpg');

-- Insert data vào bảng User
INSERT INTO User (id, username, password, email, status)
VALUES
(1, 'admin', 'password123', 'admin@children.care', 1),
(2, 'doctor_mike', 'doctor123', 'mike@children.care', 1),
(3, 'nurse_anna', 'nurse123', 'anna@children.care', 1),
(4, 'user_jane', 'user123', 'jane@children.care', 1),
(5, 'user_john', 'user123', 'john@children.care', 1);

-- Insert data vào bảng Post (blog)
INSERT INTO Post ( title, content, thumbnail, status)
VALUES
( 'Importance of Vaccination for Kids', 'Vaccines protect children from serious illnesses...', 'post1.jpg', 1),
( 'Top 5 Health Tips for Kids', 'Learn the best practices for maintaining children health...', 'post2.jpg', 1),
( 'Nutrition Advice for Growing Kids', 'Discover how to provide a balanced diet...', 'post3.jpg', 1),
( 'Home Care Services During Pandemic', 'How home care services help during crises...', 'post4.jpg', 1),
( 'Managing Behavioral Issues in Kids', 'Effective ways to address behavioral challenges...', 'post5.jpg', 1);
