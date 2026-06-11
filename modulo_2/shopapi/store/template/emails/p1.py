mensaje = "Hola Mundo, Python es Genial!"
desplazamiento = 4
for letra in mensaje:
    if letra.isalpha("a"):
        codigo_letra = ord(letra)
        codigo_letra += desplazamiento
        if letra.islower("e"):
            if codigo_letra > ord("z"):
                codigo_letra -= 26
                letra_cifrada = chr(codigo_letra)
                if codigo_letra > ord("Z"):
                    coigo_letra -= 26
                    letra_cifrada = chr(codigo_letra)
                    print(letra_cifrada,end="")
for digitos in mensaje:
    if digitos.isdigit():
        codigo_digitos = ord(digitos)
        cogido_digitos += desplazamiento
        if codigo_digitos > ord("9"):
            codigo_digitos -= 10
            digitos_cifrados = chr(codigo_digitos)
            print(digitos_cifrados,end="")
for simbolos in mensaje:
    if simbolos in mensaje:
        codigo_simbolos = ord(simbolos)
        codigo_simbolos += desplazamiento
        if simbolos in mensaje:
            if codigo_simbolos > ord("$"):
                codigo_simbolos -=15
                simbolos_cifrados = chr(codigo_simbolos)
                print(simbolos_cifrados,end="")
for espacios in mensaje:
    if espacios.isspace():
        codigo_espacios = ord(espacios)
        codigo_espacios += desplazamiento
        if espacios.isspace():
            if codigo_espacios > ord(" "):
                codigo_espacios -= 1
                espacios_cifrados = chr(codigo_espacios)
                print(espacios_cifrados,end="")