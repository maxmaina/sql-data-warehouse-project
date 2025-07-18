/*
============================================================
Create Database and Schemas
============================================================
Script Purpose:
	This script creates a new database named 'DataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the scipt sets up three schemas
	within tge database: 'bronze', 'silver', and 'gold'.

WARNING:
	Running this script will drop the entire 'DataWarehoue' database if it exists. 
	All data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.
*/

--Use Maseter
USE master;
GO
-- Drop and recreate the 'Datawarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO 

-- Create Database 'DataWarehouse' 
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
