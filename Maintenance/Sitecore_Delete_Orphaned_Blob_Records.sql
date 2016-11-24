--Delete Orphaned blob records (media items which are deleted - but their blob records continue to exist)
BEGIN
	--Deletes records in batch to limit the number of records in one transaction
	WHILE 1=1
	BEGIN
	SET ROWCOUNT 10000
	DELETE FROM Blobs
	WHERE  BlobId NOT IN
			(
				SELECT Value
				FROM   SharedFields WITH (NOLOCK)
				WHERE  FieldId = '40E50ED9-BA07-4702-992E-A912738D32DC'
				UNION
				SELECT Value
				FROM   VersionedFields WITH (NOLOCK)
				WHERE  FieldId = 'DBBE7D99-1388-4357-BB34-AD71EDF18ED3'
				UNION
				SELECT Value
				FROM   ArchivedFields WITH (NOLOCK)
				WHERE  FieldId IN ('40E50ED9-BA07-4702-992E-A912738D32DC', 'DBBE7D99-1388-4357-BB34-AD71EDF18ED3')
			)
	OPTION(MAXDOP 1)
   
	IF @@ROWCOUNT = 0
			BREAK
	END
END
