create database MedicalInventory;
select * from MedicalInventory.pharmacydata;

SELECT 
    Dept, 
    SUM(Final_sales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    Dept
ORDER BY 
    total_sales DESC;
    
SELECT 
    SubCat, 
    SUM(Final_sales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    SubCat
ORDER BY 
    total_sales DESC;
    
SELECT 
    SubCat1, 
    SUM(Final_sales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    SubCat1
ORDER BY 
    total_sales DESC;

SELECT 
    formulation, 
    SUM(Final_sales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    formulation
ORDER BY 
    total_sales DESC;
    
ALTER TABLE pharmacydata
ADD COLUMN Dateofbill_datetime DATETIME;
SET SQL_SAFE_UPDATES = 0;
UPDATE pharmacydata
SET Dateofbill_datetime = STR_TO_DATE(Dateofbill, '%m/%d/%Y');

UPDATE pharmacydata
SET formulation = 0
WHERE formulation IS NULL;

UPDATE pharmacydata
SET DrugName = 0
WHERE DrugName IS NULL;

UPDATE pharmacydata
SET SubCat = 0
WHERE SubCat IS NULL;

UPDATE pharmacydata
SET SubCat1 = 0
WHERE SubCat1 IS NULL;


ALTER TABLE pharmacydata
ADD COLUMN Grosscost DECIMAL(10, 2);

UPDATE pharmacydata
SET Grosscost = Quantity * Final_cost;

ALTER TABLE pharmacydata
ADD COLUMN GrossSales DECIMAL(10, 2);

UPDATE pharmacydata
SET GrossSales = Quantity * Final_Sales;

SELECT 
    Dept, 
    SUM(GrossSales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    Dept
ORDER BY 
    total_sales DESC;
    
SELECT 
    SubCat, 
    SUM(GrossSales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    Subcat
ORDER BY 
    total_sales DESC;
    
SELECT 
    SubCat1, 
    SUM(GrossSales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    Subcat1
ORDER BY 
    total_sales DESC;
    
SELECT 
    Formulation, 
    SUM(GrossSales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    Formulation
ORDER BY 
    total_sales DESC;

SELECT 
    EXTRACT(MONTH FROM Dateofbill_datetime) AS month, 
    SUM(GrossSales) AS total_sales
FROM 
    pharmacydata
WHERE 
    Typeofsales = 'Sale'
GROUP BY 
    month
ORDER BY 
    month;
    
    