-- lab2 Task(Rajeev Kumar)

-- Part 1: Simple Retrieval (SELECT, WHERE, ORDER BY)

-- 1. Find the names and Grades of all students in discipline ’Physics’.
SELECT sname,gpa FROM Students WHERE discipline='Physics' ;

-- 2. List the course names and their credit values for all courses worth 4 credits.
SELECT cname,credits FROM Courses WHERE credits=4 ;

-- 3. Retrieve the student ID and course ID for all enrollments where the grade is ’F’.
SELECT sid,cid FROM Enrolled WHERE grade='F';

-- 4. List all student names and their discipline, sorted alphabetically by discipline, and then by name for students in the same discipline.
SELECT sname,discipline from Students ORDER BY discipline,sname;


-- Part 2: Joins
-- 1. List the names of all students who are enrolled in ’Databases’ (CSL303).
SELECT Students.sname FROM Students JOIN Enrolled ON Students.sid=Enrolled.sid WHERE Enrolled.cid='CSL303';

-- 2. Find the names of all courses that ’Ben Taylor’ is enrolled in.
SELECT T.cid,Courses.cname FROM (SELECT * FROM Students AS st JOIN Enrolled AS en ON St.sid=en.sid WHERE st.sname='Ben Taylor') AS T JOIN Courses ON T.cid=Courses.cid;

-- 3. Show the name of each student and the name of each course they are enrolled in, along with their grade.
SELECT T.sname,Courses.cname,T.grade FROM (SELECT * FROM Students AS st JOIN Enrolled AS en ON St.sid=en.sid) AS T JOIN Courses ON T.cid=Courses.cid;

-- 4. List the names of all students who are not enrolled in any courses.
SELECT st.sname FROM Students AS st LEFT JOIN Enrolled AS en ON St.sid=en.sid WHERE en.cid IS NULL;

-- 5. Find the names of all students who received a ’B’ in a 3-credit course.
SELECT T.sname FROM (SELECT * FROM Students AS st JOIN Enrolled AS en ON St.sid=en.sid WHERE en.grade='B') AS T JOIN Courses ON T.cid=Courses.cid WHERE Courses.credits=3;


-- Part 3: Aggregation and Grouping
-- 1. For each discipline, find the number of students in it.
SELECT discipline,COUNT(*) FROM Students GROUP BY discipline ;

-- 2. Count the number of courses offered, grouped by the number of credits (i.e., how many 3-credit courses, 4-credit courses, etc.).
SELECT credits,COUNT(*) FROM Courses GROUP BY credits ;

-- 3. For each course, find the number of students enrolled. List the course name and the student count.
SELECT Courses.cname, COUNT(*) FROM Courses JOIN Enrolled ON Courses.cid==Enrolled.cid GROUP BY Courses.cname;

-- 4. Find the ‘cid‘ of all courses that have more than 2 students with a grade of ’A’.
SELECT cid FROM Enrolled WHERE grade == 'A' GROUP BY cid HAVING COUNT(*) > 2;


--Challenge: Subqueries and Complex Queries
-- 1. Students in 'Data Structures' (CSL211) - Subquery in WHERE
SELECT sname
FROM Students
WHERE sid IN (
    SELECT sid
    FROM Enrolled
    WHERE cid = 'CSL211'
);

-- 2. Courses with at least one student AND at least one F
SELECT cname
FROM Courses
WHERE cid IN (
    SELECT cid
    FROM Enrolled
    GROUP BY cid
    HAVING COUNT(sid) >= 1
       AND SUM(CASE WHEN grade = 'F' THEN 1 ELSE 0 END) >= 1
);

-- 3. Students in BOTH 'Intro to Programming' (CSL100) and 'Databases' (CSL303)
SELECT sname
FROM Students
WHERE sid IN (
    SELECT sid
    FROM Enrolled
    WHERE cid = 'CSL100'
)
AND sid IN (
    SELECT sid
    FROM Enrolled
    WHERE cid = 'CSL303'
);

