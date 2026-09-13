-- ============================================================
-- Hospital Management System  |  Practical Exam Set C
-- Schema + Sample Data + All Required Queries
-- ============================================================

DROP DATABASE IF EXISTS hospital_management;
CREATE DATABASE hospital_management;
USE hospital_management;

-- ========== TABLES ==========

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    registration_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    available_days VARCHAR(100),
    consultation_fee DECIMAL(10,2),
    years_of_experience INT DEFAULT 0
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Doctor_Department (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT,
    prescription TEXT,
    treatment_date DATE,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

CREATE TABLE Billing (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Pending', 'Cancelled') DEFAULT 'Pending',
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE SET NULL
);

-- ========== SAMPLE DATA ==========

INSERT INTO Departments (department_name) VALUES
('Cardiology'), ('Neurology'), ('Dermatology'),
('Orthopedics'), ('Pediatrics'), ('General Medicine');

INSERT INTO Doctors (name, specialization, phone_number, email, available_days, consultation_fee, years_of_experience) VALUES
('Dr. Rajesh Kumar',  'Cardiology',      '9876543210', 'rajesh.kumar@hospital.com',  'Mon,Wed,Fri', 1500.00, 18),
('Dr. Priya Sharma',  'Neurology',       '9876543211', 'priya.sharma@hospital.com',  'Tue,Thu',     1800.00, 12),
('Dr. Amit Patel',    'Dermatology',     '9876543212', 'amit.patel@hospital.com',    'Mon,Tue,Wed', 1200.00, 8),
('Dr. Sneha Reddy',   'Orthopedics',     '9876543213', 'sneha.reddy@hospital.com',   'Wed,Fri',     1400.00, 15),
('Dr. Vikram Singh',  'Pediatrics',      '9876543214', 'vikram.singh@hospital.com',  'Mon,Thu,Sat', 1000.00, 6),
('Dr. Ananya Gupta',  'General Medicine','9876543215', 'ananya.gupta@hospital.com',  'Tue,Wed,Fri', 900.00,  4),
('Dr. Karthik Nair',  'Cardiology',      '9876543216', 'karthik.nair@hospital.com',  'Thu,Sat',     1600.00, 20),
('Dr. Meera Iyer',    'Dermatology',     NULL,         'meera.iyer@hospital.com',    'Mon,Fri',     1100.00, 9);

INSERT INTO Doctor_Department (doctor_id, department_id) VALUES
(1, 1), (7, 1), (2, 2), (3, 3), (8, 3), (4, 4), (5, 5), (6, 6);

INSERT INTO Patients (name, dob, gender, phone_number, email, address, registration_date) VALUES
('Aarav Mehta',    '1990-05-12', 'Male',   '9123456780', 'aarav.mehta@email.com',    '12 MG Road, Mumbai',       '2024-01-15'),
('Sanya Kapoor',   '1985-08-22', 'Female', '9123456781', 'sanya.kapoor@email.com',   '45 Park Street, Delhi',    '2023-11-20'),
('Rohan Das',      '2001-03-05', 'Male',   '9123456782', 'rohan.das@email.com',      '78 Lake View, Bangalore',  '2025-02-10'),
('Ishita Verma',   '1995-11-18', 'Female', NULL,         'ishita.verma@email.com',   '23 Green Avenue, Pune',    '2024-06-05'),
('Karan Malhotra', '1978-07-30', 'Male',   '9123456784', 'karan.malhotra@email.com', '90 Civil Lines, Jaipur',   '2023-09-12'),
('Neha Joshi',     '1992-01-25', 'Female', '9123456785', 'neha.joshi@email.com',     '15 Hill Road, Hyderabad',  '2024-12-01'),
('Aditya Rao',     '1988-09-14', 'Male',   '9123456786', 'aditya.rao@email.com',     '67 Beach Road, Chennai',   '2025-01-20'),
('Pooja Nair',     '2000-04-08', 'Female', '9123456787', 'pooja.nair@email.com',     '34 Lake Road, Kochi',      '2024-03-18'),
('Vivek Sharma',   '1975-12-03', 'Male',   '9123456788', 'vivek.sharma@email.com',   '88 Sector 15, Chandigarh', '2023-07-25'),
('Anjali Patel',   '1998-06-19', 'Female', '9123456789', 'anjali.patel@email.com',   '56 Ring Road, Ahmedabad',  '2025-03-01');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-01-10 10:00:00', 'Completed'),
(2, 2, '2025-01-12 11:30:00', 'Completed'),
(3, 3, '2025-01-15 09:00:00', 'Completed'),
(4, 4, '2025-02-01 14:00:00', 'Scheduled'),
(5, 1, '2025-02-05 10:30:00', 'Completed'),
(6, 5, '2025-02-10 16:00:00', 'Completed'),
(7, 6, '2025-02-15 09:30:00', 'Cancelled'),
(1, 7, '2025-03-01 11:00:00', 'Completed'),
(8, 3, '2025-03-05 13:00:00', 'Scheduled'),
(9, 2, '2025-03-10 15:00:00', 'Completed'),
(2, 1, '2025-03-15 10:00:00', 'Completed'),
(10,8, '2025-03-20 12:00:00', 'Scheduled'),
(3, 4, '2024-08-15 10:00:00', 'Cancelled'),
(5, 5, '2024-09-01 11:00:00', 'Cancelled');

INSERT INTO Medical_Records (patient_id, doctor_id, diagnosis, prescription, treatment_date, admission_date, discharge_date) VALUES
(1, 1, 'Hypertension',           'Amlodipine 5mg daily',       '2025-01-10', '2025-01-10', '2025-01-12'),
(2, 2, 'Migraine',               'Sumatriptan 50mg as needed', '2025-01-12', '2025-01-12', '2025-01-13'),
(3, 3, 'Acne Vulgaris',          'Isotretinoin 20mg',          '2025-01-15', NULL, NULL),
(5, 1, 'Coronary Artery Disease','Aspirin + Atorvastatin',     '2025-02-05', '2025-02-05', '2025-02-10'),
(6, 5, 'Viral Fever',            'Paracetamol + Rest',         '2025-02-10', NULL, NULL),
(1, 7, 'Arrhythmia',             'Beta blockers',              '2025-03-01', '2025-03-01', '2025-03-04'),
(9, 2, 'Epilepsy',               'Levetiracetam 500mg',        '2025-03-10', '2025-03-10', '2025-03-15'),
(2, 1, 'Chest Pain',             'ECG + further tests',        '2025-03-15', NULL, NULL),
(1, 1, 'Follow-up Hypertension', 'Continue medication',        '2025-04-01', NULL, NULL),
(5, 1, 'Angina',                 'Nitroglycerin',              '2025-04-05', '2025-04-05', '2025-04-08'),
(9, 2, 'Follow-up Epilepsy',     'Dose adjustment',            '2025-04-10', NULL, NULL),
(1, 7, 'Cardiac Checkup',        'Lifestyle advice',           '2025-04-15', NULL, NULL);

INSERT INTO Billing (patient_id, appointment_id, amount, payment_status, payment_date) VALUES
(1, 1,  1500.00, 'Paid',    '2025-01-10'),
(2, 2,  1800.00, 'Paid',    '2025-01-12'),
(3, 3,  1200.00, 'Paid',    '2025-01-15'),
(5, 5,  2500.00, 'Paid',    '2025-02-05'),
(6, 6,  1000.00, 'Pending', NULL),
(1, 8,  1600.00, 'Paid',    '2025-03-01'),
(9, 10, 1800.00, 'Paid',    '2025-03-10'),
(2, 11, 1500.00, 'Paid',    '2025-03-15'),
(4, 4,  1400.00, 'Pending', NULL),
(8, 9,  1200.00, 'Pending', NULL);

-- ========== 1. CRUD ==========

INSERT INTO Patients (name, dob, gender, phone_number, email, address)
VALUES ('Test Patient', '1995-05-05', 'Male', '9999999999', 'test@email.com', 'Test Address');

INSERT INTO Doctors (name, specialization, phone_number, email, available_days, consultation_fee, years_of_experience)
VALUES ('Dr. Test Doctor', 'General Medicine', '8888888888', 'testdr@hospital.com', 'Mon,Fri', 800.00, 3);

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status)
VALUES (11, 9, '2026-01-10 10:00:00', 'Scheduled');

