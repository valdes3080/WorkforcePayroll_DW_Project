# Project Summary


The Workforce & Payroll Analytics Warehouse is an end-to-end data project that models HR and payroll operations in a normalized relational database, then transforms that data into a dimensional warehouse for reporting. The project is designed to analyze labor cost trends, overtime usage, headcount changes, and employee turnover. It includes an OLTP layer, staging layer, star schema warehouse, and reporting layer. The goal is to show the difference between transactional and analytical systems in a realistic business scenario.

# Business Statement
A company stores employee, timesheet, and payroll data in operational tables, but leadership cannot easily analyze workforce trends, department labor costs, overtime usage, or employee movement over time.


# S.T.A.R.
-Situation: HR and payroll data exists operationally, but business users cannot easily analyze labor cost and workforce trends.
-Task: Build a system that separates transactional processing from analytical reporting.
-Action: Design an OLTP model, staging layer, dimensional warehouse, and reports.
-Result: Leadership can analyze payroll cost, overtime, and workforce changes using 
