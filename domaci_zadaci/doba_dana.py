# Domaci 7.1

sat = 12
if sat in range(24):
    if sat >= 22 or sat < 6:
        doba = "noc"
    elif sat >= 6 and sat < 12:
        doba = "jutro"
    elif sat >= 12 and sat < 18:
        doba = "popodne"
    else:
        doba = "vece"

    print("Sati je: ", sat, "a doba dana: ", doba)