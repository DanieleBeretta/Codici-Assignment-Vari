Python 3.10.7 (tags/v3.10.7:6cc6b13, Sep  5 2022, 14:08:36) [MSC v.1933 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
#Esercizio LIST of DICTIONNARIES
cani = [ {'razza': 'San Bernardo', 'peso': 80, 'altezza': 0.75},
 {'razza': 'Bovaro del Bernese', 'peso': 75, 'altezza': 0.60},
 {'razza': 'Labrador', 'peso': 50, 'altezza': 0.45}
 ]

#Inserisci nuovo cane con check
def Insert():
    diz=None
    cane=input("Razza del cane: ")
    presente=False
    for pos in range(len(cani)):
        if cani[pos]["razza"]==cane:
            print("Cane già presente")
            presente=True
            break
    if presente==False:
        P=int(input("Peso cane: "))
        h=float(input("Altezza cane: "))
        cani.append({"razza": cane,
                     "peso": P,
                     "altezza": h})
    print(cani)

#Inserisci nuova chiave
    
def Ins():
    chiave=input("Nuova chiave: ")
    for pos in range(len(cani)):
        value=input("Sesso: ")
        x[pos][chiave]=value
    print(cani)

    
def Ins():
    chiave=input("Nuova chiave: ")
    for pos in range(len(cani)):
        value=input("Sesso: ")
        cani[pos][chiave]=value
    print(cani)

    
#visualizza ed elimina cane con peso minore
    
def delete():
    minore=1000
    pos=0
    for p in range(len(cani)):
        if cani[p]["peso"]<minore:
            minore=cani[p]["peso"]
            pos=p
            print(minore,pos)
            del(cani[p])
    print(cani)

    
#Dlete cane con peso maggiore
    
def delete():
    maggiore=0
    pos=0
    for p in range(len(cani)):
        if cani[p]["peso"]>maggiore:
            maggiore=cani[p]["peso"]
            pos=cani[p]
            print(maggiore,pos)
            del(cani[p])
    print(cani)

#Visualizza e modifica cane con peso maggiore
    
def modi():
    cane=None
    pesomagg=0
    newname=input("Nuovo nome: ")
...     for pos in range(len(cani)):
...         if cani[pos]["peso"]>pesomagg:
...             pesomagg=cani[pos]["peso"]
...             cane=cani[pos]["razza"]
...             print(cane,pesomagg)
...             cani[pos]["razza"]=newname
...     print(cani)
... 
...     
>>> #Calcola totale peso
...     
>>> def Tot():
...     s=0
...     avg=0
...     for pos in range(len(cani)):
...         s=s+cani[pos]["peso"]
...         avg=s/len(cani)
...     print(f"The sum is {s} and the average is {avg}")
... 
...     
>>> #Modifica peso di ogni cane
...     
>>> def ed():
...     for pos in range(len(cani)):
...         newpeso=int(input("Nuovo peso: "))
...         cani[pos]["peso"]=newpeso
...     print(cani)
... 
...     
>>> #Salva dati
...     
>>> def salva():
...     myfile=open("Cani.txt","w")
...     for d in cani:
...         for m in d:
...             print(m, d[m], file=myfile)
...     myfile.close()
...     print("dati salvati")
... 
