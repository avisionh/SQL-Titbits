USE [<database_name>]
GO;

----------------------------------------------------------------------------------------------
-- Script Name:		RANDOM NUMBER SAMPLE GENERATOR
-- Description:		This script generates a sequence of random numbers via the creation of a function, 
--					[dbo].[fn_SelectRandomRow]].
--					This sequence of random numbers is then stored within a View
--					and will be used to join onto the BFR Views.
-- Notes:			https://stackoverflow.com/questions/1045138/how-do-i-generate-random-number-for-each-row-in-a-tsql-select/9039661
-- Author:			Avision Ho	
-- Creation Date:	09/01/2019
-----------------
-- Change History
-----------------
--S.No.			Date		Author			Change Description
--0.1			09/01/2019	AH				Initial base view of table

----------------------------------------------------------------------------------------------

DECLARE @n INT = 1000

/* STAGE 1 */
--DESC: Before selecting your data, seed the rand() function, and then use the UDF in your select statement.
SELECT RAND(200);   -- see the rand() function
WITH random_nos(id) AS
(
	SELECT ROW_NUMBER() OVER(ORDER BY OBJECT_ID) FROM sys.all_objects
),
random_nos_join AS
(
SELECT 
    [Id],
    [RandomNumber] = CEILING([dbo].[fn_SelectRandomRow]()*1000)
FROM random_nos
WHERE [Id] <= @n    -- limit the results to n random numbers
),

/* STAGE 2 */
-- DESC: Create iterator field for table/View of your choice
cte_staged AS
(
	SELECT [Id] = ROW_NUMBER() OVER (ORDER BY [<unique_identifier>]), *
	FROM [<schema_name>].[<view_name>]
),

/* STAGE 3 */
-- DESC: Join random_nos_join with bfr_join
cte_final AS
(
	SELECT cte.[Id],
			cte.[<unique_identifier>],
			cte.[<field01>],
			cte.[<field02>],
			cte.[<field03>],
			cte.[<field04>],
			cte.[<field05>],
			random.[RandomNumber]
	FROM cte_staged_one AS cte
	INNER JOIN random_nos_join AS random
		ON cte.[Id] = random.[Id]
)

/* STAGE 5 */
-- DESC: Display random sample of 1000 rows
SELECT TOP 1000 * FROM cte_final
ORDER BY [RandomNumber]