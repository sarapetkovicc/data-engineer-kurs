# Domaci 8.1

# Prvi zadatak: Napisati funkciju get_even_positions(data: tuple) -> tuple koja vraća elemente torke koji se nalaze na parnim indeksima (0, 2, 4...). Input: (10, 20, 30, 40, 50, 60) Output: (10, 30, 50)

vrati = (10, 20, 30, 40, 50, 50)

def get_even_positions(data):
    novo = ()
    for i in range(len(data)):
        if i % 2 == 0:
            novo += (data[i],)

    return novo

get_even_positions(vrati)


# Drugi zadatak: Napisati funkciju find_exclusive_students(group1: set, group2:set) -> set koja vraća studente koji se nalaze u prvoj grupi, ali ne i u drugoj.

grupa1 = {'Ana','Marko','Jovan','Milica'}
grupa2 = {'Marko','Milica','Petar'}

def find_exclusive_students(grupa1, grupa2):
    nova_grupa = grupa1 - grupa2
    return nova_grupa

find_exclusive_students(grupa1, grupa2)
    


# Treci zadatak: Napisati funkciju clean_tags(text: str) -> str koja obrađuje tekst sa tagovima. Potrebno je:
#Razdvojiti tagove koji su odvojeni karakterom |
#Ukloniti početne i krajnje razmake svakog taga
#Sva slova pretvoriti u mala slova
#Spojiti tagove karakterom -
# Input: ' Python | DATA | SQL '

text = ' Python | DATA | SQL '

def clean_tags(text):
    text = text.strip().lower().split('|')
    return '-'.join(text)

clean_tags(text)

# Cetvrti zadatak: Napisati funkciju count_products(csv_lines: list) -> dict koja analizira porudžbine iz CSV podataka i vraća ukupan broj naručenih proizvoda. Svaki red sadrži ime kupca, naziv proizvoda i količinu, razdvojene zarezom. Prvi red predstavlja zaglavlje i treba ga zanemariti. Ako se isti proizvod pojavljuje u više redova, sabrati njegove količine.

csv_lines = ['customer,product,quantity','Alice,laptop,2','Bob,mouse,3','Alice,laptop,1','Charlie,keyboard,2','Bob,mouse,1']

def count_products(csv_lines):
    skip = csv_lines[1:]
    proizvodi = {}
    for i in skip:
        podaci = i.split(',')
        proizvod = podaci[1]
        kolicina = int(podaci[2])

        if proizvod in proizvodi:
            proizvodi[proizvod] += kolicina
        else:
            proizvodi[proizvod] = kolicina

    return proizvodi

count_products(csv_lines)