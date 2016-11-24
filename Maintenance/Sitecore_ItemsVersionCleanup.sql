/*
Remove Older versions of item and keep the max versions to @NumberOfVersionsToKeep 
This script does not consider the workflowstate into account while counting the number of versions of the item
Remvoing version include deleting records from,
workflowhistory
PublishQueue
History
VersionedField
*/
DECLARE @ItemID uniqueidentifier
DECLARE @Language nvarchar(50)
DECLARE @Version int
DECLARE	@NumberOfVersionsToKeep int = 4


BEGIN
	/*
	Create a cursor to fetch items which has more Versions than NumberOfVersionsToKeep
	*/
	DECLARE items_cursor CURSOR FOR 
	SELECT items.ItemId,items.Language
	FROM (SELECT distinct ItemId,Language, Version from dbo.VersionedFields WITH (NOLOCK)) as items
	Group by items.ItemId,items.Language having count(*)> @NumberOfVersionsToKeep order by ItemId

	OPEN items_cursor

	FETCH NEXT FROM items_cursor INTO @ItemID,@Language

	WHILE @@FETCH_STATUS = 0 
	BEGIN 
		/*
		Create a cursor to fetch older versions of the items
		*/
		DECLARE item_version_cusror CURSOR FOR
		select distinct version from dbo.versionedfields where ItemID = @ItemID and Language=@Language order by Version asc
		Open item_version_cusror

		FETCH NEXT FROM item_version_cusror INTO @Version

		WHILE @@FETCH_STATUS = 0 
		BEGIN
				
			DELETE from dbo.workflowHistory where ItemID =@ItemID and Language =@Language and Version =@Version
			DELETE from dbo.PublishQueue where ItemID =@ItemID and Language =@Language and Version =@Version
			DELETE from dbo.History where ItemID =@ItemID and ItemLanguage =@Language and ItemVersion =@Version
			DELETE from dbo.VersionedFields where ItemID =@ItemID and Language =@Language and Version =@Version

			/*if the older versions is now less than @NumberOfVersionsToKeep of this item, then break and move to the next item*/
			SELECT items.ItemId,items.Language
			FROM (SELECT distinct ItemId,Language, Version from dbo.VersionedFields WITH (NOLOCK) where ItemID =@ItemID and Language =@Language) as items
			Group by items.ItemId,items.Language having count(*)> @NumberOfVersionsToKeep order by ItemId
			
			IF @@ROWCOUNT = 0				
			BREAK
						
			FETCH NEXT FROM item_version_cusror INTO @Version
		END

		CLOSE item_version_cusror
		DEALLOCATE item_version_cusror
		FETCH NEXT FROM items_cursor INTO @ItemID,@Language
	END
	
	CLOSE items_cursor 
	DEALLOCATE items_cursor
END

