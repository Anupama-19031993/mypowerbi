-- MoMA Artwork Database Project - Digital Humanities Domain

-- 1. Create Database
CREATE DATABASE MoMA_ArtDB;
GO
USE MoMA_ArtDB;
GO
--Import the data into SQL Server using the SQL Server Import and Export Wizard, 
--which automatically created corresponding tables (Artists_cleaned, newartwrksmodifired) in the database.
--The Excel sheet was read as a table, and the CSV file was mapped to a structured SQL table during import.
--Data types were adjusted (e.g., INT for years, NVARCHAR for text fields).
--Nulls and formatting issues were cleaned prior to analysis.

--Part A- Recommended Analysis (in SQL)


-- 4.1 How modern are the artworks at the Museum?
SELECT 
    Date,
    COUNT(*) AS ArtworkCount
FROM [dbo].[newartwrksmodifired]
GROUP BY Date
ORDER BY Date;
GO

-- 4.2 Which artists are featured the most?
SELECT 
    A.DisplayName,
    COUNT(*) AS NumOfArtworks
FROM Artists_Cleaned A
JOIN newartwrksmodifired AW ON A.ArtistID = AW.ArtistID
GROUP BY A.DisplayName
ORDER BY NumOfArtworks DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
GO

-- 4.3 Are there any trends in the dates of acquisition?
SELECT 
    YEAR(DateAcquired) AS AcquisitionYear,
    COUNT(*) AS NumAcquired
FROM [dbo].[newartwrksmodifired]
WHERE DateAcquired IS NOT NULL
GROUP BY YEAR(DateAcquired)
ORDER BY AcquisitionYear;
GO

-- 4.4 What types of artwork are most common?
SELECT 
    Classification,
    COUNT(*) AS Count
FROM [dbo].[newartwrksmodifired]
GROUP BY Classification
ORDER BY Count DESC;
GO
-- 4.5 Gender Representation in Art Collection (Recommended Analysis)
SELECT 
    Gender,
    COUNT(*) AS NumArtists
FROM [dbo].[Artists_Cleaned]
WHERE Gender IS NOT NULL
GROUP BY Gender
ORDER BY NumArtists DESC;
GO


