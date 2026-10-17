-- Domaci zadatak 2.2



-- Prvi zadatak: Pronađite sve utakmice čiji naslov (`match_report`)sadrži reč `goal`, bez obzira na velika i mala slova.
select match_id, match_report
from bootcamp.northern_star.matches_flat 
where match_report ilike '%goal%'
-- Ima 41 utakmica

-- Drugi zadatak: Napravite kolonu`refereename` tako da sadrži ime_sudije ako postoji, a tekst `Unknown`ako nedostaje podatak. Prikažite 20 utakmica.
select match_id, coalesce(referee_name, 'Unknown') as refereename
from bootcamp.northern_star.matches_flat 
limit 20
-- Sve utakmice imaju ime sudije

-- Treci zadatak: Prikažite utakmice čiji je naslov duži od 40 znakova. Prikažite naslov i broj znakova u njemu.
select match_id, match_report, len(match_report) as duzina_naslova
from bootcamp.northern_star.matches_flat 
where len(match_report) > 40
-- Ima 537 utakmica

-- Cetvrti zadatak: Prikažite utakmice odigrane od 1. do 15. januara 2025, uključujući oba datuma.
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2025-01-01' and kickoff_ts < '2025-01-16'
order by kickoff_ts 
-- Ima 31 utakmica

-- Peti zadatak:  Prebrojte utakmice odigrane petkom. Prikažite datum i dan u nedelji za svaku od njih.
select match_id, kickoff_ts, day(kickoff_ts) as dan
from bootcamp.northern_star.matches_flat 
where dayofweek(kickoff_ts) = 6
-- Ima 0 utakmica

-- Sesti zadatak: Koliko utakmica sezone `2024/25` je imalo između 20.000 i 35.000 gledalaca, uključujući obe granice?
select match_id, season, attendance
from bootcamp.northern_star.matches_flat 
where season ='2024/25' and attendance between 20000 and 35000
-- Ima 188 utakmica

-- Sedmi zadatak: Pronađite strelce prvog gola čije ime počinje slovom A ili sadrži crticu. Prikažite samo različita imena.
select distinct first_goal_scorer
from bootcamp.northern_star.matches_flat 
where first_goal_scorer like 'A%' or first_goal_scorer like '%-%' 
-- Ima 22 razlicita strelca

-- Osmi zadatak: Prikažite utakmice sezone `2024/25` koje su počele između 18:00 i 21:00, uključujući obe granice. Prikažite vreme početka i nazive timova.
select match_id, home_team, away_team, hour(kickoff_ts)
from bootcamp.northern_star.matches_flat 
where hour(kickoff_ts) between 18 and 21
-- Ima 39 utakmica

-- Deveti zadatak: Prebrojte utakmice odigrane u martu, aprilu ili maju 2025. godine čiji naslov sadrži reč `win`, bez obzira na veličinu slova.
select match_id, month(kickoff_ts), year(kickoff_ts), match_report
from bootcamp.northern_star.matches_flat 
where month(kickoff_ts) in (3,4,5) and year(kickoff_ts) = 2025
and match_report ilike '%win%'
--Ima ih 5
