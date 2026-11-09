# Domaci 8.2

# 16: Написати функцију count_lines(path: str) -> int која враћа број непразних редова у фајлу Input: 'data/raw/teams.csv' Output: 5 

path = './data/raw/teams.csv'
def count_lines(path):
    with open(path, 'r') as f:
        br = 0
        for i in f:
            if i.strip():
                br += 1
        return br
    
count_lines(path)

# 17:  Написати функцију read_column(path: str, column: str) -> list која враћа све вредности једне колоне CSV фајла
#Input: 'data/raw/teams.csv', 'city'
#Output: ['Bela Palanka', 'Niš', 'Beograd, Rakovica', 'Kraljevo']
#Ако колона не постоји, вратити празну листу []
import csv
path = 'data/raw/teams.csv'
column = 'city'
def read_column(path, column):
    with open(path, 'r') as f:
        reader = csv.DictReader(f)
        
        if column not in reader.fieldnames:
            return []
        
        rezultat = []
        for i in reader:
            rezultat.append(i[column])

        return rezultat
        

read_column(path, column)

# 18: Написати функцију write_key_value(path: str, data: dict, headers: list) -> None која речник уписује у CSV фајл са две колоне
# Input: 'data/processed/summary.csv', {'rows': 10, 'valid': 6}, ['metric', 'value']
# Садржај фајла након позива: 
# metric,value 
# rows,10
# valid,6
import csv
path = 'data/processed/summary.csv'
data = {'rows': 10, 'valid': 6}
headers = ['metric', 'value']
def write_key_value(path, data, headers):
    with open('data/processed/summary.csv', 'w') as f:
        writer = csv.writer(f)
        writer.writerow(headers)

        for key, value in data.items():
            writer.writerow([key, value])

write_key_value(path, data, headers)

# 19: Написати функцију get_header(path: str) -> list која враћа заглавље CSV фајла Користити csv.reader и next()
# Input: 'data/raw/teams.csv'
# Output: ['team', 'city', 'points']
path = 'data/raw/teams.csv'
def get_header(path):
    with open(path, 'r') as f:
        reader = csv.reader(f)
        return next(reader)
get_header(path)

# 20: Написати функцију read_rows(path: str) -> list која враћа све редове CSV фајла без заглавља, као листу листи Користити csv.reader
# Input: 'data/raw/teams.csv'
# Output: [['FK Jedinstvo', 'Bela Palanka', '34'], ['FK Radnički', 'Niš', '41'], ['FK Rakovica', 'Beograd, Rakovica', '28'], ['FK Sloga', 'Kraljevo', '19']]

path = 'data/raw/teams.csv'

def read_rows(path):
    with open(path, 'r') as f:
        reader = csv.reader(f)
        next(reader)
        nova_lista = []
        for i in reader:
            nova_lista.append(list(i))

        return nova_lista

read_rows(path)

# 21: Написати функцију total_points(path: str) -> int која враћа збир бодова свих тимова Користити csv.DictReader
# Input: 'data/raw/teams.csv'
# Output: 122

path = 'data/raw/teams.csv'
def total_points(path):
    with open(path, 'r') as f:
        reader = csv.DictReader(f)
        suma = 0

        for i in reader:
            suma += int(i['points'])

    return suma
total_points(path)

# 22: Написати функцију write_rows(path: str, rows: list) -> None која листу листи уписује у CSV фајл
# Input: 'data/processed/people.csv', [['name', 'age'], ['Ana', 20], ['Marko', 22]]
# Садржај фајла након позива:
#name,age
#Ana,20
#Marko,22
path = 'data/processed/people.csv'
rows = [['name', 'age'], ['Ana', 20], ['Marko', 22]]
def write_rows(path, rows):
    with open(path, 'w') as f:
        writer = csv.writer(f)
        writer.writerows(rows)

write_rows(path, rows)

# 23: Написати функцију write_rows(path: str, rows: list) -> None која листу речника уписује у CSV фајл
# Input: 'data/processed/people.csv',  [{'name': 'Ana', 'age': 20}, {'name': 'Marko', 'age': 22}]
# Садржај фајла након позива:
#name,age
#Ana,20
#Marko,22
path = 'data/processed/people.csv'
rows = [{'name': 'Ana', 'age': 20}, {'name': 'Marko', 'age': 22}]
def write_rows(path, rows):
    with open(path, 'w') as f:
        header = list(rows[0].keys())
        writer = csv.DictWriter(f, fieldnames = header)
        writer.writeheader()
        writer.writerows(rows)

write_rows(path, rows)