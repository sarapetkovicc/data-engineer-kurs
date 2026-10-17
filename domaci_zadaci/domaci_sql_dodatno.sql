--Domaci zadatak 2.2 dodatno


-- Prvi zadatak: Prebrojte utakmice za koje nisu evidentirani ni sudija ni poseta.
select count(match_id)
from bootcamp.northern_star.matches_flat 
where attendance is null and referee_name is null
-- Ne postoje takve utakmice

-- Drugi zadatak: Prikažite sve utakmice odigrane između 1. i 31. marta 2025. godine, uključujući oba datuma. Rezultate sortirajte po datumu odigravanja.
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2025-03-01' and kickoff_ts < '2025-04-01'
order by kickoff_ts
-- Ima 40 utakmica

-- Treci zadatak: Koliko je utakmica odigrano u periodu od 20. decembra 2024. do 10. januara 2025. godine, uključujući oba datuma?
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2024-12-20' and kickoff_ts < '2025-01-11'
order by kickoff_ts
-- Ima 51 utakmica

-- Cetvrti zadatak: Napravite kolonu attendance_status koja prikazuje broj gledalaca ako je poseta evidentirana, a tekst Unknown ako podatak o poseti nedostaje. Prikažite datum utakmice, domaći tim, gostujući tim i novu kolonu
select home_team, away_team, kickoff_ts, coalesce(cast(attendance as string), 'Unknown') as attendance_status
from bootcamp.northern_star.matches_flat 
order by attendance_status desc
-- Postoji 17 utakmica bez evidentiranog broja gledalaca

-- Peti zadatak:
-- Prvi zadatak: Prebrojte utakmice za koje nisu evidentirani ni sudija ni poseta.
select count(match_id)
from bootcamp.northern_star.matches_flat 
where attendance is null and referee_name is null
-- Ne postoje takve utakmice

-- Drugi zadatak: Prikažite sve utakmice odigrane između 1. i 31. marta 2025. godine, uključujući oba datuma. Rezultate sortirajte po datumu odigravanja.
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2025-03-01' and kickoff_ts < '2025-04-01'
order by kickoff_ts
-- Ima 40 utakmica

-- Treci zadatak: Koliko je utakmica odigrano u periodu od 20. decembra 2024. do 10. januara 2025. godine, uključujući oba datuma?
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2024-12-20' and kickoff_ts < '2025-01-11'
order by kickoff_ts
-- Ima 51 utakmica

-- Cetvrti zadatak: Napravite kolonu attendance_status koja prikazuje broj gledalaca ako je poseta evidentirana, a tekst Unknown ako podatak o poseti nedostaje. Prikažite datum utakmice, domaći tim, gostujući tim i novu kolonu
select home_team, away_team, kickoff_ts, coalesce(cast(attendance as string), 'Unknown') as attendance_status
from bootcamp.northern_star.matches_flat 
order by attendance_status desc
-- Postoji 17 utakmica bez evidentiranog broja gledalaca

-- Peti zadatak: 
-- Prvi zadatak: Prebrojte utakmice za koje nisu evidentirani ni sudija ni poseta.
select count(match_id)
from bootcamp.northern_star.matches_flat 
where attendance is null and referee_name is null
-- Ne postoje takve utakmice

-- Drugi zadatak: Prikažite sve utakmice odigrane između 1. i 31. marta 2025. godine, uključujući oba datuma. Rezultate sortirajte po datumu odigravanja.
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2025-03-01' and kickoff_ts < '2025-04-01'
order by kickoff_ts
-- Ima 40 utakmica

-- Treci zadatak: Koliko je utakmica odigrano u periodu od 20. decembra 2024. do 10. januara 2025. godine, uključujući oba datuma?
select match_id, kickoff_ts
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2024-12-20' and kickoff_ts < '2025-01-11'
order by kickoff_ts
-- Ima 51 utakmica

-- Cetvrti zadatak: Napravite kolonu attendance_status koja prikazuje broj gledalaca ako je poseta evidentirana, a tekst Unknown ako podatak o poseti nedostaje. Prikažite datum utakmice, domaći tim, gostujući tim i novu kolonu
select home_team, away_team, kickoff_ts, coalesce(cast(attendance as string), 'Unknown') as attendance_status
from bootcamp.northern_star.matches_flat 
order by attendance_status desc
-- Postoji 17 utakmica bez evidentiranog broja gledalaca

-- Peti zadatak: Prikažite utakmice odigrane u periodu od 1. do 30. aprila 2025. godine kod kojih je postignuto između 2 i 4 gola ukupno, uključujući obe granice. Rezultate sortirajte po datumu.
select match_id, kickoff_ts, (home_goals + away_goals) as ukupno
from bootcamp.northern_star.matches_flat 
where kickoff_ts >= '2025-04-01' and kickoff_ts < '2025-05-01' and (home_goals + away_goals) between 2 and 4
-- Postoji 22 utakmice

-- Sesti zadatak: Pronađite utakmice kod kojih je rezultat na poluvremenu bio nerešen, ali je konačni rezultat bio različit. Prikažite datum, timove, rezultat na poluvremenu i konačni rezultat.
select match_id, home_team, away_team, kickoff_ts, home_goals_ht, away_goals_ht, home_goals, away_goals
from bootcamp.northern_star.matches_flat 
where home_goals_ht = away_goals_ht and home_goals <> away_goals 
-- Ima 244 utakmice



