/*
question:what are the top paying data analyst jobs?
-identify the top highest-paying data analyst roles that are available remotely.
focuses on job postings with specified salaries(remove nulls)
-why?highlight the top-paying opportunities for data analysts,offering insights into emp..
*/

select top 10
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
	name as company_name
from
	job_postings_fact
left join company_dimm on job_postings_fact.company_id = company_dimm.company_id
where
	job_title_short = 'Data Analyst' AND
	job_location = 'Anywhere' and 
	salary_year_avg is not null
order by
	salary_year_avg desc

/* /*
Here's the breakdown of the top data analyst jobs in 2023:
Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

RESULTS
=======
[
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "650000.0",
    "job_posted_date": "2023-02-20 15:13:33",
    "company_name": "Mantys"
  },
  {
    "job_id": 547382,
    "job_title": "Director of Analytics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "336500.0",
    "job_posted_date": "2023-08-23 12:04:42",
    "company_name": "Meta"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "255829.5",
    "job_posted_date": "2023-06-18 16:03:12",
    "company_name": "AT&T"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "232423.0",
    "job_posted_date": "2023-12-05 20:00:40",
    "company_name": "Pinterest Job Advertisements"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "217000.0",
    "job_posted_date": "2023-01-17 00:17:23",
    "company_name": "Uclahealthcareers"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "205000.0",
    "job_posted_date": "2023-08-09 11:00:01",
    "company_name": "SmartAsset"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "189309.0",
    "job_posted_date": "2023-12-07 15:00:13",
    "company_name": "Inclusively"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "189000.0",
    "job_posted_date": "2023-01-05 00:00:25",
    "company_name": "Motional"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "186000.0",
    "job_posted_date": "2023-07-11 16:00:05",
    "company_name": "SmartAsset"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "184000.0",
    "job_posted_date": "2023-06-09 08:01:04",
    "company_name": "Get It Recruit - Information Technology"
  }
]
*/

/* TOP PAYING JOB SKILLS*/
WITH top_paying_jobs as ( 
	select top 10
		job_id,
		job_title,
		salary_year_avg,
		name as company_name
	from
		job_postings_fact
	left join company_dimm on job_postings_fact.company_id = company_dimm.company_id
	where
		job_title_short = 'Data Analyst' AND
		job_location = 'Anywhere' and 
		salary_year_avg is not null
	order by
		salary_year_avg desc
		)
select 
top_paying_jobs.*,
skills
from top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order by 
salary_year_avg desc 
--insights
/* SQL and Python dominate — both appear in 9 out of 10 roles, making them essentially non-negotiable for high-paying analyst positions. If you're only going to learn two things, it's these.
Tableau is the clear BI tool of choice — showing up in 7 roles, well ahead of Power BI (2 roles). Visualization is clearly expected at this salary level.
R still matters at the top — appearing in 4 roles, which is surprising given how Python-heavy the market generally is. Senior/principal roles especially seem to want it.
Cloud is becoming standard — Azure, AWS, Snowflake, and Databricks all appear, suggesting that knowing at least one cloud platform is increasingly expected for $180K+ roles.
Collaboration tools cluster in specific roles — Jira, Confluence, Bitbucket, and Atlassian all appear together (in the Inclusively Director and Motional roles), suggesting those companies lean heavily on Agile/DevOps workflows.
The salary gap is significant — the top role (AT&T, ~$256K) pays nearly 40% more than the lowest in the top 10 (~$184K), showing there's real variance even within "top paying" roles.*/

/*in-demand skills for data analysts
question:what are the most in-demand skills for data analysts?
 -join job postings to inner join table similar to query 2
 -identify the top 5 in demand skills for a data analyst.
 focus on all job postings
 -why? retrieves the insights into the most valuable skills for job seekers.
 */
 select top 5
 skills,
 count(skills_job_dim.job_id) as demand_count
 from job_postings_fact
 inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
 inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
 where job_title_short = 'Data Analyst'  and job_work_from_home = 1
 group by
 skills
 order by 
 demand_count desc
 /* top five skills where as follows
	sql with a demand count of 7291
	excel with a demand count of 4611
	python with a demand count of 4330
	tableau with a demand count of 3745
	powerbi with demand 2609
*/

 /* TOP SKILLS BASED ON SALARY */

select top 25
 skills,
 avg(salary_year_avg) as avg_salary
from job_postings_fact
 inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
 inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst'  and salary_year_avg is not null  and job_work_from_home = 1
group by
 skills,salary_year_avg
order by 
 salary_year_avg desc
 /* 
 -- TOP PAYING SKILLS - DATA ANALYSTS 2023
-- Source: top 25 job postings by avg salary

-- 1. SQL, Python & Tableau are the core stack — appear across multiple high-paying roles ($232K–$256K avg)
-- 2. Cloud/big data skills (AWS, Azure, PySpark, Databricks) push salaries to the $255K ceiling
-- 3. 13 skills tied at $255,830 — all from one AT&T role, so treat that tier with caution
-- 4. GitLab sits lowest at $205K — version control alone doesn't drive salary
-- 5. Skills with broadest demand: SQL (3 roles), Tableau (3 roles), Python (2 roles), R (2 roles)
-- 6. Senior/director roles require the full stack: cloud + BI + programming combined
*/
/*MOST OPTIMAL SKILLS
answer:what are the most optimal skills to learn(aka its in high demand nd a high-paying skill)?
-identify skills in high demand and associated with high averaeg salaries for data analyst roles
-concentrates on remote positions with specified salari) s
-why?target skills that offer job security ( high demand) and financial benefits(high salaries),
offering strategic insights for carrer development in data analysis */

;with skills_demand as (
 select
  skills_job_dim.skill_id,
 skills,
 count(skills_job_dim.job_id) as demand_count
 from job_postings_fact
 inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
 inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
 where job_title_short = 'Data Analyst'  and salary_year_avg is not null and job_work_from_home = 1
 group by
skills_job_dim.skill_id,skills
 ), 
 average_salary as(
	 select 
	 skills_job_dim.skill_id,
	 skills,
	 avg(salary_year_avg) as avg_salary
	from job_postings_fact
	 inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
	 inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
	where job_title_short = 'Data Analyst'  and salary_year_avg is not null  and job_work_from_home = 1
	group by
	skills_job_dim.skill_id,salary_year_avg,skills
)
select top 25
skills_demand.skill_id,
skills_demand.skills,
demand_count,
avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where demand_count > 10
order by
demand_count 
/*
Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
Business Intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

[
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "11",
    "avg_salary": "114210"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "avg_salary": "112948"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "13",
    "avg_salary": "109654"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "avg_salary": "108317"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "avg_salary": "106906"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "demand_count": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104918"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "avg_salary": "104534"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "avg_salary": "103795"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "13",
    "avg_salary": "101414"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100499"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "avg_salary": "99936"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "13",
    "avg_salary": "99631"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99288"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "14",
    "avg_salary": "99171"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "13",
    "avg_salary": "99077"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "11",
    "avg_salary": "98958"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "avg_salary": "97786"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "avg_salary": "97587"
  }
]
*/
