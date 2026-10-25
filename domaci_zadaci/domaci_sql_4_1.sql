--Domaci 4.1

-- Prvi zadatak: Koliko redova ima spoj matches i player_match_stats za sezonu 2024/25? Objasnite.
select count(*) utakmice
from matches m join player_match_stats ps
on m.match_id=ps.match_id
where m.season='2024/25'
-- Ima 15200 redova zbog toga sto jedna utakmica ima vise igraca i kada spajamo ove dve tabele preko kolone match_id, match_id se ppnavlja u player match stats za svakog igraca

-- Drugi zadatak: Koliko puta je igrač u istoj sezoni igrao za dva različita kluba?
with igraci as (
    select ps.player_id, m.season
    from player_match_stats ps join matches m
    on ps.match_id=m.match_id
    group by ps.player_id, m.season
    having count(distinct ps.team_id)>1
)
select count(*) broj_igraca
from igraci
-- Igrali su 35 puta

-- Treci zadatak: Koliko utakmica ima više kartona od prosečne utakmice? Bez kartona računajte sa 0.
with kartoni as (
    select m.match_id,
    count(case when me.event_type in ('yellow_card','second_yellow','red_card') then 1 end) as broj_kartona
    from matches m join match_events me
    on m.match_id=me.match_id
    group by m.match_id
)
select count(*) utakmice
from kartoni
where broj_kartona>(select avg(broj_kartona) from kartoni)
-- Ima 370 utakmica

-- Cetvrti zadatak: Koliko igrača je odigralo više od 10 utakmica u sezoni 2024/25?
select ps.player_id, count(distinct ps.match_id) broj_utakmica
from player_match_stats ps join matches m
on ps.match_id=m.match_id
where m.season='2024/25'
group by ps.player_id
having broj_utakmica>10
-- Ukupni 483 igraca

-- Peti zadatak: Prikažite sve klubove koji su igrali u sezoni 2024/25, bilo kao domaćini ili kao gosti. Koristite UNION, a zatim izmenite upit tako da koristi UNION ALL. Objasnite razliku u broju redova koji dobijate.

select t.team_id
from teams t
join matches m
on t.team_id=m.home_team_id
where m.season='2024/25'
union
select t.team_id
from teams t
join matches m
on t.team_id=m.away_team_id
where m.season = '2024/25'

select t.team_id
from teams t
join matches m
on t.team_id=m.home_team_id
where m.season='2024/25'
union all
select t.team_id
from teams t
join matches m
on t.team_id=m.away_team_id
where m.season = '2024/25'
-- Kada koristimo union dobijamo 20 redova zato sto union brise sve duplikate dok kod union all dobijamo 760 redova

