-- ---------------------------------------------------------
-- STUDENT RESULT MANAGEMENT SYSTEM (FULL SQL PROJECT)
-- ---------------------------------------------------------

-- 1️⃣ CREATE DATABASE
CREATE DATABASE StudentResultDB;
USE StudentResultDB;

-- 2️⃣ CREATE TABLES
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    year INT
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT CHECK (marks >= 0 AND marks <= 100),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- 3️⃣ INSERT SAMPLE STUDENT DATA
INSERT INTO Students VALUES
(1, 'Aishwarya', 'ECE', 3),
(2, 'Karthik', 'CSE', 2),
(3, 'Priya', 'IT', 1),
(4, 'Vijay', 'EEE', 4);

-- 4️⃣ INSERT SUBJECT DATA
INSERT INTO Subjects VALUES
(101, 'Mathematics'),
(102, 'Physics'),
(103, 'Computer Science'),
(104, 'Digital Electronics');

-- 5️⃣ INSERT MARKS DATA
INSERT INTO Marks VALUES
(1, 1, 101, 92),
(2, 1, 102, 88),
(3, 1, 103, 95),
(4, 2, 101, 70),
(5, 2, 103, 75),
(6, 3, 104, 85),
(7, 3, 101, 78),
(8, 4, 102, 90),
(9, 4, 103, 82);

-- ---------------------------------------------------------
-- 6️⃣ IMPORTANT QUERIES (FOR GITHUB HIGHLIGHTS)
-- ---------------------------------------------------------

-- ⭐ 1. View all students
SELECT * FROM Students;

-- ⭐ 2. View all marks with student names and subjects
SELECT s.name, sub.subject_name, m.marks
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id;

-- ⭐ 3. Calculate total marks for each student
SELECT s.student_id, s.name, SUM(m.marks) AS total_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.student_id;

-- ⭐ 4. Calculate average marks
SELECT s.student_id, s.name, AVG(m.marks) AS average_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.student_id;

-- ⭐ 5. Find topper (highest total score)
SELECT s.student_id, s.name, SUM(m.marks) AS total_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.student_id
ORDER BY total_marks DESC
LIMIT 1;

-- ⭐ 6. Subject-wise average marks
SELECT sub.subject_name, AVG(m.marks) AS avg_marks
FROM Marks m
JOIN Subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_name;

-- ⭐ 7. Students scoring above 90 in any subject
SELECT s.name, sub.subject_name, m.marks
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
WHERE m.marks > 90;

-- ⭐ 8. Department-wise performance
SELECT department, AVG(marks) AS dept_average
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY department;

-- ---------------------------------------------------------
-- END OF PROJECT
-- ---------------------------------------------------------