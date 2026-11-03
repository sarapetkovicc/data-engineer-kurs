# Domaci 7.2

# prvi

def promena(temperatura):
    temperatura = temperatura * 1.8 + 32
    return temperatura

print(promena(30))

#drugi

def dan(x):
     if x == 1:
         return "Ponedeljak"
     elif x == 2:
         return "Utorak"
     elif x == 3:
         return "Sreda"
     elif x == 4:
         return "Cetvrtak"
     elif x == 5:
         return "Petak"
     elif x == 6:
         return "Subota"
     elif x == 7:
         return "Nedelja"
     else:
         return "Pogresan unos"
     
dan(5)

# treci

lista = [2,-3,5,-1,4,-8]


def racunaj(x):
    br = 0
    for i in x:
        if i < 0 and i < br:
            br = i
    return(br)

racunaj(lista)

# peti

lista = [2,3,5,1,4,8]

def racunaj(x):
    s = 0
    for i in x:
        if i % 2 == 0:
            s += 1
    return(s)

racunaj(lista)

# sesti - dodatni

lista = [2,3,5,1,4,8]

def racunaj(x):
    s_parni = 0
    s_neparni = 0
    for i in x:
        if i % 2 == 0:
            s_parni += i
        if i % 2 == 1:
            s_neparni += i

    return(s_parni, s_neparni)

racunaj(lista)