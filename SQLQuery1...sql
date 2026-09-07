--TASK 1
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress,
    EnglishEducation,
    EnglishOccupation
FROM DimCustomer;
--What it demonstrates: Basic SELECT and column selection.

--II
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress,
    EnglishEducation,
    EnglishOccupation
FROM DimCustomer
WHERE Gender = 'M';
--What it demonstrates: Filtering rows with WHERE.

--III
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress,
    EnglishEducation,
    EnglishOccupation
FROM DimCustomer
WHERE EnglishEducation = 'Bachelors';
--What it demonstrates: Filtering based on a categorical column.

--IV
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress,
    EnglishEducation,
    EnglishOccupation
FROM DimCustomer
WHERE EnglishOccupation = 'Professional';
--What it demonstrates: Filtering by occupation.

--V
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress,
    EnglishEducation,
    EnglishOccupation
FROM DimCustomer
WHERE BirthDate > '1980-01-01';
--What it demonstrates: Date filtering.

--VI
SELECT
    CustomerKey,
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    BirthDate,
    Gender,
    EmailAddress
FROM DimCustomer;
--What it demonstrates: Calculated/derived columns using CONCAT()

--VII
SELECT
    CustomerKey,
    FirstName,
    LastName,
    EmailAddress
FROM DimCustomer
WHERE EmailAddress LIKE '%adventure%';
--What it demonstrates: Pattern matching with LIKE.

--VIII
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress
FROM DimCustomer
ORDER BY LastName ASC;
--What it demonstrates: Sorting with ORDER BY.

--IX
SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress
FROM DimCustomer
ORDER BY BirthDate ASC;
--What it demonstrates: Sorting dates. The oldest customers have the earliest birth dates.

--X
SELECT
    COUNT(*) AS TotalCustomers
FROM DimCustomer;
--What it demonstrates: Basic aggregation using COUNT().

--TASK 2
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    Gender,
    HireDate
FROM DimEmployee;
--What it demonstrates: Selecting required employee attributes.

--I
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    Gender,
    HireDate
FROM DimEmployee
WHERE DepartmentName = 'Sales';
--What it demonstrates: Filtering employees by department.

--II
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    Gender,
    HireDate
FROM DimEmployee
WHERE Title LIKE '%Manager%';
--What it demonstrates: Searching for part of a text value.

--III
SELECT
    DepartmentName,
    COUNT(*) AS EmployeeCount
FROM DimEmployee
GROUP BY DepartmentName
ORDER BY EmployeeCount DESC;
--What it demonstrates: GROUP BY and COUNT().

--IV
SELECT
    Gender,
    COUNT(*) AS EmployeeCount
FROM DimEmployee
GROUP BY Gender
ORDER BY Gender;
--What it demonstrates: Grouping data by gender.

--V
SELECT
    MIN(HireDate) AS EarliestHireDate,
    MAX(HireDate) AS LatestHireDate
FROM DimEmployee;
--What it demonstrates: MIN() and MAX() aggregation.

--VI
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
FROM DimEmployee;
--What it demonstrates: MIN() and MAX() aggregation.

--
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE())
        - CASE
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, HireDate, GETDATE()), HireDate)
                 > GETDATE()
            THEN 1
            ELSE 0
          END AS YearsOfService
FROM DimEmployee;
--What it demonstrates: Conditional logic using CASE.

--VII
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService,
    CASE
    WHEN DATEDIFF(YEAR, HireDate, GETDATE()) < 5
         THEN 'New Employee'
    WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 5 AND 10
         THEN 'Experienced'
    ELSE 'Long Service'
    END AS EmployeeCategory
FROM DimEmployee;
--What it demonstrates: Conditional logic using CASE.

--VIII
SELECT TOP 5
    DepartmentName,
    COUNT(*) AS EmployeeCount
FROM DimEmployee
GROUP BY DepartmentName
ORDER BY EmployeeCount DESC;
--What it demonstrates: Combining TOP, GROUP BY, COUNT() and ORDER BY.

