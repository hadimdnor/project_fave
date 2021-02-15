CREATE DATABASE employees_db;

\c employees_db;

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    submission_time TIMESTAMP,
    name TEXT,
    annual_salary FLOAT,
    monthly_income_tax FLOAT
);

\dt