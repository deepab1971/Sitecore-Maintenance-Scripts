/*
--Too many records in CORE DB properties table will slow down the sitecore login process, 
hence peridocally SC_TICKET records must be cleanedup
*/
BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
	SET ROWCOUNT 10000
	
	DELETE dbo.properties 
	WHERE [key] like '%SC_TICKET%'
	
	OPTION(MAXDOP 1)
   
		IF @@ROWCOUNT = 0
				BREAK
	END
END