--IX
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    DepartmentName,
    HireDate,
    RANK() OVER (ORDER BY HireDate ASC) AS HireRank
FROM DimEmployee
ORDER BY HireRank;
--What it demonstrates: Window functions and employee ranking.

--TASK 3
SELECT
    Gender,
    COUNT(*) AS CustomerCount
FROM DimCustomer
GROUP BY Gender
ORDER BY CustomerCount DESC;

--I
SELECT
    EnglishEducation,
    COUNT(*) AS CustomerCount
FROM DimCustomer
GROUP BY EnglishEducation
ORDER BY CustomerCount DESC;

--II
SELECT
    EnglishOccupation,
    COUNT(*) AS CustomerCount
FROM DimCustomer
GROUP BY EnglishOccupation
ORDER BY CustomerCount DESC;

--III
SELECT TOP 5
    EnglishOccupation,
    COUNT(*) AS CustomerCount
FROM DimCustomer
GROUP BY EnglishOccupation
ORDER BY CustomerCount DESC;

--IV
WITH EducationCounts AS
(
    SELECT
        EnglishEducation,
        COUNT(*) AS CustomerCount
    FROM DimCustomer
    GROUP BY EnglishEducation
)
SELECT
    EnglishEducation,
    CustomerCount,
    CAST(CustomerCount * 100.0 /
         SUM(CustomerCount) OVER () AS DECIMAL(5,2)) AS PercentageOfCustomers
FROM EducationCounts
ORDER BY PercentageOfCustomers DESC;
--What it demonstrates: CTEs, aggregation and window functions.

--V
SELECT
    CustomerKey,
    FirstName,
    LastName,
    EnglishEducation,
    CASE
        WHEN EnglishEducation = 'Bachelors'
            THEN 'Degree Holder'
        WHEN EnglishEducation = 'Graduate Degree'
            THEN 'Postgraduate'
        WHEN EnglishEducation = 'High School'
            THEN 'Secondary Education'
        ELSE 'Other'
    END AS EducationCategory
FROM DimCustomer;
--What it demonstrates: Customer segmentation using CASE.

--VI
SELECT
    AVG(
        DATEDIFF(YEAR, BirthDate, GETDATE())
        - CASE
            WHEN DATEADD(
                    YEAR,
                    DATEDIFF(YEAR, BirthDate, GETDATE()),
                    BirthDate
                 ) > GETDATE()
            THEN 1
            ELSE 0
          END
    ) AS AverageCustomerAge
FROM DimCustomer;
--What it demonstrates: Calculating age and then using AVG().

--VII
SELECT TOP 10
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,
    Gender,
    EmailAddress
FROM DimCustomer
ORDER BY BirthDate ASC;
--What it demonstrates: Identifying the oldest customers by sorting their birth dates.

--PART B
SELECT
    DepartmentName,
    COUNT(*) AS EmployeeCount
FROM DimEmployee
GROUP BY DepartmentName
ORDER BY EmployeeCount DESC;

--I
WITH DepartmentCounts AS
(
    SELECT
        DepartmentName,
        COUNT(*) AS EmployeeCount
    FROM DimEmployee
    GROUP BY DepartmentName
)
SELECT
    DepartmentName,
    EmployeeCount,
    CAST(EmployeeCount * 100.0 /
         SUM(EmployeeCount) OVER () AS DECIMAL(5,2))
         AS PercentageOfEmployees
FROM DepartmentCounts
ORDER BY PercentageOfEmployees DESC;

--II
SELECT TOP 5
    DepartmentName,
    COUNT(*) AS EmployeeCount
FROM DimEmployee
GROUP BY DepartmentName
ORDER BY EmployeeCount DESC;

--III
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService,
    CASE
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) < 3
            THEN 'New'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 3 AND 7
            THEN 'Developing'
        WHEN DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 8 AND 15
            THEN 'Experienced'
        ELSE 'Veteran'
    END AS EmployeeCategory
FROM DimEmployee;

