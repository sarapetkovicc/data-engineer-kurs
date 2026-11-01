-- Domaci 6.1

-- Prvi zadatak: Kreiranje dimenzije igrača. Na osnovu tabele players napravite tabelu dim_player koja sadrži sledeće kolone: player_id, ime, prezime, poziciju i nacionalnost igrača. Koliko redova ima novokreirana tabela?

create or replace table dim_player as
select player_id, first_name, last_name, position, nationality 
from players

select count(*) from dim_player

-- Ima 681 red, isto koliko i originalna players tabela

-- Drugi zadaak: Kreiranje dimenzije datuma i činjenične tabele: Napravite tabelu dim_date na isti način kao na predavanju. Zatim napravite tabelu fact_player match na osnovu tabela player match stats i matches. Tabela treba da sadrži sledeće kolone: match_id, date_key, player_id, team_id, minutes_played, shots, passes i rating. U tabelu uključite samo podatke koji se odnose na odigrane utakmice. Kolika je granularnost tabele fact_player_match, odnosno šta predstavlja jedan njen red? Koliko redova ima ova tabela?

create or replace table dim_date as 
select cast(date_format(d, 'yyyyMMdd') as int) as date_key,
d as full_date,
date_format(d, 'EEEE') AS weekday_name,
dayofweek(d) IN (1, 7) AS is_weekend,
case when month(d) >= 7
then concat(year(d), '/', substring(cast(year(d) + 1 as string), 3, 2))
else concat(year(d) - 1, '/', substring(cast(year(d) as string), 3, 2))
end as season
from (select explode(sequence(date'2023-07-01', date'2025-06-30', interval 1 day)) as d)

create or replace table fact_player_match as
select p.match_id, cast(date_format(m.kickoff_ts, 'yyyyMMdd') as int) as date_key,
p.player_id, p.team_id, p.minutes_played, p.shots, p.passes, p.rating
from player_match_stats p
join matches m on p.match_id = m.match_id
where m.status = 'played'

select count(*) from fact_player_match
-- Ima 30400 redova i svaki red predstavlja statistiku jednog igraca na jednoj utakmici

-- Treci zadatak: Prosečna ocena igrača po poziciji Koristeći napravljene dimenzije i činjeničnu tabelu, izračunajte prosečnu ocenu (rating) igrača za svaku poziciju tokom sezone 2024/25.Prikažite poziciju i odgovarajuću prosečnu ocenu.

select p.position, round(avg(f.rating), 2) as prosecna_ocena
from fact_player_match f join dim_player p on f.player_id = p.player_id
join dim_date d on f.date_key = d.date_key
join matches m on f.match_id = m.match_id
where m.season = '2024/25' and not isnan(f.rating)
group by p.position
order by prosecna_ocena desc

-- FW	6.79
--MF	6.72
--DF	6.64
--GK	6.6


-- Cetvrti zadatak: Dodavanje broja golova u činjeničnu tabelu Proširite tabelu fact_player_match dodavanjem kolone koja predstavlja broj golova koje je svaki igrač postigao na određenoj utakmici.Koliki je ukupan zbir golova svih igrača u tabeli fact_player_match?

alter table fact_player_match add columns (goals int)

select match_id, player_id, count(*) as br_golova
from match_events 
where event_type in ('goal', 'penalty_goal')
group by match_id, player_id

merge into fact_player_match f
using (
    select match_id, player_id, count(*) as br_golova
    from match_events
    where event_type in ('goal', 'penalty_goal')
    group by match_id, player_id
) e
on f.match_id = e.match_id
and f.player_id = e.player_id
when matched then update set f.goals = e.br_golova

update fact_player_match
set goals = 0
where goals is null

select sum(goals) ukupno_golova
from fact_player_match

-- Ukupan zbir golova je 2043