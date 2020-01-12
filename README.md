# Pewlett-Hackard-Analysis
SQL

# Project Overview/Challenge

- Design ERD to see the relationship between the data. 
- Import CSV files to SQL database.
- Create tables and use different joins to create queries from the dataset.
- Create a table with number of employees retiring (include title).
- Filter the table to include the most recent titles. 
- Create a table with number of employees who is ready to be a mentor.

# Resources
Data Source: departments.csv, employees.csv, managers.csv, dept_emp.csv, titles.csv, salaries.csv.
Software: PgAdmin 4, Visual Studio Code, 1.40.2

# Summary
- Created ERD diagram to reference the connections between the csv files. (https://github.com/k389/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png).
- Imported and created tables for each csv file. 
- Determined the retirement information based on birthdate and hire date - retirement_info.csv.

| emp_no | first_name | last_name |
|--------|------------|-----------|
| 10001  | Georgi     | Facello   |
| 10004  | Chirstian  | Koblick   |
| 10009  | Sumant     | Peac      |
| 10018  | Kazuhide   | Peha      |

- Number of individuals retiring by title. Used partitioning to exclude duplicates and counted only most recent titles. 
- The retire_recenttitles.csv iclude the data and retire_counttitle includes the number of employees retiring by title.
- The data shows that there are many Senior Engineers and Senior Staff that are eligible to retire. 
- The data also shows that there are only 2 managers within the retirement age.  

| count | title              |
|-------|--------------------|
| 501   | Assistant Engineer |
| 4692  | Engineer           |
| 2     | Manager            |
| 15600 | Senior Engineer    |
| 14735 | Senior Staff       |
| 3837  | Staff              |
| 2013  | Technique Leader   |

- Created a list of mentors who where born in 1965. The mentor_info.csv file has all the mentors listed. 
- Created a count for each title for mentor lists.
- The request for mentors did not include the department, which was an addition. 
- The list also includes the department and counted the mentors by department and title. The retire_countmentor.csv has the information. 

| count | title              | dept_name          |
|-------|--------------------|--------------------|
| 3     | Engineer           | Customer Service   |
| 12    | Senior Engineer    | Customer Service   |
| 85    | Senior Staff       | Customer Service   |
| 25    | Staff              | Customer Service   |
| 3     | Technique Leader   | Customer Service   |
| 12    | Assistant Engineer | Development        |
| 110   | Engineer           | Development        |
| 268   | Senior Engineer    | Development        |
| 9     | Senior Staff       | Development        |
| 2     | Staff              | Development        |
| 34    | Technique Leader   | Development        |
| 61    | Senior Staff       | Finance            |
| 13    | Staff              | Finance            |
| 86    | Senior Staff       | Human Resources    |
| 21    | Staff              | Human Resources    |
| 104   | Senior Staff       | Marketing          |
| 22    | Staff              | Marketing          |
| 17    | Assistant Engineer | Production         |
| 64    | Engineer           | Production         |
| 233   | Senior Engineer    | Production         |
| 6     | Senior Staff       | Production         |
| 1     | Staff              | Production         |
| 35    | Technique Leader   | Production         |
| 1     | Assistant Engineer | Quality Management |
| 26    | Engineer           | Quality Management |
| 60    | Senior Engineer    | Quality Management |
| 10    | Technique Leader   | Quality Management |
| 6     | Engineer           | Research           |
| 13    | Senior Engineer    | Research           |
| 71    | Senior Staff       | Research           |
| 21    | Staff              | Research           |
| 2     | Technique Leader   | Research           |
| 210   | Senior Staff       | Sales              |
| 62    | Staff              | Sales              |

- The further analysis of the data set. 
	- One recommendation to the HR is analize the data to find out the salary for each postion. 
	- The salaries.csv table can provide an analysis the salary rate for each position needed. 







