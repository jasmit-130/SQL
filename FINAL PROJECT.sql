CREATE DATABASE UNIVERSITY;

USE UNIVERSITY;

-- ------------------------------------------------ TABLE 1 DEPARTMENTS TABLE --------------------------------------------

CREATE TABLE DEPARTMENTS(
	DEPARTMENT_ID INT PRIMARY KEY,
	DEPARTMENT_NAME VARCHAR(200) unique NOT NULL
);

INSERT INTO DEPARTMENTS VALUES
(1, 'MATHEMATICS'),
(2, 'Information Technology'),
(3, 'MATHEMATICS'),
(4, 'Artificial Intelligence'),
(5, 'MATHEMATICS'),
(6, 'MATHEMATICS'),
(7, 'MATHEMATICS'),
(8, 'Civil'),
(9, 'Cyber Security'),
(10, 'MATHEMATICS');

-- ------------------------------------------------ TABLE 2 STUDENTS TABLE -----------------------------------------------

CREATE TABLE STUDENTS(
	STUDENT_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	EMAIL VARCHAR(50) UNIQUE ,
	BIRTH_DATE DATE,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
	ENROLMENT_DATE DATE NOT NULL
);

INSERT INTO STUDENTS VALUES
(1, 'Amit', 'Sharma', 'amit@gmail.com', '2001-05-12', '2020-07-01'),
(2, 'Neha', 'Patel', 'neha@gmail.com', '2002-08-22', '2020-07-01'),
(3, 'Rahul', 'Verma', 'rahul@gmail.com', '2000-03-18', '2019-07-01'),
(4, 'Priya', 'Singh', 'priya@gmail.com', '2001-11-05', '2020-07-01'),
(5, 'Karan', 'Mehta', 'karan@gmail.com', '1999-09-09', '2018-07-01'),
(6, 'Pooja', 'Joshi', 'pooja@gmail.com', '2002-01-25', '2021-07-01'),
(7, 'Rohit', 'Kumar', 'rohit@gmail.com', '2001-06-30', '2020-07-01'),
(8, 'Sneha', 'Desai', 'sneha@gmail.com', '2003-04-14', '2022-07-01'),
(9, 'Arjun', 'Rana', 'arjun@gmail.com', '2000-12-02', '2019-07-01'),
(10, 'Nisha', 'Kapoor', 'nisha@gmail.com', '2002-10-10', '2021-07-01');

-- ------------------------------------------------ TABLE 2 COURSES TABLE ----------------------------------------------

CREATE TABLE COURSES(
	COURSE_ID INT PRIMARY KEY,
	COURSE_NAME VARCHAR(50) NOT NULL,
	DEPARTMENT_ID INT,
	CREDITS int CHECK (CREDITS > 0),

	FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)  ON DELETE CASCADE

);

INSERT INTO COURSES VALUES
(101, 'Database Systems', 1, 4),
(102, 'Operating Systems', 2, 4),
(103, 'Computer Networks', 3, 3),
(104, 'Data Structures', 1, 4),
(105, 'Software Engineering', 2, 3),
(106, 'Web Development', 1, 3),
(107, 'Artificial Intelligence', 4, 4),
(108, 'Machine Learning', 4, 4),
(109, 'Cyber Security', 3, 3),
(110, 'Cloud Computing', 5, 3);

-- ------------------------------------------------ TABLE 3 INSTRUCTORS ------------------------------------------------------

CREATE TABLE INSTRUCTORS(
	INSRUCTOR_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	EMAIL VARCHAR(50) UNIQUE,
    SALARY DECIMAL(10,2),
	DEPARTMENT_ID INT,
    
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID) ON DELETE SET NULL
);

INSERT INTO INSTRUCTORS VALUES
(1, 'Ramesh', 'Iyer', 'ramesh@college.com', 1),
(2, 'Sunita', 'Patel', 'sunita@college.com', 2),
(3, 'Anil', 'Shah', 'anil@college.com', 3),
(4, 'Kavita', 'Mehta', 'kavita@college.com', 4),
(5, 'Suresh', 'Nair', 'suresh@college.com', 5),
(6, 'Neeraj', 'Gupta', 'neeraj@college.com', 6),
(7, 'Pankaj', 'Verma', 'pankaj@college.com', 7),
(8, 'Deepa', 'Kulkarni', 'deepa@college.com', 8),
(9, 'Aakash', 'Malhotra', 'aakash@college.com', 9),
(10, 'Rekha', 'Rao', 'rekha@college.com', 10);

-- ------------------------------------------------ TABLE 4 ENROLLMENTS ---------------------------------------------------

CREATE TABLE ENROLLMENTS(
	ENROLLMENT_ID INT PRIMARY KEY,
	STUDENT_ID INT,
	COURSE_ID INT,
	ENROLLMENT_DATE date,
	FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID) on delete cascade,
	FOREIGN KEY (COURSE_ID) REFERENCES COURSES(COURSE_ID) on delete cascade
);

INSERT INTO ENROLLMENTS VALUES
(1, 1, 101, '2020-07-05'),
(2, 2, 102, '2020-07-06'),
(3, 3, 103, '2019-07-07'),
(4, 4, 104, '2020-07-05'),
(5, 5, 105, '2018-07-08'),
(6, 6, 106, '2021-07-10'),
(7, 7, 107, '2020-07-12'),
(8, 8, 108, '2022-07-15'),
(9, 9, 109, '2019-07-16'),
(10, 10, 110, '2021-07-18');

-- ------------------------------------------------ QUERIES TO PERFORM ---------------------------------------------------


