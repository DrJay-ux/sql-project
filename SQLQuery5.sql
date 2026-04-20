select*
from
january_jobs

select*
from
february_jobs

select*
from
march_jobs
select
quarter1_job_postings.job_title_short,
quarter1_job_postings.job_location,
quarter1_job_postings.job_via,
quarter1_job_postings.salary_year_avg,
cast(quarter1_job_postings.job_posted_date as date)as date
from(
	select
		*
	from
		january_jobs

	union all
	select
		*
	from
		february_jobs
	union all
	select
	*
	from
		march_jobs) as quarter1_job_postings

where quarter1_job_postings.salary_year_avg>70000 and quarter1_job_postings.job_title_short ='Data Analyst'
order by quarter1_job_postings.salary_year_avg desc