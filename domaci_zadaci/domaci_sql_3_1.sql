-- Domaci 3.1
-- Prvi zadatak: Za svaku sezonu prikažite ukupan broj utakmica, ukupan broj postignutih golova i prosečan broj golova po utakmici.
select season, count(*) as br_utakmica, sum(home_goals+away_goals) as suma,avg(home_goals+away_goals) as prosek
from bootcamp.northern_star.matches 
group by season
order by season

-- Drugi zadatak: Za svaki stadion prikažite najmanju, najveću i prosečnu zabeleženu posetu, kao i broj utakmica za koje je poseta poznata.
select s.stadium_name, min(m.attendance) as min, max(m.attendance) as max, 
avg(m.attendance) as prosek, count(m.attendance) as poznata_poseta
from bootcamp.northern_star.matches m
join bootcamp.northern_star.stadiums s
on m.stadium_id = s.stadium_id
group by s.stadium_name

-- Treci zadatak: Prikažite sudije koje su sudile najmanje 10 utakmica i koje su ukupno pokazale najmanje 20 žutih kartona. Prikažite ime sudije, broj utakmica i ukupan broj žutih kartona.
select r.referee_name, count(distinct m.match_id) as br_utakmica,
count(case when me.event_type in ('yellow_card', 'second_yellow') then me.event_id end) as zuti_kartoni
from bootcamp.northern_star.referees r
join bootcamp.northern_star.matches m
on r.referee_id = m.referee_id
join bootcamp.northern_star.match_events me
on m.match_id = me.match_id
group by r.referee_name
having br_utakmica >= 10 and zuti_kartoni >= 20
order by zuti_kartoni desc

-- Cetvrti zadatak: Podelite utakmice prema ukupnom broju golova na kategorije Bez golova (0), Malo golova (1 ili 2) i Mnogo golova (3 ili više). Prikažite broj utakmica u svakoj kategoriji i najveći broj golova na utakmici u toj kategoriji.
select case when home_goals + away_goals = 0 then 'Bez golova'
when home_goals + away_goals <= 2 then 'Malo golova'
else 'Mnogo golova'
end as kategorija,
count(*) as br_utakmica,
max(home_goals + away_goals) as max_golova
from bootcamp.northern_star.matches
group by kategorija
order by br_utakmica desc

-- Peti zadatak: Za svaki klub prikažite broj utakmica koje je odigrao kao domaćin, broj pobeda kod kuće i broj poraza kod kuće. U rezultat uključite samo klubove koji su kod kuće odigrali najmanje 10 utakmica.
select t.team_name, count(*) as br_utakmica, sum(case when home_goals > away_goals then 1 else 0 end) as br_pobeda,
sum(case when home_goals < away_goals then 1 else 0 end) as br_poraza
from bootcamp.northern_star.teams t
join bootcamp.northern_star.matches m
on t.team_id = m.home_team_id
group by t.team_name
having br_utakmica >= 10
order by br_pobeda desc

-- Sesti zadatak: Za svakog sudiju prikažite ukupan broj utakmica, broj utakmica u kojima je pokazao bar jedan crveni karton i procenat takvih utakmica u odnosu na sve utakmice koje je sudio.
select r.referee_name,
count(distinct m.match_id) as br_utakmica,
count(distinct case when me.event_type in ('red_card', 'second_yellow') then m.match_id end ) as br_crvenih,
(count(distinct case when me.event_type in ('red_card', 'second_yellow') then m.match_id end ) / count(distinct m.match_id) ) * 100 as procenat
from bootcamp.northern_star.referees r
join bootcamp.northern_star.matches m
on r.referee_id = m.referee_id
left join bootcamp.northern_star.match_events me
on m.match_id = me.match_id
group by r.referee_name
order by procenat desc

-- Sedmi zadatak: Za svaku sezonu prikažite broj pobeda domaćina, broj nerešenih utakmica i broj pobeda gostiju. Takođe prikažite procenat utakmica koje su završene nerešenim rezultatom.
select season,
sum(case when home_goals > away_goals then 1 else 0 end) as pobeda_domacin,
sum(case when home_goals = away_goals then 1 else 0 end) as nereseno,
sum(case when home_goals < away_goals then 1 else 0 end) as poebda_gost,
(sum(case when home_goals = away_goals then 1 else 0 end) / count(*)) * 100 as procenat_nereseno
from bootcamp.northern_star.matches
group by season
order by season