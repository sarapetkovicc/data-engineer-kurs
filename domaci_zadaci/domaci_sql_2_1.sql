--Domaci zadatak 2.1


-- Prvi zadatak: Dodajte kolonu empty_seats (kapacitet stadiona minus poseta) i prikažite 5 utakmica sa najviše praznih mesta. Šta je zajedničko prvim trima?
select *, (stadium_capacity-attendance) as empty_seats
from bootcamp.northern_star.matches_flat
order by empty_seats desc
limit 5
--Prve tri su bile u avgustu i igrali su Oakfield Town na domacem stadionu

-- Drugi zadatak: Koliko različitih sudija je sudilo domaće utakmice kluba Riverton Athletic?
select count(distinct referee_name)
from bootcamp.northern_star.matches_flat
where home_team = 'Riverton Athletic'
--Sudilo je 15 razlicitih sudija

-- Treci zadatak: U koliko utakmica je gost vodio na poluvremenu, a domaćin na kraju pobedio?
select count(match_id)
from bootcamp.northern_star.matches_flat
where away_goals_ht > home_goals_ht and  home_goals > away_goals
-- U 15 utakmica

-- Cetvrti zadatak: U kojoj utakmici je palo najviše golova u drugom poluvremenu? Ko je igrao, rezultat na poluvremenu i rezultat na kraju?
select match_id, home_team, away_team, home_goals_ht, away_goals_ht, home_goals, away_goals,
(home_goals + away_goals) - (home_goals_ht + away_goals_ht) as goals_second_half
from bootcamp.northern_star.matches_flat
order by goals_second_half desc
limit 1
-- Utakmica id 2083, igrali su Northport United i Newbury Forest, rezultat na poluvremenu je bio 1:0 a na kraju 6:3, u drugom poluvremenu je palo ukupno 8 golova

-- Peti zadatak: Koliko utakmica sezone 2023/24 je odigrano po snegu ili magli?
select count(match_id)
from bootcamp.northern_star.matches_flat
where weather in ('snow', 'fog') and season = '2023/24'
-- Odigrano je 25 utakmica

-- Sesti zadatak: Prikažite sve utakmice gradskog derbija između Northport United i Northport City, bez obzira na to ko je domaćin, sortirane po datumu. Ko je pobedio u kom meču?
select match_id, kickoff_ts, home_team, away_team, home_goals, away_goals
from bootcamp.northern_star.matches_flat
where (home_team = 'Northport United' and away_team = 'Northport City') 
or (home_team = 'Northport City' and away_team = 'Northport United')
order by kickoff_ts
-- Bilo je 4 utakmice, u prvoj je pobedio Northport United, u drugoj je bilo nereseno u trecoj Northport City a u cetvrtoj Northport United

-- Sedmi zadatak: Prikažite prve 3 utakmice sezone 2024/25 po vremenu početka. Da li možete biti sigurni koja je druga, a koja treća? Kako biste to obezbedili?
select match_id, kickoff_ts, home_team, away_team
from bootcamp.northern_star.matches_flat 
where season = '2024/25'
order by kickoff_ts, match_id
limit 3
-- Ne mozemo biti sigurni zato treba dodati dodatno sortiranje po match_id pa ce pored vremena biti sortirani i po id-u od najmanjeg do najveceg

-- Osmi zadatak: Prikažite sve utakmice u kojima je prvi gol dao Sean ONeill. Koliko ih je?
select match_id, home_team, away_team, first_goal_scorer
from bootcamp.northern_star.matches_flat 
where first_goal_scorer = 'Sean O\'Neill'
-- Dve utakmice

