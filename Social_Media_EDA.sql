use social_media;
GO

-- Converting Age (varchar) to a float, to perform aggregate functions
alter table social_media_clean
alter column Age float;

select * from social_media_clean;

-- EDA

-- Average Video and Gaming Time for each Age
select Age, round(AVG([Daily Video Content Time (hrs)]), 2) as [Average Daily Video Content Time], round(AVG([Daily Gaming Time (hrs)]), 2) [Daily Gaming Time] from social_media_clean
group by Age
order by Age desc;

-- Monthly Income and Average Daily Screen Time
select [Monthly Income (USD)], AVG([Screen Time (hrs)]) as [Average Screen Time] from social_media_clean
group by [Monthly Income (USD)]
order by [Monthly Income (USD)] desc;

-- Most popular social media platform
select [Primary Platform], COUNT(*) as [Num of Users] from social_media_clean
group by [Primary Platform]
order by [Num of Users] desc;

-- Total Hours spent daily on each platform
select [Primary Platform], SUM([Daily Social Media Time (hrs)]) as [Total hrs spent daily] from social_media_clean
group by [Primary Platform]
order by [Total hrs spent daily] desc;


--Average Social Media Time and Average Screen for each Gender
select Gender, AVG([Daily Social Media Time (hrs)]) as [Average hrs Spent Daily], AVG([Screen Time (hrs)]) as [Average Screen Time] from social_media_clean
group by Gender
order by [Average hrs Spent Daily] desc;


-- Average age of user for each platform
select [Primary Platform],  round(AVG(Age), 2) as [Average age for each platform] from social_media_clean
group by [Primary Platform]
order by [Average age for each platform] desc;

-- Most popular platform in each country
select Country, [Primary Platform]
from (
    select Country, [Primary Platform], COUNT(*) as [Num of users],
           ROW_NUMBER() over (partition by Country order by COUNT(*) desc) as rn
    from social_media_clean
    group by Country, [Primary Platform]
) as ranked
where rn = 1
order by Country;

-- Preferred Content Type for each Gender
select Gender, [Preferred Content Type] 
from (
	select Gender, [Preferred Content Type], COUNT(*) [Num of users],
	ROW_NUMBER() over(partition by Gender order by COUNT(*) desc) as rn
	from social_media_clean
	group by [Preferred Content Type], Gender) as ranked
where rn = 1
order by Gender;


-- Most popular platform for each gender
select Gender, [Primary Platform]
from (
    select Gender, [Primary Platform], COUNT(*) as [Num of users],
           ROW_NUMBER() over (partition by Gender order by COUNT(*) desc) as rn
    from social_media_clean
    group by Gender, [Primary Platform]
) as ranked
where rn = 1
order by Gender;

-- Average Social Media Time per Country
select AVG([Daily Social Media Time (hrs)]) as [Average Social Media Time (hrs)], Country from social_media_clean
group by Country
order by [Average Social Media Time (hrs)] desc;

-- Average Social Media Time per Occupation
select AVG([Daily Social Media Time (hrs)]) as [Average Social Media Time (hrs)], Occupation from social_media_clean
group by Occupation
order by [Average Social Media Time (hrs)] desc;

-- Average Income per Gender
select AVG([Monthly Income (USD)]) as [Average Monthly Income], Gender from social_media_clean
group by Gender
order by [Average Monthly Income] desc;

-- Average Age per Gender
select round(AVG(Age), 2) as [Average Age], Gender from social_media_clean
group by Gender
order by [Average Age] desc;

-- Look for correlation between Screen Time and Sleep Time
select [Screen Time (hrs)], [Sleep Quality (scale 1-10)], [Average Sleep Time (hrs)] from social_media_clean
order by [Screen Time (hrs)] desc;

-- Look for correlation between Monthly Income and Monthyl Income Spent
select [Monthly Income (USD)] ,[Monthly Expenditure on Entertainment (USD)] from social_media_clean
order by [Monthly Income (USD)] desc;

-- Average tech knowledge for each Age
select Age, AVG([Tech Savviness Level (scale 1-10)]) as [Average Tech Savviness Level] from social_media_clean
group by Age
order by [Average Tech Savviness Level] desc;