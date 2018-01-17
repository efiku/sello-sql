/*
EKSPERYMENTALNIE, ALE RACZEJ SMIGA.
*/


DECLARE @date VARCHAR(60)
--- Data do ktorej kasowane sa maile w sello

SET @date = '2017-07-20'

CREATE TABLE #Temp
(
  es_EmailId INT,
  em_UIDL    VARCHAR(60),
  em_Date    DATETIME,
)

-- Czyszczenie tabeli em_Archiwe, dla zachowania poprawnosci danych
TRUNCATE TABLE em_Archive;

PRINT N'--- Wrzucone wiadomosci do #Temp ----'
--- Wrzocamy do tempa wszystkie wiadomosci z datami
INSERT INTO #Temp
  SELECT
    em_Id,
    em_UIDL,
    em_Date
  FROM em__Email;
PRINT N'//--- Wrzucone wiadomosci do #Temp ----//'


--- Do em_Archiwe wrzucamy tylko te wiadomosci ktore nie maja pustego em_UIDL puste em_UIDL może oznacza wysłane
PRINT N'--- Wrzucone wiadomosci do em_Archive bez UIDL ----'
INSERT INTO em_Archive
  SELECT
    #Temp.em_UIDL,
    1004
  FROM #Temp
  WHERE em_UIDL <> ''
PRINT N'//--- Wrzucone wiadomosci do em_Archive bez UIDL ----//'



--- Usuwamy wiadomosci
PRINT N'--- kasowanie z em_Source  ----'
DELETE em_Source FROM em_Source
  INNER JOIN #Temp ON em_Source.es_EmailId = #temp.es_EmailId
WHERE
  #Temp.em_Date < @date
PRINT N'//--- kasowanie z em_Source  ----//'


PRINT N'--- kasowanie z em_Attachment  ----'
DELETE em_Attachment FROM em_Attachment
  INNER JOIN #Temp ON em_Attachment.et_EmailId = #temp.es_EmailId
WHERE
  #Temp.em_Date < @date
PRINT N'//--- kasowanie z em_Attachment  ----//'


PRINT N'--- kasowanie z em__Email  ----'
DELETE em__Email FROM em__Email
WHERE
  em__Email.em_Date < @date

PRINT N'//--- kasowanie z em__Email  ----//'

DROP TABLE #Temp

