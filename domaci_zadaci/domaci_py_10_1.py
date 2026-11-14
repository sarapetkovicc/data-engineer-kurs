# Domaci 10.1

# Prvi zadatak: 
# Analiza rezultata utakmica
# 1.Pronaći sve utakmice u kojima su oba tima postigla bar po jedan gol.
# 2.Pronaći sve utakmice u kojima je domaćin pobedio sa tačno jednim golom razlike.
# 3.Koliko utakmica je završeno rezultatom 0:0?
# 4.Prikazati 10 utakmica sa najviše ukupno postignutih golova.

import pandas as pd

R = '/Volumes/bootcamp/northern_star/raw_2025_26/'
m = pd.read_parquet(R + 'matches_2025_26.parquet')

# 1. Pronaći sve utakmice u kojima su oba tima postigla bar po jedan gol.

m.loc[(m['home_goals'] > 0) & (m['away_goals'] > 0)]

# 2. Pronaći sve utakmice u kojima je domaćin pobedio sa tačno jednim golom razlike.

m.loc[(m['home_goals'] - m['away_goals']) == 1]

# 3. Koliko utakmica je završeno rezultatom 0:0?

len(m.loc[(m['home_goals'] == 0) & (m['away_goals'] == 0)]) # 26

# 4. Prikazati 10 utakmica sa najviše ukupno postignutih golova.

m['total_goals'] = m['home_goals'] + m['away_goals']
m.nlargest(10, 'total_goals')

# Drugi zadatak: 
# Analiza jednog tima. Za tim po izboru:
# 1.Prikazati sve utakmice u kojima je učestvovao.
# 2.Koliko je puta pobedio, izgubio i odigrao nerešeno?
# 3.Koliko je golova postigao kao domaćin, a koliko kao gost?
# 4.Pronaći utakmicu u kojoj je postigao najviše golova.

# 1.Prikazati sve utakmice u kojima je učestvovao.

team = 'KLT'
m.loc[(m['home_team'] == team) | (m['away_team'] == team)]

# 2.Koliko je puta pobedio, izgubio i odigrao nerešeno?

len(m.loc[((m['home_team'] == team) & (m['home_goals'] > m['away_goals'])) |
          ((m['away_team'] == team) & (m['away_goals'] > m['home_goals']))]) # 10 pobeda
len(m.loc[((m['home_team'] == team) & (m['home_goals'] < m['away_goals'])) |
          ((m['away_team'] == team) & (m['away_goals'] < m['home_goals']))]) # 18 izguljenih
len(m.loc[((m['home_team'] == team) & (m['home_goals'] == m['away_goals'])) |
          ((m['away_team'] == team) & (m['away_goals'] == m['home_goals']))]) # nereseno


# 3.Koliko je golova postigao kao domaćin, a koliko kao gost?

m.loc[m['home_team'] == team, 'home_goals'].sum() # kao domacin 24
m.loc[m['away_team'] == team, 'away_goals'].sum() # kao gost 10

# 4.Pronaći utakmicu u kojoj je postigao najviše golova.

domacin = m.loc[m['home_team'] == team].nlargest(1, 'home_goals')
gost = m.loc[m['away_team'] == team].nlargest(1, 'away_goals')

if domacin['home_goals'].iloc[0] >= gost['away_goals'].iloc[0]:
    display(domacin)
else:
    display(gost)

# 2526053, 3 gola

# Treci zadatak: Analiza stadiona
# 1.Prikazati sve različite stadione na kojima su odigrane utakmice.
# 2.Pronaći stadion na kojem je odigrano najviše utakmica.
# 3.Za svaki stadion izračunati prosečnu posećenost.
# 4.Prikazati pet stadiona sa najvećom prosečnom posećenošću.

# 1.Prikazati sve različite stadione na kojima su odigrane utakmice.

m['stadium'].unique()

# 2.Pronaći stadion na kojem je odigrano najviše utakmica.

m['stadium'].value_counts().head(1) # Crowsnest 19

# 3.Za svaki stadion izračunati prosečnu posećenost.

m.groupby('stadium')['attendance'].mean()

# 4.Prikazati pet stadiona sa najvećom prosečnom posećenošću.

m.groupby('stadium')['attendance'].mean().nlargest(5)

# Lighthouse Stadium       24214.526316
# Harbour Park             23820.631579
# The Foundry              23818.842105
# Moorside Arena           21719.894737
# Northern Lights Arena    20953.111111
