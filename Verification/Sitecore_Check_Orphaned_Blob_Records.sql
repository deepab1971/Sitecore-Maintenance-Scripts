select * FROM Blobs
WHERE  BlobId NOT IN
     (
         SELECT Value
         FROM   SharedFields WITH (NOLOCK)
         WHERE  FieldId = '40E50ED9-BA07-4702-992E-A912738D32DC' and [Value] != '' 
         UNION
         SELECT Value
         FROM   VersionedFields WITH (NOLOCK)
         WHERE  FieldId = 'DBBE7D99-1388-4357-BB34-AD71EDF18ED3' and [Value] != '' 
         UNION
         SELECT Value
         FROM   ArchivedFields WITH (NOLOCK)
         WHERE  FieldId IN ('40E50ED9-BA07-4702-992E-A912738D32DC', 'DBBE7D99-1388-4357-BB34-AD71EDF18ED3') and [Value] != ''
     )
