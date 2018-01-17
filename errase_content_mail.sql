DECLARE @date VARCHAR(60)

-- Nie kasujemy tylko czyscimy tresc maili
SET @date = '2017-07-19'

UPDATE em_Source
SET es_Source = ''
WHERE em_Source.es_Id IN (
  SELECT em_Id
  FROM em__Email
  WHERE em_Date < @date
)