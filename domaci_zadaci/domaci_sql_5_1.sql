-- Domacu 5.1

-- Prvi zadatak: Za sezonu 2024/25 prikažite igrače i ukupan broj golova koje su postigli. Prikažite samo igrače koji su postigli bar jedan gol.

with golovi as (
    select p.player_id, p.first_name, p.last_name, count(*) br_golova
    from players p join match_events me on p.player_id = me.player_id
    join matches m on me.match_id = m.match_id
    where m.season = '2024/25' and me.event_type in ('goal', 'own_goal')
    group by p.player_id, p.first_name, p.last_name
)
select player_id, first_name, last_name, br_golova,
dense_rank() over (order by br_golova desc) as rank
from golovi

-- Drugi zadatak: Za sezonu 2024/25 prikažite tri igrača sa najviše postignutih golova za svaki klub.
with igraci as (
    select t.team_id, p.player_id, p.first_name, p.last_name, count(*) br_golova
    from players p join match_events me on p.player_id = me.player_id
    join matches m on me.match_id = m.match_id
    join teams t on me.team_id = t.team_id
    where m.season = '2024/25' and me.event_type in ('goal', 'own_goal')
    group by t.team_id, p.player_id, p.first_name, p.last_name
)
select team_id, player_id, first_name, last_name, br_golova,
row_number() over (partition by team_id order by br_golova desc) as rank
from igraci

-- Treci zadatak: Za sezonu 2024/25 prikažite sve utakmice svakog kluba, broj golova koje je klub postigao i broj golova koje je postigao u svojoj prethodnoj utakmici.

with klubovi as (
    select t.team_name, m.match_id, m.kickoff_ts,
    case when t.team_id = m.home_team_id then m.home_goals else m.away_goals end as golovi
    from matches m join teams t on m.home_team_id = t.team_id or m.away_team_id = t.team_id
    where m.season = '2024/25' and m.status = 'played'

)
,prethodna as (
    select team_name, match_id, kickoff_ts, golovi, LAG(golovi) over (partition by team_name order by kickoff_ts, match_id) as prethodni_golovi
    from klubovi
)
select team_name, match_id, kickoff_ts, golovi, prethodni_golovi
, golovi - prethodni_golovi as razlika
from prethodna
order by team_name, match_id, kickoff_ts

