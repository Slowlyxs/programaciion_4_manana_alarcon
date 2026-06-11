mensaje = "Hola Mundo, Python es Genial!"
desplazamiento = 4

for digitos in mensaje:
    if digitos.isdigit():
        codigo_digitos = ord(digitos)
        cogido_digitos += desplazamiento
        if codigo_digitos > ord("9"):
            codigo_digitos -= 10
            digitos_cifrados = chr(codigo_digitos)
            print(digitos_cifrados,end="")