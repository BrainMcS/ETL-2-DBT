# ETL-2-DBT Project

A data transformation project using dbt (data build tool) with PostgreSQL for handling customer and order data.

## Project Overview

This project demonstrates an ETL (Extract, Transform, Load) pipeline using dbt for data transformation. It includes a PostgreSQL database setup with sample customer and order data.

## Database Structure

The project includes two main tables in the `raw_data` schema:

### Orders Table
- Contains order information including:
  - Order ID
  - Customer ID
  - Order Date
  - Shipping Address
  - Status (pending/completed/shipped/cancelled)
  - Payment Method
  - Total Amount

### Customers Table
- Contains customer information including:
  - Customer ID
  - First Name
  - Last Name
  - Email
  - Country Code
  - Phone Number
  - Registration Date
  - Created/Updated Timestamps

### Structure
ETTL-2-DBT/
├── profiles/
│   └── profiles.yml
├── models/
│ ├── staging/ # Models for normalizing raw data
│ │ ├── staging_customers.sql
│ │ ├── staging_orders.sql
│ ├── intermediate/ # Models for intermediate transformations
│ │ └── intermediate_customer_orders.sql 
│ ├── analytics/ # Models for final analyses
│ │ └── analytics_customer_segments.sql 
│ └── my_first_dbt_model.sql # Starter model example
│ └──sources/ # Data source configurations
│  └── sources.yml
├── dbt_project.yml # Main project configuration file
└── README.md

## Setup

### Virtual Environment
1. Create a virtual environment (if not already created):
```bash
python -m venv dbt-env
```

### Prerequisites
1. Ensure you have Docker installed on your system
2. Ensure you have Docker Compose installed
3. Clone this repository
4. Navigate to the project directory

### Running with Docker

1. Build the Docker image:
```bash
docker build -t etl-2-dbt .
```

2. Build and start the containers:
```bash
docker-compose up --build -d
```

## Database Initialization

The database is initialized with:
- Creation of necessary users (postgres, dbt)
- Setup of raw_data schema
- Creation of tables (orders, customers)
- Sample data insertion

## Database Access

### PostgreSQL CLI Access
To connect to the database using psql:
```bash
PGPASSWORD=dbt docker-compose exec postgres psql -U dbt -h postgres -p 5432 -d dbt_database
```
To visualize the results of the dbt run:
```bash
SELECT * FROM public_analytics.analytics_customer_segments;
```