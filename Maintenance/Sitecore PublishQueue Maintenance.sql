---Delete records in the PublishQueue table older than @Days
DECLARE	@Days int = 7
DECLARE @DeleteDate DATETIME = DATEADD(DAY, -@Days, GETDATE())

BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
		SET ROWCOUNT 10000
		DELETE dbo.PublishQueue
		WHERE  [Date] < @DeleteDate
		OPTION(MAXDOP 1)
   
		IF @@ROWCOUNT = 0
				BREAK
	END
END

