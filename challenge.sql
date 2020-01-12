-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(25) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no, title, from_date)
);
-- Selecting the tables
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp
SELECT * FROM titles

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Challenge 
-- Create a new table an INNER JOIN that contains employee #, Fname and Lname from employee table, 
	--title and from_date from titles table and salary from salaries table.
SELECT e.emp_no, e.first_name, e.last_name, titles.title, titles.from_date, s.salary
INTO retire_titles
FROM employees AS e
INNER JOIN titles
	ON (e.emp_no = titles.emp_no)
INNER JOIN salaries AS s
	ON (e.emp_no = s.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retire_titles;

-- Exclude the rows of data containing duplicate names and keep only the most recent titles.
CREATE TABLE retire_recenttitles as (
	WITH retire_titles AS
(
	SELECT emp_no, first_name, last_name, title, from_date, salary,
		 ROW_NUMBER() OVER
	(PARTITION BY (emp_no, first_name, last_name) ORDER BY from_date DESC) AS rnum
		  FROM retire_titles
		  ) 
SELECT * FROM retire_titles WHERE rnum = 1);

SELECT * FROM retire_recenttitles;

-- title count by employee number
SELECT COUNT(rr.emp_no), rr.title
INTO retire_counttitle
FROM retire_recenttitles as rr
GROUP BY rr.title
ORDER BY rr.title;

SELECT * FROM retire_counttitle

-- Create the table for Mentor Information.
SELECT e.emp_no, e.first_name, e.last_name, titles.title, titles.from_date, titles.to_date, d.dept_name
INTO mentor_info
FROM employees as e
INNER JOIN titles
ON (e.emp_no = titles.emp_no)
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (titles.to_date = '9999-01-01');

SELECT * FROM mentor_info
ORDER BY dept_name DESC, emp_no ASC;

--Mentor title count by department
SELECT COUNT(mi.emp_no), mi.title, mi.dept_name
INTO retire_countmentor
FROM mentor_info as mi
GROUP BY mi.title, mi.dept_name 
ORDER BY mi.dept_name, mi.title;

SELECT * FROM retire_countmentor;

-- Partition and count the titles in one code.
Create table mostrecent_challenge as (
select title, COUNT(emp_no) as num_cnt FROM
(SELECT emp_no, first_name, last_name, first_name, title, from_date, salary,
    ROW_NUMBER() OVER
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
  FROM retire_titles
 )
 tmp WHERE rn = 1
 GROUP BY title);

SELECT * FROM mostrecent_challenge;

rollback
commit