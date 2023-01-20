select * from olympics.OLYMPICS_HISTORY;
select * from olympics.NOC_REGIONS;
-- mysql --local-infile=1 -u root -p

select  count(distinct Games) total_olympic_games from olympics.OLYMPICS_HISTORY;

select distinct year,season,city from olympics.OLYMPICS_HISTORY order by 1 asc;

select distinct games,count(distinct NOC) from olympics.OLYMPICS_HISTORY group by games order by 1 ;

WITH T1 as(
select distinct CONCAT(games,"-",count(distinct NOC)) as highest_countries from olympics.OLYMPICS_HISTORY group by games 
order by count(distinct NOC) desc limit 1),
T2 as(
select distinct CONCAT(games,"-",count(distinct NOC)) as lowest_countries from olympics.OLYMPICS_HISTORY group by games 
order by count(distinct NOC) asc limit 1)

select * from T2,T1;
select distinct games from olympics.OLYMPICS_HISTORY where team='France' order by 1;

WITH T3 as 
(select distinct NOC,count(distinct games) total_participated_games from olympics.OLYMPICS_HISTORY group by team order by 2 desc),
T4 as
(select * from olympics.NOC_REGIONS)

-- select * from olympics.NOC_REGIONS where trim(NOC) ='SUI'

select T4.Region,T3.total_participated_games from T3 inner join T4 on T3.NOC=T4.NOC order by 2 desc;

      with tot_games as
              (select count(distinct games) as total_games
              from olympics.OLYMPICS_HISTORY),
          countries as
              (select games, nr.region as country
              from olympics.OLYMPICS_HISTORY oh
              join olympics.NOC_REGIONS nr ON nr.noc=oh.noc
              group by games, nr.region),
          countries_participated as
              (select country, count(1) as total_participated_games
              from countries
              group by country)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.total_participated_games
      order by 1;

select distinct sport from olympics.OLYMPICS_HISTORY where season='Summer' order by 1;

with t1 as(
	select  count(distinct(games)) summer_count from olympics.OLYMPICS_HISTORY where season='Summer' 
),
t2 as
(
	select distinct sport,count(distinct games) sport_count from olympics.OLYMPICS_HISTORY where season='Summer' group by sport
)

select t2.sport,t2.sport_count,t1.summer_count from t1 join t2 on t1.summer_count=t2.sport_count;

select distinct sport,count(distinct games) cnt from olympics.OLYMPICS_HISTORY  group by sport having cnt=1;

select * from olympics.OLYMPICS_HISTORY  where medal='Gold' group by medal having max(age);

select * from olympics.OLYMPICS_HISTORY  where age in (select max(age) from olympics.OLYMPICS_HISTORY where medal='Gold')
and medal='Gold';

WITH C2 as(
select * from olympics.OLYMPICS_HISTORY where medal='Gold'
),
C3 as(
select max(age) age1 from olympics.OLYMPICS_HISTORY where medal='Gold'
)

select * from C2 join C3 on C2.age = C3.age1;

with c1 as(
select count(sex) m_cnt from olympics.OLYMPICS_HISTORY where sex= 'M'
),
c2 as(
select count(sex) f_cnt from olympics.OLYMPICS_HISTORY where sex= 'F'
),
c3 as(
select count(sex) total_cnt from olympics.OLYMPICS_HISTORY
)
select concat('1 : ',round(c1.m_cnt/c2.f_cnt,2)) ratio from c1,c2,c3;

select distinct name,team,count(medal) from olympics.OLYMPICS_HISTORY where medal='Gold' group by name,team order by 3 desc,1 asc
limit 10;

select distinct name,team,count(medal) from olympics.OLYMPICS_HISTORY where medal<> 'No Medal' group by name,team 
order by 3 desc;

select * from olympics.OLYMPICS_HISTORY;

select * from olympics.NOC_REGIONS;

select distinct ta2.region,count(ta1.medal) total_medals,dense_rank() over (order by count(ta1.medal) desc) rnk 
from olympics.OLYMPICS_HISTORY ta1 join olympics.NOC_REGIONS ta2 on ta1.NOC=ta2.NOC where ta1.medal<>'No Medal' group by ta2.region
limit 5;

with c0 as(
select distinct o2.region,o2.noc from olympics.OLYMPICS_HISTORY o1 join olympics.NOC_REGIONS o2 on o1.noc=o2.noc
),
c1 as (
select distinct noc,count(medal) gold_count from olympics.OLYMPICS_HISTORY where medal='Gold' group by noc
),
c2 as(
select distinct noc,count(medal) silver_count from olympics.OLYMPICS_HISTORY where medal='Silver' group by noc
),
c3 as(
select distinct noc,count(medal) bronze_count from olympics.OLYMPICS_HISTORY where medal='Bronze' group by noc
)

select distinct trim(c0.region),c1.gold_count,c2.silver_count,c3.bronze_count from c0 left outer join c1 on c0.noc=c1.noc left join c2 
on c0.noc=c2.noc left join c3 on c0.noc=c3.noc order by 2 desc;

select distinct noc,region from olympics.NOC_REGIONS  order by region asc;

select distinct noc,team from olympics.OLYMPICS_HISTORY order by 2;

select * from olympics.OLYMPICS_HISTORY where NOC='RUS' and medal='Gold';


with c0 as(
select distinct o1.games,o2.region,o2.noc from olympics.OLYMPICS_HISTORY o1 inner join olympics.NOC_REGIONS o2 on o1.noc=o2.noc order by 1,2
),
c1 as (
select distinct games,noc,count(medal) gold_count from olympics.OLYMPICS_HISTORY where medal='Gold' group by noc,games
),
c2 as(
select distinct games,noc,count(medal) silver_count from olympics.OLYMPICS_HISTORY where medal='Silver' group by noc,games
),
c3 as(
select distinct games,noc,count(medal) bronze_count from olympics.OLYMPICS_HISTORY where medal='Bronze' group by noc,games
)

select distinct c0.games,c0.region,c1.gold_count,c2.silver_count,c3.bronze_count from c0 inner join c1 on c0.games=c1.games and 
 c0.noc=c1.noc inner join c2 on c0.noc=c2.noc inner join c3 on c0.noc=c3.noc order by 1,2 asc;
 

select sport,count(medal) from olympics.OLYMPICS_HISTORY where team='india' and medal<>'No Medal' group by sport;

select * from olympics.OLYMPICS_HISTORY where sport='Cricket';
WITH t1 as(
select name,count(name) as total_goldmedals from olympics.OLYMPICS_HISTORY where medal='Gold' group by name order by 2 desc LIMIT 10)

select *,dense_rank() over(order by total_goldmedals desc) from t1