--IV
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    DepartmentName,
    HireDate,
    RANK() OVER (
        PARTITION BY DepartmentName
        ORDER BY HireDate ASC
    ) AS DepartmentHireRank
FROM DimEmployee
ORDER BY DepartmentName, DepartmentHireRank;
--What it demonstrates: PARTITION BY allows the ranking to restart for every department.

--V
WITH RankedEmployees AS
(
    SELECT
        EmployeeKey,
        FirstName,
        LastName,
        DepartmentName,
        HireDate,
        ROW_NUMBER() OVER (
            PARTITION BY DepartmentName
            ORDER BY HireDate ASC
        ) AS RowNum
    FROM DimEmployee
)

--VI
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    DepartmentName,
    HireDate
FROM RankedEmployees
WHERE RowNum = 1
ORDER BY DepartmentName;

--VII
WITH DepartmentCounts AS
(
    SELECT
        DepartmentName,
        COUNT(*) AS EmployeeCount
    FROM DimEmployee
    GROUP BY DepartmentName
)
SELECT
    DepartmentName,
    EmployeeCount
FROM DepartmentCounts
WHERE EmployeeCount >
      (
          SELECT AVG(EmployeeCount * 1.0)
          FROM DepartmentCounts
      )
ORDER BY EmployeeCount DESC;
--What it demonstrates: A CTE combined with a subquery.

--PART C
SELECT
    DepartmentName AS Department,
    COUNT(*) AS [Total Employees],

    SUM(
        CASE
            WHEN Gender = 'Male' THEN 1
            ELSE 0
        END
    ) AS [Male Employees],

    SUM(
        CASE
            WHEN Gender = 'Female' THEN 1
            ELSE 0
        END
    ) AS [Female Employees],

    MIN(HireDate) AS [Earliest Hire Date],
    MAX(HireDate) AS [Latest Hire Date]

FROM DimEmployee

GROUP BY DepartmentName

ORDER BY [Total Employees] DESC;

--REPORT STRUCTURE
--Department	Total Employees	Male Employees	Female Employees	Earliest Hire Date	Latest Hire Date
--Sales	                …	        …	                …	                …	                …
--Production	        …	        …	                …	                …	                …

--FINAL
WITH CustomerTotals AS
(
    SELECT
        COUNT(*) AS TotalCustomers
    FROM DimCustomer
),
EducationSummary AS
(
    SELECT
        EnglishEducation AS Education,

        COUNT(*) AS TotalCustomers,

        SUM(
            CASE
                WHEN Gender = 'Male' THEN 1
                ELSE 0
            END
        ) AS MaleCustomers,

        SUM(
            CASE
                WHEN Gender = 'Female' THEN 1
                ELSE 0
            END
        ) AS FemaleCustomers

    FROM DimCustomer
    GROUP BY EnglishEducation
)
SELECT
    Education,
    TotalCustomers,
    MaleCustomers,
    FemaleCustomers,
    CAST(
        TotalCustomers * 100.0 /
        (SELECT TotalCustomers FROM CustomerTotals)
        AS DECIMAL(5,2)
    ) AS [Percentage of TotalCustomers]

FROM EducationSummary

ORDER BY TotalCustomers DESC;

--Why You Should Not Directly Join DimCustomer and DimEmployee
SELECT *
FROM DimCustomer AS DC
JOIN DimEmployee AS DE
    ON DC.CustomerKey = DE.EmployeeKey;

--Explanation of the DimCustomer → DimEmployee Join

--A direct join between DimCustomer and DimEmployee is not appropriate because the two tables represent different business entities. DimCustomer contains information about customers, while DimEmployee contains information about employees. The CustomerKey and EmployeeKey identify different types of entities and should not be matched simply because their values may overlap.

--A proper relationship between customers and employees would normally be established through a fact table or another appropriate relationship/bridge table that defines how the two entities are connected. Therefore, for this assignment, customer and employee analyses should be performed independently unless a valid business relationship exists in the database.

--Creating an artificial join could produce incorrect results and misleading business conclusions.



