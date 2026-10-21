-- Domaci 3.2

-- Osnovni nivo
-- Prvi zadatak: Prikažite naziv svakog kluba i naziv stadiona na kojem igra domaće utakmice.
select t.team_name, s.stadium_name
from bootcamp.northern_star.teams t
left join bootcamp.northern_star.stadiums s
on t.stadium_id = s.stadium_id

-- Drugi zadatak: Prikažite ime i prezime igrača i naziv kluba za koji je igrao u sezoni 2024/25. Uklonite duplikate iz rezultata.
select p.first_name, p.last_name, t.team_name
from bootcamp.northern_star.players p
join bootcamp.northern_star.player_match_stats pm
on p.player_id = pm.player_id
join bootcamp.northern_star.teams t
on pm.team_id = t.team_id
join bootcamp.northern_star.matches m
on pm.match_id = m.match_id
where m.season = '2024/25'

-- Treci zadatak: Prikažite datum odigravanja utakmice, naziv stadiona i broj gledalaca za sve utakmice u sezoni 2024/25.
select m.kickoff_ts, m.attendance, s.stadium_name
from bootcamp.northern_star.matches m
join bootcamp.northern_star.stadiums s
on m.stadium_id = s.stadium_id
where m.season = '2024/25'
order by m.kickoff_ts

-- Srednji nivo
-- Prvi zadatak: Prikažite sve utakmice za koje nije evidentiran broj gledalaca. Prikažite datum, domaći klub i gostujući klub.
select m.kickoff_ts, t1.team_name, t2.team_name
from bootcamp.northern_star.matches m
join bootcamp.northern_star.teams t1
on m.home_team_id = t1.team_id
join bootcamp.northern_star.teams t2
on m.away_team_id = t2.team_id
where m.attendance is null

-- Drugi zadatak: Pronađite stadione na kojima nije odigrana ni jedna utakmica u sezoni 2024/25.
select s.stadium_name, sum(case when m.season = '2024/25' then 1 else 0 end) as br_utakmica
from bootcamp.northern_star.stadiums s
left join bootcamp.northern_star.matches m
on s.stadium_id = m.stadium_id
group by s.stadium_name
having br_utakmica = 0

-- Treci zadatak: Za svaki klub izračunajte ukupan broj žutih kartona koje su dobili njegovi igrači u sezoni 2024/25. Rezultat sortirajte opadajuće prema broju kartona.
select t.team_name, count(me.event_id) as br_zutih
from bootcamp.northern_star.teams t
join bootcamp.northern_star.match_events me
on t.team_id = me.team_id
join bootcamp.northern_star.matches m
on me.match_id = m.match_id
where m.season = '2024/25' and me.event_type in ('yellow_card', 'second_yellow')
group by team_name
order by br_zutih desc

-- Napredni nivo

-- Prvi zadatak: Pronađite pet igrača sa najvećim brojem asistencija u sezoni 2024/25. Prikažite ime igrača i broj asistencija.
select p.first_name, p.last_name, count(*) as asistencije
from bootcamp.northern_star.players p
join bootcamp.northern_star.match_events me
on p.player_id = me.related_player_id
join bootcamp.northern_star.matches m
on me.match_id = m.match_id
where m.season = '2024/25' and me.event_type = 'goal'
group by p.first_name, p.last_name
order by asistencije desc
limit 5

-- Drugi zadatak: Pronađite tri igrača sa najvećim ukupnim brojem odigranih minuta u sezoni 2024/25. Prikažite ime igrača, klub i ukupan broj minuta.
select p.first_name, p.last_name, t.team_name, sum(pm.minutes_played) minuti
from bootcamp.northern_star.players p
join bootcamp.northern_star.player_match_stats pm
on p.player_id = pm.player_id
join bootcamp.northern_star.teams t
on pm.team_id = t.team_id
join bootcamp.northern_star.matches m
on pm.match_id = m.match_id
where m.season = '2024/25'
group by p.first_name, p.last_name, t.team_name
order by minuti desc

--Treci zadatak: Za svaku sezonu prikažite broj isključenja po klubovima. Računajte događaje red card i second_yellow. Uključite samo klubove koji su imali najmanje jedno isključenje.
select m.season, t.team_name, count(m.match_id) as br_iskljucenja
from bootcamp.northern_star.teams t
join bootcamp.northern_star.match_events me
on t.team_id = me.team_id
join bootcamp.northern_star.matches m
on me.match_id = m.match_id
where me.event_type in ('red_card', 'second_yellow')
group by m.season, t.team_name
order by br_iskljucenja desc