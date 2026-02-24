-- ====================================================================================================
--                                  HOSPITAL MANAGEMENT SYSTEM
-- ====================================================================================================

CREATE DATABASE Hospital;

USE Hospital;

-- ========= TABLES ===================================================================================

CREATE TABLE Patients(
patient_id INT PRIMARY KEY,
name VARCHAR(50),
dob DATE,
gender VARCHAR(10),
phone_number VARCHAR(15),
email VARCHAR(50),
address VARCHAR(50),
registration_date DATE
);

CREATE TABLE Doctors(
doctor_id INT PRIMARY KEY,
name VARCHAR(50),
specialization VARCHAR(50),
consultation_fee DECIMAL(10,2),
experience_years INT
);

CREATE TABLE Departments(
department_id INT PRIMARY KEY,
department_name VARCHAR(50)
);

CREATE TABLE Doctor_Department(
doctor_id INT,
department_id INT,
FOREIGN KEY(doctor_id) REFERENCES Doctors(doctor_id)ON DELETE CASCADE,
FOREIGN KEY(department_id) REFERENCES Departments(department_id)ON DELETE CASCADE
);

CREATE TABLE Appointments(
appointment_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
appointment_date DATE,
status VARCHAR(20),
FOREIGN KEY(patient_id) REFERENCES Patients(patient_id)ON DELETE CASCADE,
FOREIGN KEY(doctor_id) REFERENCES Doctors(doctor_id)ON DELETE CASCADE
);

CREATE TABLE Medical_Records(
record_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
diagnosis VARCHAR(50),
prescription VARCHAR(50),
treatment_date DATE,
FOREIGN KEY(patient_id) REFERENCES Patients(patient_id)ON DELETE CASCADE,
FOREIGN KEY(doctor_id) REFERENCES Doctors(doctor_id)ON DELETE CASCADE
);

CREATE TABLE Billing(
invoice_id INT PRIMARY KEY,
patient_id INT,
appointment_id INT,
amount DECIMAL(10,2),
payment_status VARCHAR(20),
FOREIGN KEY(patient_id) REFERENCES Patients(patient_id)ON DELETE CASCADE,
FOREIGN KEY(appointment_id) REFERENCES Appointments(appointment_id)ON DELETE CASCADE
);

-- __________________________________INSERT VALUES_______________________________________ ///

INSERT INTO Patients VALUES
(1,'Rahul','2000-01-01','Male','111','a@gmail.com','Surat','2024-01-01'),
(2,'Priya','2001-02-01','Female','222','b@gmail.com','Surat','2024-02-01'),
(3,'Amit','2002-03-01','Male',NULL,'c@gmail.com','Baroda','2024-03-01'),
(4,'Neha','2000-04-01','Female','444','d@gmail.com','Rajkot','2024-04-01'),
(5,'Ravi','1999-05-01','Male','555','e@gmail.com','Surat','2024-05-01'),
(6,'Kiran','2001-06-01','Female','666','f@gmail.com','Ahmedabad','2024-06-01'),
(7,'Jay','2002-07-01','Male','777','g@gmail.com','Surat','2024-07-01'),
(8,'Nita','2000-08-01','Female','888','h@gmail.com','Vapi','2024-08-01'),
(9,'Arun','2001-09-01','Male','999','i@gmail.com','Surat','2024-09-01'),
(10,'Rina','2002-10-01','Female','101','j@gmail.com','Surat','2024-10-01');

INSERT INTO Doctors VALUES
(1,'Dr Amit','Cardiology',1000,10),
(2,'Dr Neha','Dermatology',800,6),
(3,'Dr Raj','Neurology',1200,18),
(4,'Dr Kiran','Dental',700,4),
(5,'Dr Ravi','Ortho',900,8),
(6,'Dr Jay','Eye',600,3),
(7,'Dr Nita','Skin',850,7),
(8,'Dr Arun','Heart',1500,20),
(9,'Dr Rina','ENT',750,5),
(10,'Dr Mehul','General',500,2);

INSERT INTO Departments VALUES
(1,'Cardiology'),
(2,'Dermatology'),
(3,'Neurology'),
(4,'Dental'),
(5,'Ortho'),
(6,'Eye'),
(7,'Skin'),
(8,'Heart'),
(9,'ENT'),
(10,'General');

INSERT INTO Doctor_Department VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO Appointments VALUES
(1,1,1,'2025-01-01','Completed'),
(2,2,2,'2025-01-02','Scheduled'),
(3,3,3,'2025-01-03','Completed'),
(4,4,4,'2025-01-04','Cancelled'),
(5,5,5,'2025-01-05','Completed'),
(6,6,6,'2025-01-06','Scheduled'),
(7,7,7,'2025-01-07','Completed'),
(8,8,8,'2025-01-08','Completed'),
(9,9,9,'2025-01-09','Scheduled'),
(10,10,10,'2025-01-10','Completed');

INSERT INTO Medical_Records VALUES
(1,1,1,'Fever','Med','2025-01-01'),
(2,2,2,'Skin','Cream','2025-01-02'),
(3,3,3,'Head','Tab','2025-01-03'),
(4,4,4,'Teeth','Cap','2025-01-04'),
(5,5,5,'Bone','Rest','2025-01-05'),
(6,6,6,'Eye','Drop','2025-01-06'),
(7,7,7,'Skin','Gel','2025-01-07'),
(8,8,8,'Heart','Test','2025-01-08'),
(9,9,9,'Ear','Drop','2025-01-09'),
(10,10,10,'Cold','Med','2025-01-10');

