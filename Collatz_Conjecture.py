import fileinput
import numpy
import csv

cadenas = []
baseDatos = [1]

def CalcNextTwo(n):
    nextOne = int(n * 2)
    nextTwo = n - 1
    if (nextTwo % 3 == 0):
        nextTwo = int(nextTwo / 3)
    else:
        nextTwo = 0
    global cadenas
    cadenas.append({'n':n, '2n':nextOne, '3(n-1)':nextTwo})
    global baseDatos
    appendOne = True
    for i in range(len(baseDatos)):
        if baseDatos[i] == nextOne:
            appendOne = False
    if appendOne:
        baseDatos.append(nextOne)
    appendTwo = True
    for i in range(len(baseDatos)):
        if baseDatos[i] == nextTwo:
            appendTwo = False
    if appendTwo:
        baseDatos.append(nextTwo)

def Output():
    with open('data/cadenas.csv', 'w', newline='') as f:
        keys = ['n', '2n', '3(n-1)']
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        writer.writerows(cadenas)
    numpy.savetxt("data/baseDatos.csv", baseDatos, delimiter=",", fmt='%d')

for i in range(0, 500):
    if baseDatos[i]:
        CalcNextTwo(baseDatos[i])
    Output()
