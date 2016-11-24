# Sitecore-Maintenance-Scripts
These are SQL Scripts to help in regular maintenance of the Sitecore Database - which help in delvering optimized performance from Sitecore

Maintenance Scripts
1)Sitecore Archive Maintenance.sql
Cleanup of Archtived items older than x Days

2) Sitecore Recyclebin Maintenance.sql
Cleanup of Items which are there in recyclebin older than x Days

3)Sitecore_Delete_Orphaned_Blob_Records.sql
Cleanu of Orphaned Blob records - which will significantly help in reducing the database size

4)Sitecore EventQueue Maintenance.sql
Cleanup of EventQueeue records older than x Days

5)Sitecore PublishQueue Maintenance.sql
Cleanup of PublishQueeu records older than x Days

6)Sitecore_CleanupAuthenticationTickets.sql
Cleanup of Authentication tickets (SC_TICKET) from the Properties table

7)Sitecore_ItemsVersionCleanup 
Cleanup of Old Item versions to limit the number of versions that are kept in the Master DB

Verification
1)Sitecore_Check_Orphaned_Blob_Records.sql
Script to verify the number of Orphaned records in the blob table

2)Sitecore_Check_PublishQueue_Records_since_last_publish.sql
Script to verify the number of records waiting to be processed in the publishqueue since the last publish