-- 1. CRUD OPERATIONS ----------------------------------------------------------------------------------------------------

SELECT FIRST_NAME FROM STUDENTS;
SELECT COURSE_NAME , CREDITS FROM COURSES;
SELECT * FROM INSTRUCTORS WHERE INSRUCTOR_ID > 3 ;
SELECT * FROM ENROLLMENTS;
SELECT * FROM DEPARTMENTS;

UPDATE STUDENTS SET EMAIL = 'USER130@GMAIL.COM' WHERE STUDENT_ID = 3;

TRUNCATE STUDENTS;
TRUNCATE COURSES;
DELETE FROM INSTRUCTORS  ;
DELETE FROM STUDENTS WHERE STUDENT_ID = 2;
TRUNCATE DEPARTMENTS;
DROP TABLE DEPARTMENTS;

-- 2. STUDENT ENROLLED AFTR 2022 ---------------------------------------------------------------------------------------------------------------

SELECT * FROM STUDENTS WHERE ENROLMENT_DATE > 2022-01-01;

-- 3. COURSES OFFERED BY METHIMATICS DEPARTMENT -----------------------------------------------------------------------------------------------------------

SELECT * FROM COURSES C 
JOIN DEPARTMENTS D ON C.DEPARTMENT_ID = D.DEPARTMENT_ID WHERE D.DEPARTMENT_NAME = 'MATHEMATICS' LIMIT 5;

-- 4. GET NUMBER OF STUDENTS PER CIURSE  ---------------------------------------------------------------------------------------------------------

SELECT *, COUNT(STUDENT_ID) AS TOTAL_STUDENTS
FROM ENROLLMENTS GROUP BY COURSE_ID HAVING COUNT(STUDENT_ID) > 5;

-- 5. STUDENTS ENROLLED IN DATA STRUCTURE AND DATABASE SYSTEM

SELECT * FROM STUDENTS S
JOIN ENROLLMENTS E ON S.STUDENT_ID = E.STUDENT_ID
JOIN COURSES C ON E.COURSE_ID = C.COURSE_ID
WHERE C.COURS_NAME IN ('DATA STRUCTURES','DATA SYSTEMS') GROUP BY S.STUDENT_ID , S.FIRST_NAME , S.LAST_NAME HAVING COUNT(DISTINCT C.COURSE_NAME) = 2; 

-- 6. Students enrolled in Data Structures OR Database Systems

SELECT DISTINCT S.* FROM STUDENTS S
JOIN ENROLLMENTS E ON S.STUDENT_ID = E.STUDENT_ID
JOIN COURSES C ON E.COURSE_ID = C.COURSE_ID WHERE C.COURSE_NAME IN ('Data Structures', 'Database Systems');
 
-- 7. Average Credits

SELECT AVG(CREDITS) AS AVERAGE_CREDITS FROM COURSES;

-- 8. Maximum salary in Computer Science

SELECT MAX(I.SALARY) AS MAX_SALARY FROM INSTRUCTORS I JOIN DEPARTMENTS D 
ON I.DEPARTMENT_ID = D.DEPARTMENT_ID WHERE D.DEPARTMENT_NAME = 'Computer Science';

-- 9. Count students in each department

SELECT D.DEPARTMENT_NAME, COUNT(E.STUDENT_ID) AS TOTAL_STUDENTS FROM ENROLLMENTS E
JOIN COURSES C ON E.COURSE_ID = C.COURSE_ID
JOIN DEPARTMENTS D ON C.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY D.DEPARTMENT_NAME;

-- 10. INNER JOIN

SELECT S.FIRST_NAME, S.LAST_NAME, C.COURSE_NAME FROM STUDENTS S
INNER JOIN ENROLLMENTS E ON S.STUDENT_ID = E.STUDENT_ID
INNER JOIN COURSES C ON E.COURSE_ID = C.COURSE_ID;

-- 11. LEFT JOIN

SELECT S.FIRST_NAME, S.LAST_NAME, C.COURSE_NAME FROM STUDENTS S
LEFT JOIN ENROLLMENTS E ON S.STUDENT_ID = E.STUDENT_ID
LEFT JOIN COURSES C ON E.COURSE_ID = C.COURSE_ID;

-- 12. Subquery – Students enrolled in courses with more than 10 students

SELECT S.STUDENT_ID,S.FIRST_NAME,S.LAST_NAME FROM STUDENTS S WHERE S.STUDENT_ID IN (
        SELECT E.STUDENT_ID FROM ENROLLMENTS E WHERE E.COURSE_ID IN (
                SELECT COURSE_ID FROM ENROLLMENTS GROUP BY COURSE_ID HAVING COUNT(STUDENT_ID) > 10
        )
);


-- 13. Extract Year

SELECT STUDENT_ID, YEAR(ENROLMENT_DATE) AS ENROLLMENT_YEAR FROM STUDENTS;

-- 14. Concatenate Instructor Name

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME FROM INSTRUCTORS;

-- 15. Running Total

SELECT COURSE_ID, COUNT(STUDENT_ID) AS STUDENT_COUNT, SUM(COUNT(STUDENT_ID)) 
OVER (ORDER BY COURSE_ID) AS RUNNING_TOTAL
FROM ENROLLMENTS GROUP BY COURSE_ID;

-- 16. Label Senior / Junior

SELECT STUDENT_ID,FIRST_NAME,LAST_NAME,ENROLMENT_DATE,
       CASE 
           WHEN TIMESTAMPDIFF(YEAR, ENROLMENT_DATE, CURDATE()) > 4
                THEN 'Senior'
           ELSE 'Junior'
       END AS STATUS
FROM STUDENTS;







