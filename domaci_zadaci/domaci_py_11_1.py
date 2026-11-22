# Domaci 11.1

# Prvi zadatak: Informacije o svemirskoj stanici Napisati funkciju get_space_station() -> dict koja preko Open Notify API-ja (http://api.open-notify.org/iss-now.json) preuzima trenutnu poziciju Međunarodne svemirske stanice (ISS) i vraća rečnik koji sadrži: geografsku širinu (latitude), geografsku dužinu (longitude)

import requests

def get_space_station():
    url = 'http://api.open-notify.org/iss-now.json'

    response = requests.get(url)
    response.raise_for_status()
    data = response.json()

    return {
        'latitude' : float(data['iss_position']['latitude']),
        'longitude' : float(data['iss_position']['longitude'])
    }

get_space_station()

# Drugi zadatak: Pretraga univerziteta Napisati funkciju get_universities(country: str) -> list koja preko Hipolabs API-ja (http://universities.hipolabs.com/search) preuzima univerzitete iz zadate države i vraća listu njihovih naziva. Koristiti params={'country': country} za prosleđivanje naziva države API-ju.

def get_universities(country: str) -> list:
    url = 'http://universities.hipolabs.com/search'
    params={'country': country}

    response = requests.get(url, params=params)
    response.raise_for_status()
    data = response.json()

    univerziteti = []

    for u in data:
        univerziteti.append(u['name'])

    return univerziteti

get_universities('Serbia')

# Treci zadatak: Informacije o kursu valuta Napisati funkciju get_exchange_rate(base: str, target: str) -> float koja preko Frankfurter API-ja (https://api.frankfurter.dev/v1/latest) preuzima kurs između dve valute. Funkcija treba da vrati koliko jedinica ciljne valute (target) se dobija za jednu jedinicu početne valute (base).
# Input: get_exchange_rate("EUR","RSD")
# Output: 117.2

def get_exchange_rate(base: str, target: str) -> float:
    url = f'https://api.frankfurter.dev/v2/rate/{base}/{target}'

    response = requests.get(url)
    response.raise_for_status()
    data = response.json()

    return data['rate']

get_exchange_rate('EUR', 'RSD')