USE [Northwind]
GO
/****** Object:  StoredProcedure [dbo].[Vishal_GetProducts]    Script Date: 14-03-2023 17:01:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Vishal_GetProducts]
	-- Add the parameters for the stored procedure here
	@stock AS INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT * FROM Products p WHERE p.UnitsInStock = @stock OR @stock IS NULL;
END

EXECUTE Vishal_GetProducts;

SELECT * FROM products p 
SELECT * FROM Categories c



EXECUTE Vishal_GetProductCustomer 'Chai',NULL,null,null,0;
SELECT * FROM Products p
SELECT * FROM Categories c

DECLARE @ProductName AS NVARCHAR(20) = 'Chai';
DECLARE @CategoryName AS NVARCHAR(20) = NULL;
DECLARE @IncludDisContinued AS BIT = 0;
DECLARE @statusid AS INT = NULL;
SELECT 
	p.ProductName,
	c.CategoryName,
	(CASE
		WHEN p.UnitsInStock >100 THEN 'Bahut Hai'
		WHEN p.UnitsInStock > 50 AND p.UnitsInStock < 100 THEN 'Chalta Hai'
		WHEN p.UnitsInStock > 1 AND p.UnitsInStock < 50 THEN 'Mangana Padhega'
		ELSE 'Mar Gay'
	END) AS [Status],
	(CASE
		WHEN p.UnitsInStock >100 THEN 4
		WHEN p.UnitsInStock > 50 AND p.UnitsInStock < 100 THEN 3
		WHEN p.UnitsInStock > 1 AND p.UnitsInStock < 50 THEN 2
		ELSE 1
	END) AS [StatusId]
FROM 
	Products p INNER JOIN Categories c ON c.CategoryID = P.CategoryID 
WHERE 
		(@ProductName IS NULL OR p.ProductName = @ProductName OR CAST(p.ProductID AS NVARCHAR) = @ProductName)
		AND (c.CategoryName = @CategoryName OR @CategoryName IS NULL OR c.CategoryID = @CategoryName) 
		AND (p.Discontinued = @IncludDisContinued OR P.Discontinued = 0) AND (CASE
		WHEN p.UnitsInStock >100 THEN 4
		WHEN p.UnitsInStock > 50 AND p.UnitsInStock < 100 THEN 3
		WHEN p.UnitsInStock > 1 AND p.UnitsInStock < 50 THEN 2
		ELSE 1
	END = @statusid OR @statusid IS NULL);
			 
ALTER PROCEDURE Vishal_GetProductsCategory
	@ProductName AS NVARCHAR(20) ,@CategoryName AS NVARCHAR(20) ,@IncludDisContinued AS BIT,@statusid AS INT
AS
BEGIN
SELECT 
	p.ProductName,
	c.CategoryName,
	(CASE
		WHEN p.UnitsInStock >100 THEN 'Bahut Hai'
		WHEN p.UnitsInStock > 50 AND p.UnitsInStock < 100 THEN 'Chalta Hai'
		WHEN p.UnitsInStock > 1 AND p.UnitsInStock < 50 THEN 'Mangana Padhega'
		ELSE 'Mar Gay'
	END) AS [Status],
	(CASE
		WHEN p.UnitsInStock >100 THEN 4
		WHEN p.UnitsInStock > 50 AND p.UnitsInStock < 100 THEN 3
		WHEN p.UnitsInStock > 1 AND p.UnitsInStock < 50 THEN 2
		ELSE 1
	END) AS [StatusId]
FROM 
	Products p INNER JOIN Categories c ON c.CategoryID = P.CategoryID 
WHERE 
		(@ProductName IS NULL OR p.ProductName = @ProductName OR CAST(p.ProductID AS NVARCHAR) = @ProductName)
		AND (c.CategoryName = @CategoryName OR @CategoryName IS NULL OR c.CategoryID = @CategoryName) 
		AND (p.Discontinued = @IncludDisContinued OR P.Discontinued = 0) AND (CASE
		WHEN p.UnitsInStock >100 THEN 4
		WHEN p.UnitsInStock > 50 AND p.UnitsInStock < 100 THEN 3
		WHEN p.UnitsInStock > 1 AND p.UnitsInStock < 50 THEN 2
		ELSE 1
	END = @statusid OR @statusid IS NULL);

END

EXECUTE Vishal_GetProductsCategory 2,1,NULL,NULL

--2)

SELECT * FROM products p 
SELECT * FROM Categories c

DECLARE @ProductId AS NVARCHAR = '1,2,3';
DECLARE @CategoryId AS NVARCHAR = NULL;
DECLARE @Startdate AS DATE = '2021-01-02';
DECLARE @Enddate AS DATE = '2024-01-02';
DECLARE @ExpireMonth AS DATE = NULL;
SELECT 
	CONCAT(P.ProductName,' ',c.CategoryName) AS ProductName_CategoryName,
	p.UnitsInStock AS AvailableUnits,
	p.Discontinued AS IsNotAvailable,
	CASE
		WHEN p.ExpiryDate IS NULL THEN 'N/A'
		ELSE CONVERT(NVARCHAR,p.ExpiryDate,107)
	END AS ExpirayDate,
	CASE
		WHEN p.UnitsOnOrder < 10 THEN 1
		ELSE 0
	END AS NeedToOrder,
	CASE
		WHEN @startdate IS NOT NULL THEN 'Yes'
		WHEN @enddate IS NOT NULL THEN 'Yes'
		WHEN @startdate IS NULL AND @enddate IS NULL THEN 'N/A'
	END AS IsExpiring,
	CASE
		WHEN @ExpireMonth IS NOT NULL THEN @expireMonth
		ELSE GETDATE()
	END AS ExpiringThisMonth

FROM 
	Products p INNER JOIN Categories c ON P.CategoryID = c.CategoryID
WHERE
	(@ProductId IS NULL OR p.ProductID IN (SELECT Value FROM STRING_SPLIT('1 2 3',' ') )) 
	AND (@CategoryId IS NULL OR c.CategoryID IN (SELECT Value FROM STRING_SPLIT('1 2 3 4 5 6',' ')))