UPDATE Patients SET address = 'New Updated Address, Mumbai' WHERE patient_id = 1;

DELETE FROM Appointments
WHERE status = 'Cancelled'
  AND appointment_date < DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH);

-- ========== 2. WHERE, HAVING, LIMIT ==========

SELECT * FROM Patients
WHERE registration_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);

SELECT p.patient_id, p.name, SUM(b.amount) AS total_paid
FROM Patients p
JOIN Billing b ON p.patient_id = b.patient_id
WHERE b.payment_status = 'Paid'
GROUP BY p.patient_id, p.name
ORDER BY total_paid DESC
LIMIT 5;

SELECT * FROM Doctors WHERE consultation_fee > 1000;

-- ========== 3. AND, OR, NOT ==========

SELECT * FROM Appointments WHERE status = 'Scheduled' AND doctor_id = 3;

SELECT * FROM Doctors
WHERE specialization = 'Cardiology' OR specialization = 'Neurology';

SELECT * FROM Patients p
WHERE p.patient_id NOT IN (
    SELECT DISTINCT patient_id FROM Appointments
    WHERE appointment_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
);

-- ========== 4. ORDER BY, GROUP BY ==========

SELECT * FROM Doctors ORDER BY specialization;

SELECT d.doctor_id, d.name, COUNT(DISTINCT a.patient_id) AS patient_count
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name
ORDER BY patient_count DESC;

