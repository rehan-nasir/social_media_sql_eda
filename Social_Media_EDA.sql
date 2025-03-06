use social_media;
GO


select * from social_media_clean;

-- Converting Age (varchar) to a float, to perform aggregate functions
alter table social_media_clean
alter column Age float;

-- EDA

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
SELECT Country, [Primary Platform]
FROM (
    SELECT Country, [Primary Platform], COUNT(*) AS [Num of users],
           ROW_NUMBER() OVER (PARTITION BY Country ORDER BY COUNT(*) DESC) AS rn
    FROM social_media_clean
    GROUP BY Country, [Primary Platform]
) as ranked
WHERE rn = 1
ORDER BY Country;

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
SELECT Gender, [Primary Platform]
FROM (
    SELECT Gender, [Primary Platform], COUNT(*) AS [Num of users],
           ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY COUNT(*) DESC) AS rn
    FROM social_media_clean
    GROUP BY Gender, [Primary Platform]
) as ranked
WHERE rn = 1
ORDER BY Gender;

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


