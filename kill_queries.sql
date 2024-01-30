-- Sometimes you can have orphaned queries that are churning away but not actually doing anything.
-- this can block other queries from running too in some circumstances.
-- DBT can be a bit guilty of this if you're impatient with it.


-- Use this to identify, your job that's sitting idle
-- replace region-eu with wherever your query ran.

SELECT
 job_id,
 creation_time,
 query,
 state,
 total_slot_ms,
 user_email,
 project_id,
 destination_table.dataset_id,
 job_type
FROM `region-eu`.INFORMATION_SCHEMA.JOBS_BY_USER a
WHERE state != "DONE"
AND DATE(creation_time) >= CURRENT_DATE() -1


-- use the following to cancel:
-- in the event of job not found, do check which region you're pointing at.
-- replace the project with your project and job_id.

CALL BQ.JOBS.CANCEL("my_google_project_name.59d46058-94ad-4e11-a996-967c9c688bd4")
