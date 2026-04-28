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

/* from my query it turns out data_analyst who tend to work at mantys receive high salary of '6500000'*/

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