INSERT INTO Billing VALUES
(1,1,1,1000,'Paid'),
(2,2,2,800,'Pending'),
(3,3,3,1200,'Paid'),
(4,4,4,700,'Pending'),
(5,5,5,900,'Paid'),
(6,6,6,600,'Paid'),
(7,7,7,850,'Pending'),
(8,8,8,1500,'Paid'),
(9,9,9,750,'Paid'),
(10,10,10,500,'Pending');

-- ________________________________________ TASKS & FUNCTIONALITIES _______________________________________________

-- 1 CRUD --------------------------------------------------------------------------------------------------- >>>

INSERT INTO Patients VALUES (11,'Test','2000-01-01','Male','000','t@gmail.com','City','2025-01-01');
UPDATE Patients SET address='Delhi' WHERE patient_id=1;
DELETE FROM Appointments WHERE status='Cancelled';

-- 2 WHERE HAVING LIMIT -------------------------------------------------------------------------------------- >>>

SELECT * FROM Patients WHERE YEAR(registration_date)=2024;
SELECT patient_id,SUM(amount) FROM Billing GROUP BY patient_id ORDER BY SUM(amount) DESC LIMIT 5;
SELECT * FROM Doctors WHERE consultation_fee>1000;

-- 3 AND OR NOT ---------------------------------------------------------------------------------------------- >>>

SELECT * FROM Appointments WHERE status='Scheduled' AND doctor_id=2;
SELECT * FROM Doctors WHERE specialization='Cardiology' OR specialization='Neurology';
SELECT * FROM Patients WHERE patient_id NOT IN(SELECT patient_id FROM Appointments);

-- 4 ORDER BY GROUP BY --------------------------------------------------------------------------------------- >>>

SELECT * FROM Doctors ORDER BY specialization;
SELECT doctor_id,COUNT(*) FROM Appointments GROUP BY doctor_id;
SELECT department_id,COUNT(*) FROM Doctor_Department GROUP BY department_id;

-- 5 AGGREGATE ----------------------------------------------------------------------------------------------- >>>

SELECT SUM(amount) FROM Billing;
SELECT doctor_id,COUNT(*) FROM Appointments GROUP BY doctor_id ORDER BY COUNT(*) DESC LIMIT 1;
SELECT AVG(consultation_fee) FROM Doctors;

-- 6 KEYS CHECK ---------------------------------------------------------------------------------------------- >>>

SELECT * FROM Medical_Records;
SELECT * FROM Billing;

-- 7 JOINS --------------------------------------------------------------------------------------------------- >>>

SELECT d.name,dp.department_name FROM Doctors d
INNER JOIN Doctor_Department dd ON d.doctor_id=dd.doctor_id
INNER JOIN Departments dp ON dp.department_id=dd.department_id;

SELECT p.name,a.status FROM Patients p
LEFT JOIN Appointments a ON p.patient_id=a.patient_id;

SELECT * FROM Appointments a
RIGHT JOIN Doctors d ON a.doctor_id=d.doctor_id;

-- 8 SUBQUERY ---------------------------------------------------------------------------------------------- >>>

SELECT doctor_id FROM Appointments GROUP BY doctor_id HAVING COUNT(*)>1;
SELECT patient_id FROM Billing GROUP BY patient_id ORDER BY SUM(amount) DESC LIMIT 1;
SELECT * FROM Appointments WHERE doctor_id IN(SELECT doctor_id FROM Doctors WHERE specialization='Dermatology');

-- 9 DATE --------------------------------------------------------------------------------------------------- >>>

SELECT MONTH(appointment_date),COUNT(*) FROM Appointments GROUP BY MONTH(appointment_date);
SELECT DATEDIFF('2025-02-01','2025-01-01');
SELECT DATE_FORMAT(treatment_date,'%d-%m-%Y') FROM Medical_Records;

-- 10 STRING ------------------------------------------------------------------------------------------------- >>>

SELECT UPPER(name) FROM Patients;
SELECT TRIM(name) FROM Doctors;
SELECT IFNULL(phone_number,'Not Available') FROM Patients;

-- 11 WINDOW ------------------------------------------------------------------------------------------------- >>>

SELECT doctor_id, COUNT(*) , RANK() OVER(ORDER BY COUNT(*) DESC) FROM Appointments GROUP BY doctor_id;
SELECT invoice_id, SUM(amount) OVER(ORDER BY invoice_id) FROM Billing;
SELECT appointment_id, COUNT(*) OVER() FROM Appointments;

-- 12 CASE ---------------------------------------------------------------------------------------------------- >>>

SELECT patient_id, CASE WHEN COUNT(record_id)>5 THEN 'High'
WHEN COUNT(record_id)>=3 THEN 'Medium' ELSE 'Low'
END FROM Medical_Records GROUP BY patient_id;

SELECT name, CASE WHEN experience_years>15 THEN 'Senior'
WHEN experience_years>=5 THEN 'Mid'
ELSE 'Junior'
END FROM Doctors;