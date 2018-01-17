IF OBJECT_ID('TEMPDB..#tempStats') IS NOT NULL
DROP TABLE IF EXISTS #tempStats

  CREATE TABLE #tempStats
(
 ID int identity(1,1)
 ,Table_Name VARCHAR(123)
 ,Table_Rowcnt INT
 ,ReservedSpaceKB VARCHAR(25)
 ,SpaceUsedKB VARCHAR(25)
 ,Index_SizeKB VARCHAR(25)
 ,UnusedSpaceKB VARCHAR(25)
)
INSERT INTO #tempStats
EXEC sp_MSforeachtable 'sp_spaceused ''?'''

-- convert spaces from KB to MB
SELECT
  temp.Table_Name as 'Nazwa Tabeli'
 ,Table_Rowcnt as 'Liczba wierszy'
 ,ROUND(CAST(REPLACE(ReservedSpaceKB, 'KB', '') AS FLOAT) / 1024,5) AS 'Przestrzen zarezerwowana [MB]'
 ,ROUND(CAST(REPLACE(SpaceUsedKB, 'KB', '') AS FLOAT) / 1204,5) AS 'Przestrzen uzywana [MB]'
 ,ROUND(CAST(REPLACE(Index_SizeKB, 'KB', '') AS FLOAT) / 1024,5) AS 'Rozmiar indeksu [MB]'
 ,ROUND(CAST(REPLACE(UnusedSpaceKB, 'KB', '') AS FLOAT) / 1024,5) AS 'Nieuzywana przestrzen [MB]'
FROM #tempStats temp
ORDER BY 'Przestrzen uzywana [MB]' desc
DROP TABLE IF EXISTS #tempStats