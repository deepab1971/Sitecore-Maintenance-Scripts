-----Delete archive items older than @Days
DECLARE	@Temp int = 0
DECLARE	@Days int = 180
DECLARE	@ArchiveType nvarchar(30) = 'archive'
DECLARE @DeleteDate DATETIME = DATEADD(DAY, -@Days, GETDATE())

/*
To delete the archive items, records need to be removed from following tables,
ArchivedVersions, ArhivedFields, ArchivedItems, Archive
Archive being the master table - the last deletion need to be happen from Archive table
*/

--Delete from ArchivedVersions table
BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
	SET ROWCOUNT 10000
	DELETE	ArchivedVersions
	WHERE	ArchivalId IN (
		SELECT	ArchivalId
		FROM	Archive
		WHERE	ArchiveName = @ArchiveType
		AND		ArchiveDate < @DeleteDate)

		OPTION(MAXDOP 1)
   
		IF @@ROWCOUNT = 0
				BREAK
	END
END

--Delete from ArchivedFields table
BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
	SET ROWCOUNT 10000
	DELETE	ArchivedFields
	WHERE	ArchivalId IN (
		SELECT	ArchivalId
		FROM	Archive
		WHERE	ArchiveName = @ArchiveType
		AND		ArchiveDate < @DeleteDate)

		OPTION(MAXDOP 1)
   
		IF @@ROWCOUNT = 0
				BREAK
	END
END
SET @Temp = 0 -- to reset @@ROWCOUNT

--Delete from ArchivedItems table
BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
	SET ROWCOUNT 10000
	DELETE	ArchivedItems
	WHERE	ArchivalId IN (
		SELECT	ArchivalId
		FROM	Archive
		WHERE	ArchiveName = @ArchiveType
		AND		ArchiveDate < @DeleteDate)

		OPTION(MAXDOP 1)
   
		IF @@ROWCOUNT = 0
				BREAK
	END
END
SET @Temp = 0 -- to reset @@ROWCOUNT

--Delete from Archive table
BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
	SET ROWCOUNT 10000
	DELETE	Archive
	WHERE	ArchivalId IN (
		SELECT	ArchivalId
		FROM	Archive
		WHERE	ArchiveName = @ArchiveType
		AND		ArchiveDate < @DeleteDate)

		OPTION(MAXDOP 1)
   
		IF @@ROWCOUNT = 0
				BREAK
	END
END
