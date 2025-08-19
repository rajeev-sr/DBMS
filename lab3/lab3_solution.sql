-- lab3 Task(Rajeev Kumar 12341700)

--Part 1: Joins and Outer Joins
--1. List the names of all courses and the name of the faculty member who teaches each course.
SELECT c.cname,f.fname FROM Faculty f JOIN Courses c ON f.fid=c.instructor_fid;

--2. Find the names of all students who are enrolled in a course taught by ’Prof. Sharma’.
SELECT DISTINCT se.sname FROM (SELECT * FROM (SELECT * FROM Students s JOIN Enrolled e ON s.sid=e.sid) f JOIN Courses c ON f.cid=c.cid) se JOIN Faculty f ON se.instructor_fid=f.fid WHERE f.fname='Prof. Sharma';

--3. List all student names. If a student is enrolled in any course, also list the course name. Include students who are not enrolled in any course.
SELECT s.sname, c.cname FROM Students s LEFT JOIN Enrolled e ON s.sid=e.sid LEFT JOIN Courses c ON e.cid=c.cid;

--4. List all faculty members and the names of the courses they teach. Include faculty who are notcurrently teaching any course.
SELECT f.fname,c.cname FROM Faculty f LEFT JOIN Courses c ON f.fid=c.instructor_fid;

--Part 2: Advanced Conditions and Functions
--1. Find all students whose name contains the letter ’a’. The search should be case-insensitive.
SELECT sname FROM Students WHERE sname LIKE '%a%';

--2. Find the student ID and name for all students who do not have a discipline listed (i.e., their discipline is NULL).
SELECT sid,sname FROM Students WHERE discip IS NULL;

--3. List the names and registration dates of all students who registered in the year 2022.
SELECT sname,registration_date FROM Students WHERE STRFTIME('%Y',registration_date)='2022';

--4. Find the names of all students who registered in August 2022. Use the BETWEEN operator.
SELECT sname FROM Students WHERE registration_date BETWEEN '2022-08-01' AND '2022-08-31';

--Part 3: Subqueries and Set Operations
--1. Find the names of all students who have a GPA greater than the average GPA of all students. (Use a scalar subquery).
SELECT sname FROM Students WHERE gpa>(SELECT AVG(gpa) FROM Students);

--2. Find the names of all ’CSE’ students who are not enrolled in ’Databases’ (CSL303). Use the EXCEPT operator.
SELECT sname FROM Students WHERE discip = 'CSE' EXCEPT SELECT sname FROM Students WHERE sid IN (SELECT sid FROM Enrolled WHERE cid = 'CSL303');

--3. Find the names of all courses that have at least one student enrolled. Use a subquery with EXISTS.
SELECT cname FROM Courses WHERE EXISTS (SELECT * FROM Enrolled WHERE cid = Courses.cid);

--4. Find the names of students who have the highest GPA in their respective discipline. (Use a correlated subquery).
SELECT sname FROM Students WHERE gpa = (SELECT MAX(gpa) FROM Students WHERE discip = Students.discip);

--Part 4: Data Manipulation Language (DML)
--1. A new student has joined. Insert the following record into the Students table:
--• sid: 108
--• sname: ’Ravi’
--• discip: ’EE’
--• gpa: 8.0
--• registration date: ’2023-09-01’
INSERT INTO Students (sid, sname, discip, gpa, registration_date) VALUES (201, 'Ravi', 'EE', 8.0, '2023-09-01');

--2. ’Prof. Sharma’ has decided to give a 10% GPA boost to all students who received an ’A’ in ’Databases’ (CSL303). Write an UPDATE statement to reflect this change.
UPDATE Students SET gpa = gpa * 1.1 WHERE sid IN (SELECT sid FROM Enrolled WHERE cid = 'CSL303' AND grade = 'A');

--3. The ’Linear Algebra’ course (MAL251) has been cancelled. Delete all enrollment records for thiscourse.
DELETE FROM Enrolled WHERE cid = 'MAL251';
