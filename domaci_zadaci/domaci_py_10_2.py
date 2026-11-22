# Domaci 10.2

# Prvi zadatak: Sistem beleži broj aktivnih korisnika tokom 12 uzastopnih sati.
# Potrebno je:
# Prikazati broj korisnika za peti sat.
# Prikazati broj korisnika za poslednja četiri sata.
# Izračunati ukupan broj aktivnih korisnika kroz svih 12 sati.
# Izračunati prosečan broj korisnika po satu.
# Pronaći sat sa najvećim brojem korisnika.

import numpy as np

korisnici = np.array([120, 150, 180, 200, 170, 190, 220, 250, 210, 230, 270, 260])

# Prikazati broj korisnika za peti sat.
print(korisnici[4])

# Prikazati broj korisnika za poslednja četiri sata.
print(korisnici[-4:])

# Izračunati ukupan broj aktivnih korisnika kroz svih 12 sati.
print(korisnici.sum())

# Izračunati prosečan broj korisnika po satu.
print(korisnici.mean())

# Pronaći sat sa najvećim brojem korisnika.
print(korisnici.argmax() + 1)

# Drugi zadatak: Sistem beleži CPU, RAM i disk usage za pet različitih servera.
# Redovi predstavljaju servere, a kolone CPU, RAM i disk usage.
# Potrebno je:
# Prikazati dimenzije matrice.
# Prikazati broj servera i broj metrika.
# Izračunati prosečnu vrednost svake metrike.
# Izračunati prosečnu potrošnju resursa za svaki server.
# Pronaći server sa najvećom prosečnom potrošnjom resursa.

serveri = np.array([[60, 70, 50],
                   [80, 65, 75],
                   [55, 60, 45],
                   [90, 85, 80],
                   [70, 75, 65]])

# Prikazati dimenzije matrice.
print(serveri.shape)

# Prikazati broj servera i broj metrika.
print(serveri.shape[0])
print(serveri.shape[1])

# Izračunati prosečnu vrednost svake metrike.
print(serveri.mean(axis=0))

# Izračunati prosečnu potrošnju resursa za svaki server.
print(serveri.mean(axis=1))

# Pronaći server sa najvećom prosečnom potrošnjom resursa.
print(serveri.mean(axis=1).argmax() + 1)

# Treci zadatak: Sistem beleži vreme izvršavanja 15 različitih procesa u sekundama. Potrebno je:
# Pronaći sve procese koji su trajali duže od 100 sekundi.
# Pronaći procese koji su trajali između 40 i 100 sekundi.
# Izbrojati procese koji su trajali kraće od 50 sekundi.
# Pronaći indekse procesa koji su trajali duže od 100 sekundi.
# Izračunati prosečno vreme izvršavanja svih procesa.

procesi = np.array([25, 45, 120, 80, 150, 35, 60, 110, 95, 40, 130, 20, 75, 105, 55])

# Pronaći sve procese koji su trajali duže od 100 sekundi.
print(procesi[procesi > 100])
# Pronaći procese koji su trajali između 40 i 100 sekundi.
print(procesi[(procesi >= 40) & (procesi <= 100)])
# Izbrojati procese koji su trajali kraće od 50 sekundi.
print(np.sum(procesi < 50))
# Pronaći indekse procesa koji su trajali duže od 100 sekundi.
print(np.where(procesi > 100)[0])
# Izračunati prosečno vreme izvršavanja svih procesa.
print(procesi.mean())

# Cetvrti zadatak: Prodavnica beleži prihode od četiri različite kategorije proizvoda tokom šest meseci. Redovi predstavljaju kategorije proizvoda, a kolone mesece. Potrebno je:
# Izračunati ukupan prihod svake kategorije proizvoda.
# Izračunati ukupan prihod za svaki mesec.
# Pronaći kategoriju proizvoda sa najvećim ukupnim prihodom.
# Pronaći mesec sa najvećim ukupnim prihodom.
# Izračunati prosečan prihod po kategoriji proizvoda.
# Izračunati prosečan mesečni prihod svih kategorija.
prihodi = np.array([[1200, 1700, 1400, 1300, 1800, 1500],
                    [2400, 2800, 1500, 2300, 2700, 2100],
                    [750, 500, 800, 1100, 1200, 900],
                    [1500, 1600, 1800, 1900, 2000, 1700]])

# Izračunati ukupan prihod svake kategorije proizvoda.
print(prihodi.sum(axis=1))
# Izračunati ukupan prihod za svaki mesec.
print(prihodi.sum(axis=0))
# Pronaći kategoriju proizvoda sa najvećim ukupnim prihodom.
print(prihodi.sum(axis=1).argmax() + 1)
# Pronaći mesec sa najvećim ukupnim prihodom.
print(prihodi.sum(axis=0).argmax() + 1)
# Izračunati prosečan prihod po kategoriji proizvoda.
print(prihodi.mean(axis=1))
# Izračunati prosečan mesečni prihod svih kategorija.
print(prihodi.sum(axis=0).mean())

# Peti zadatak: Sistem beleži prosečne dnevne temperature tokom 15 dana. Neki podaci nedostaju ili nisu validni. Validna temperatura mora biti između -20 i 50 stepeni.
# Potrebno je:
# Identifikovati nedostajuće vrednosti.
# Identifikovati nevalidne temperature (vrednosti manje od -20 ili veće od 50).
# Pronaći indekse nevalidnih vrednosti.
# Izračunati broj nedostajućih i nevalidnih vrednosti.
# Izračunati procenat nevalidnih i nedostajućih zapisa zajedno.
# Kreirati novi niz koji sadrži samo validne temperature.
# Izračunati prosečnu temperaturu bez nedostajućih i nevalidnih vrednosti.
temperatura = np.array([22, 21, np.nan, 29, 32,
                        18, 26, 31, np.nan, np.nan,
                        10, 15, 8, 13, -22])
# Identifikovati nedostajuće vrednosti.
print(np.isnan(temperatura))
# Identifikovati nevalidne temperature (vrednosti manje od -20 ili veće od 50).
nevalidne = (temperatura < -20) | (temperatura > 50)
print(temperatura[nevalidne])
# Pronaći indekse nevalidnih vrednosti.
print(np.where(nevalidne)[0])
# Izračunati broj nedostajućih i nevalidnih vrednosti.
print(np.isnan(temperatura).sum())
# Izračunati procenat nevalidnih i nedostajućih zapisa zajedno.
print((np.isnan(temperatura).sum() + nevalidne.sum()) / len(temperatura) * 100)
# Kreirati novi niz koji sadrži samo validne temperature.
validne = temperatura[(temperatura >= -20) & (temperatura <= 50)]
# Izračunati prosečnu temperaturu bez nedostajućih i nevalidnih vrednosti.
print(validne.mean())