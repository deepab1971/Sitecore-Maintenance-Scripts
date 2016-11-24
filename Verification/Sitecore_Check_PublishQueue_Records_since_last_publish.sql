DECLARE @Value VARCHAR(MAX);
DECLARE @DATE_STR [varchar] (50);
DECLARE @LAST_PUBLISH_DATE DATETIME;

SELECT TOP 1 @Value = Value FROM [dbo].[Properties] WHERE [Key] LIKE 'LastPublish en-US web'

SELECT @DATE_STR = SUBSTRING (@Value, 0, 5) + '-' + 
SUBSTRING(@Value, 5, 2) + '-' + 
SUBSTRING(@Value, 7, 2) + ' ' + 
SUBSTRING(@Value, 10, 2) + ':' + 
SUBSTRING(@Value, 12, 2) + ':' + 
SUBSTRING(@Value, 14, 2);

SET @LAST_PUBLISH_DATE = CONVERT(DATETIME, @DATE_STR, 120);

SELECT * FROM [dbo].[PublishQueue] WHERE Date > @LAST_PUBLISH_DATE ORDER BY Date DESC
