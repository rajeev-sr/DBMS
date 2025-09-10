SELECT emp_name 
FROM Employees 
WHERE dept_id IN 
(
SELECT dept_id 
FROM Departments 
WHERE dept_name='Marketing'
);


SELECT emp_name,salary 
FROM Employees 
WHERE salary>(SELECT AVG(salary) FROM Employees);


SELECT emp_name 
FROM Employees 
WHERE emp_id 
IN (
SELECT emp_id FROM Assignments WHERE proj_id IN 
(SELECT proj_id FROM Projects WHERE proj_name='Project Phoenix'));


SELECT emp_name 
FROM Employees WHERE emp_id NOT IN (SELECT emp_id FROM Assignments);

SELECT emp_name 
FROM Employees 
WHERE salary > (
SELECT MIN(salary) 
FROM Employees 
WHERE dept_id IN (
SELECT dept_id 
FROM Departments 
WHERE dept_name = 'Marketing'
)
);



SELECT emp_name 
FROM Employees 
WHERE salary > (
SELECT MAX(salary) 
FROM Employees 
WHERE dept_id IN (
SELECT dept_id 
FROM Departments 
WHERE dept_name = 'Marketing'
)
);

SELECT emp_name,hire_date FROM Employees WHERE STRFTIME('%Y',hire_date)='2023';

SELECT emp_name FROM Employees WHERE manager_id IS NULL;

SELECT emp_name FROM Employees WHERE emp_name LIKE '% Smith' OR  emp_name LIKE '% Williams';


SELECT emp_name FROM Employees WHERE hire_date >=DATE('now','-2 Years');

SELECT e.emp_name,d.dept_name,e.salary FROM Employees e JOIN Departments d ON e.d
ept_id=d.dept_id WHERE e.salary=(SELECT MAX(salary) FROM Employees WHERE dept_id=e.dept_id);

SELECT emp_name FROM Employees WHERE dept_id IN 
(SELECT dept_id FROM Departments WHERE dept_name='Engineering') AND emp_id NOT IN 
(SELECT emp_id FROM Assignments WHERE proj_id IN 
(SELECT proj_id FROM Projects WHERE proj_name='Project Neptune'));

SELECT dept_name FROM Departments WHERE dept_id IN 
(SELECT dept_id FROM Employees GROUP BY dept_id HAVING AVG(salary)>(SELECT AVG(salary) FROM Employees));

ALTER TABLE Employees ADD COLUMN email TEXT;

UPDATE Employees SET email=LOWER(REPLACE(emp_name,' ','')||'engineering.com') WHERE dept_id IN (SELECT dept_id FROM Departments WHERE dept_name='Engineering');


CREATE TABLE HighEarners AS SELECT emp_id, emp_name FROM Employees WHERE salary > 95000;