SELECT dept.department_name, SUM(b.amount) AS total_revenue
FROM Departments dept
JOIN Doctor_Department dd ON dept.department_id = dd.department_id
JOIN Doctors d ON dd.doctor_id = d.doctor_id
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.payment_status = 'Paid'
GROUP BY dept.department_name
ORDER BY total_revenue DESC;

-- ========== 5. Aggregates ==========

SELECT SUM(amount) AS total_revenue FROM Billing WHERE payment_status = 'Paid';

SELECT d.doctor_id, d.name, COUNT(a.appointment_id) AS visit_count
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_id, d.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT AVG(consultation_fee) AS average_consultation_fee FROM Doctors;

-- ========== 6. PK / FK verification ==========

SELECT mr.record_id, p.name AS patient_name, d.name AS doctor_name, mr.diagnosis
FROM Medical_Records mr
JOIN Patients p ON mr.patient_id = p.patient_id
JOIN Doctors d ON mr.doctor_id = d.doctor_id;

SELECT b.invoice_id, b.amount, a.appointment_date, p.name AS patient_name
FROM Billing b
LEFT JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Patients p ON b.patient_id = p.patient_id;

-- ========== 7. JOINS ==========

SELECT d.doctor_id, d.name AS doctor_name, d.specialization, dept.department_name
FROM Doctors d
INNER JOIN Doctor_Department dd ON d.doctor_id = dd.doctor_id
INNER JOIN Departments dept ON dd.department_id = dept.department_id;

SELECT p.patient_id, p.name, a.appointment_id, a.appointment_date, a.status
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id AND a.status = 'Completed'
WHERE a.appointment_id IS NOT NULL;

