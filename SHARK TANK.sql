select * from project..data

-- Q1: total episodes

select max(epno) from project..data
select count(distinct epno) from project..data

-- Q2: pitches 

select count(distinct brand) from project..data

--Q3: pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from project..data) a

--Q4: total male

select sum(male) from project..data

--q5 total female

select sum(female) from project..data

--Q6: gender ratio

select sum(female)/sum(male) from project..data

--Q7:  total invested amount

select sum(amountinvestedlakhs) from project..data

-- Q8: avg equity taken

select avg(a.equitytakenp) from
(select * from project..data where equitytakenp>0) a

-- Q9: highest deal taken

select max(amountinvestedlakhs) from project..data 

-- Q10: higheest equity taken

select max(equitytakenp) from project..data

-- Q11: startups having at least women

select sum(a.female_count) startups having at least women from (
select female,case when female>0 then 1 else 0 end as female_count from project..data) a

-- Q12: pitches converted having atleast ne women

select * from project..data


select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from project..data where deal!='No Deal')) a)b

-- Q13: avg team members

select avg(teammembers) from project..data

-- Q14: amount invested per deal

select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from project..data where deal!='No Deal') a

-- Q15: avg age group of contestants

select avgage,count(avgage) cnt from project..data group by avgage order by cnt desc

-- Q16: location group of contestants

select location,count(location) cnt from project..data group by location order by cnt desc

-- Q17: sector group of contestants

select sector,count(sector) cnt from project..data group by sector order by cnt desc


-- Q18: partner deals

select partners,count(partners) cnt from project..data  where partners!='-' group by partners order by cnt desc


-- Q19: which is the startup in which the highest amount has been invested in each domain/sector


select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from project..data) c

where c.rnk=1