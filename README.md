# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository!
This project demonstrates data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project that highlights industry best practices in data engineering and analytics.

---

## Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consildate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanses and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and anlytics teams.

---

### BI: Analytics & Reporting (Data Analytics)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decsion-making.

---

### Data Architecture

The data architecture for this project follows Medallion Architecture, **Bronze**, **Silver**, and **Gold** layers:
![Alt text](docs/data_architecture.png)

1. **Bronze Layer**: Stores raw data as-is from the source sytems. Data is ingested from CSV Files into SQL Server
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processess to prepare data for analysis.
3. **Gold** Layer: Houses the business-ready data modeled into a start schema required for reporting and analysis.

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution

## About Me

Hello! I'm **Max Maina**.  I am a Data Analyst with hands-on experience in SQL, Python, and Power BI, seeking to leverage analytical skills and business acumen to drive data-informed decisions in a growth-oriented organization. Passionate about uncovering patterns and delivering data-driven solutions, I am committed to continuous learning and applying innovative approaches to solve complex problems.
