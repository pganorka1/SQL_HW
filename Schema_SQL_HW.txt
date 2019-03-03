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
