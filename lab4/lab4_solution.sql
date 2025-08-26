CREATE TABLE enrolled (
    student_id INT,
    course_id INT,
    grade TEXT,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO enrolled (student_id, course_id, grade)
SELECT student_id, course_id, grade
FROM Enrollments;

UPDATE Students
SET department = 'Philosophy'
WHERE name LIKE '%i%';


ALTER TABLE Students
ADD COLUMN email TEXT;

UPDATE Students
SET email = name || '@iitbhilai.ac.in';

SELECT name FROM Students
WHERE department = 'Computer Science';

SELECT name FROM Students
WHERE name IN (SELECT course_name FROM Courses);

SELECT s.name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
ORDER BY c.course_name;

SELECT s.name, c.course_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_id = c.course_id;

SELECT name FROM Students
WHERE name LIKE 'A%';

SELECT name 
FROM Students 
WHERE student_id IN (SELECT e.student_id FROM Enrollments e JOIN Courses c ON e.course_id=c.course_id WHERE credits>3); 

SELECT name 
FROM Students 
WHERE student_id NOT IN (SELECT student_id FROM Enrollments);