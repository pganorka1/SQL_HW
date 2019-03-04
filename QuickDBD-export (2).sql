-- Exported from QuickDBD: https://www.quickdatatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/7lxMI5
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Data_Department" (
    "dept_no" CHAR   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_Data_Department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Data_Dept_Emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" CHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Data_Dept_Emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Data_Dept_Manager" (
    "dept_no" Integer   NOT NULL,
    "emp_no" Integer   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Data_Dept_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "Data_Employee" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(15)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Data_Employee" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Data_Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Data_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Data_Titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "Data_Dept_Emp" ADD CONSTRAINT "fk_Data_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Data_Employee" ("emp_no");

ALTER TABLE "Data_Dept_Emp" ADD CONSTRAINT "fk_Data_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Data_Department" ("dept_no");

ALTER TABLE "Data_Dept_Manager" ADD CONSTRAINT "fk_Data_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Data_Department" ("dept_no");

ALTER TABLE "Data_Dept_Manager" ADD CONSTRAINT "fk_Data_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Data_Employee" ("emp_no");

ALTER TABLE "Data_Salaries" ADD CONSTRAINT "fk_Data_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Data_Employee" ("emp_no");

ALTER TABLE "Data_Titles" ADD CONSTRAINT "fk_Data_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Data_Employee" ("emp_no");

SELECT * FROM "Data_Department";
SELECT * FROM "Data_Dept_Emp";
SELECT * FROM "Data_Dept_Manager";
SELECT * FROM "Data_Employee";
SELECT * FROM "Data_Salaries";
SELECT * FROM "Data_Titles";

--1 List the following details of each employee: employee number, last name, first name, gender, and salary

SELECT "Data_Employee".emp_no, "Data_Employee".last_name, "Data_Employee".first_name, "Data_Employee".gender, "Data_Salaries".salary
FROM "Data_Employee"
LEFT JOIN "Data_Salaries" ON "Data_Employee".emp_no = "Data_Salaries".emp_no
ORDER BY emp_no;

--2 List employees who were hired in 1986

SELECT emp_no, first_name, last_name, hire_date
FROM "Data_Employee"
WHERE hire_date
BETWEEN '1986-01-01' AND '1986-12-31';

--3 List the manager of each department with the following information: department number, department name,
 --the manager's employee number, last name, first name, and start and end employment dates.

SELECT "Data_Dept_Emp".dept_no, "Data_Department".dept_name, "Data_Dept_Emp".emp_no, "Data_Employee".last_name, "Data_Employee".first_name, "Data_Dept_Emp".from_date, "Data_Dept_Emp".to_date
FROM "Data_Dept_Manager","Data_Dept_Emp"
LEFT JOIN "Data_Department" ON "Data_Dept_Emp".dept_no = "Data_Department".dept_no
INNER JOIN "Data_Employee" ON "Data_Dept_Emp".emp_no = "Data_Employee".emp_no;

--4 List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT "Data_Employee".emp_no, "Data_Employee".last_name, "Data_Employee".first_name, "Data_Department".dept_name
FROM "Data_Employee"
LEFT JOIN "Data_Dept_Emp" ON "Data_Dept_Emp".emp_no = "Data_Employee".emp_no
LEFT JOIN "Data_Department" ON "Data_Department".dept_no = "Data_Dept_Emp".dept_no
ORDER BY "Data_Employee";

--5 List all employees whose first name is "Hercules" and last names begin with "B."

SELECT "Data_Employee".first_name, "Data_Employee".last_name
FROM "Data_Employee"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6 List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT "Data_Employee".emp_no, "Data_Employee".last_name, "Data_Employee".first_name, "Data_Department".dept_name
FROM "Data_Employee"
INNER JOIN  "Data_Dept_Emp" ON "Data_Dept_Emp".emp_no = "Data_Employee".emp_no
INNER JOIN "Data_Department" ON "Data_Dept_Emp".dept_no = "Data_Department".dept_no
WHERE dept_name = 'Sales';

--7 List all employees in the Sales and Development departments, including their employee number,
--last name, first name, and department name.

SELECT "Data_Employee".emp_no, "Data_Employee".last_name, "Data_Employee".first_name, "Data_Department".dept_name
FROM "Data_Employee"
INNER JOIN  "Data_Dept_Emp" ON "Data_Dept_Emp".emp_no = "Data_Employee".emp_no
INNER JOIN "Data_Department" ON "Data_Dept_Emp".dept_no = "Data_Department".dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT COUNT(emp_no) as "emp_count", last_name
FROM "Data_Employee"
GROUP BY last_name
ORDER BY emp_count desc;