SELECT a.appointment_id, a.appointment_date, a.status, b.invoice_id, b.payment_status
FROM Billing b
RIGHT JOIN Appointments a ON b.appointment_id = a.appointment_id
WHERE b.invoice_id IS NULL;

SELECT p.patient_id, p.name, a.appointment_id
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL
UNION
SELECT p.patient_id, p.name, a.appointment_id
FROM Patients p
RIGHT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE p.patient_id IS NULL;

-- ========== 8. Subqueries ==========

SELECT doctor_id, name FROM Doctors
WHERE doctor_id IN (
    SELECT doctor_id FROM Appointments
    GROUP BY doctor_id
    HAVING COUNT(DISTINCT patient_id) > 2
);

SELECT patient_id, name, total_spent FROM (
    SELECT p.patient_id, p.name, SUM(b.amount) AS total_spent
    FROM Patients p
    JOIN Billing b ON p.patient_id = b.patient_id
    WHERE b.payment_status = 'Paid'
    GROUP BY p.patient_id, p.name
) AS spending
ORDER BY total_spent DESC
LIMIT 1;

SELECT a.* FROM Appointments a
WHERE a.doctor_id IN (
    SELECT doctor_id FROM Doctors WHERE specialization = 'Dermatology'
);

-- ========== 9. Date & Time ==========

SELECT MONTH(appointment_date) AS month_number,
       MONTHNAME(appointment_date) AS month_name,
       COUNT(*) AS visit_count
FROM Appointments
GROUP BY MONTH(appointment_date), MONTHNAME(appointment_date)
ORDER BY month_number;

SELECT record_id, patient_id, admission_date, discharge_date,
       DATEDIFF(discharge_date, admission_date) AS stay_duration_days
FROM Medical_Records
WHERE admission_date IS NOT NULL AND discharge_date IS NOT NULL;

SELECT record_id, patient_id, diagnosis,
       DATE_FORMAT(treatment_date, '%d-%m-%Y') AS formatted_treatment_date
FROM Medical_Records;

-- ========== 10. String functions ==========

SELECT patient_id, UPPER(name) AS name_uppercase, email FROM Patients;

SELECT doctor_id, TRIM(name) AS cleaned_name, specialization FROM Doctors;

SELECT patient_id, name, IFNULL(phone_number, 'Not Available') AS phone_number
FROM Patients;

-- ========== 11. Window functions ==========

SELECT d.doctor_id, d.name,
       COUNT(DISTINCT a.patient_id) AS patients_treated,
       RANK() OVER (ORDER BY COUNT(DISTINCT a.patient_id) DESC) AS doctor_rank
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id AND a.status = 'Completed'
GROUP BY d.doctor_id, d.name;

SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS monthly_revenue,
       SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS cumulative_revenue
FROM Billing
WHERE payment_status = 'Paid' AND payment_date IS NOT NULL
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;

SELECT appointment_id, patient_id, doctor_id, appointment_date,
       COUNT(*) OVER (ORDER BY appointment_date) AS running_total_appointments
FROM Appointments
ORDER BY appointment_date;

-- ========== 12. CASE ==========

SELECT p.patient_id, p.name,
       COUNT(mr.record_id) AS medical_record_count,
       CASE
           WHEN COUNT(mr.record_id) > 5 THEN 'High'
           WHEN COUNT(mr.record_id) BETWEEN 3 AND 5 THEN 'Medium'
           ELSE 'Low'
       END AS Patient_Risk_Level
FROM Patients p
LEFT JOIN Medical_Records mr ON p.patient_id = mr.patient_id
GROUP BY p.patient_id, p.name
ORDER BY medical_record_count DESC;

SELECT doctor_id, name, years_of_experience,
       CASE
           WHEN years_of_experience > 15 THEN 'Senior'
           WHEN years_of_experience BETWEEN 5 AND 15 THEN 'Mid-Level'
           ELSE 'Junior'
       END AS doctor_category
FROM Doctors
ORDER BY years_of_experience DESC;
