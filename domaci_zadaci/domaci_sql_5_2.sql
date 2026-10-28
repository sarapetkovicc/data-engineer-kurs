-- Domaci 5.2

-- Prvi zadatak: Prosek datih golova u poslednjih 5 utakmica, uz izričit okvir prozora. Koja je najveća vrednost? Računajte samo kada prozor zaista ima 5 utakmica.

with tabela as (
    select t.team_name, tm.match_id, tm.kickoff_ts,
    tm.goals_for as golovi,
    avg(tm.goals_for) over (partition by tm.season, tm.team_id order by tm.kickoff_ts, tm.match_id
    rows between 4 preceding and current row) as prosek,
    count(*) over (partition by tm.season, tm.team_id order by tm.kickoff_ts, tm.match_id
    rows between 4 preceding and current row) as br_utakmica
    from bootcamp.northern_star.teams t join team_matches tm on t.team_id = tm.team_id 
    where tm.season = '2024/25'
    
)
select team_name, match_id, kickoff_ts, golovi, prosek
from tabela
where br_utakmica <= 5
order by prosek desc

-- Drugi zadatak: Tekući zbir datih golova svakog kluba u sezoni 2024/25: ko je prvi stigao do 50 golova i kada?

with tabela as (
    select t.team_name, tm.match_id, tm.kickoff_ts,
    tm.goals_for as golovi,
    sum(tm.goals_for) over (partition by tm.season, tm.team_id order by tm.kickoff_ts, tm.match_id
    rows between unbounded preceding and current row) as ukupno_golova
    from bootcamp.northern_star.teams t join team_matches tm on t.team_id = tm.team_id 
    where tm.season = '2024/25'
    
),
tabela2 as (
    select team_name, match_id, kickoff_ts, golovi, ukupno_golova,
    row_number() over (partition by team_name order by kickoff_ts, match_id) redni_br
    from tabela 
    where ukupno_golova >= 50

)
select team_name, match_id, kickoff_ts, golovi
from tabela2
where redni_br = 1
order by kickoff_ts, match_id
limit 1

-- Treci zadatak: Za svaku domaću utakmicu izračunajte promenu posećenosti u odnosu na prethodnu domaću utakmicu istog kluba u istoj sezoni. Gde je najveći pad i zašto?

with tabela as (
    select t.team_name, m.match_id, m.kickoff_ts, m.attendance,
    lag(m.attendance) over (partition by m.season, m.home_team_id order by m.kickoff_ts, 
    m.match_id) as prethodne_posete
    from bootcamp.northern_star.teams t join matches m on t.team_id = m.home_team_id 
    where m.season = '2024/25' and m.status = 'played'
    
)
select team_name, match_id, kickoff_ts, attendance, prethodne_posete, attendance - prethodne_posete as promena
from tabela
order by team_name, kickoff_ts, match_id


