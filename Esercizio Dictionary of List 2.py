Python 3.10.7 (tags/v3.10.7:6cc6b13, Sep  5 2022, 14:08:36) [MSC v.1933 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
#Esercizio Dictionary of lists

cani = { 'San Bernardo': [7, 40.6, 0.75],
 'Labrador': [5, 25.3, 0.55],
 'Bavaro': [8, 43.2, 0.75]
 }
#Add new element con check
newcane=None
def Insert():
    cane=str(input("Cane: "))
    if cane in cani.keys():
        print("Cane gia presente")
    else:
        L=[]
        eta=int(input("Inserisci età: "))
        peso=float(input("Inserisci peso: "))
        altezza=float(input("Inserisci altezza: "))
        L.append(eta)
        L.append(peso)
        L.append(altezza)
        newcane=cane
        cani[newcane]=L
    print(cani)
#Inserisci il nome del proprietario
def Ins():
    for cane in cani:
        nome_proprietario = input(f"Inserisci il nome del proprietario di {cane}: ")
        cani[cane].append(nome_proprietario)
    print(cani)

##modifica i numeri 0.75 in 0.80
def edit():
    for cane in cani:
        for lista in range(len(cani[cane])):
             if cani[cane][lista]==0.75:
                 cani[cane][lista]=0.8
     print(cani)
 
     
#somma di ogni peso di cane
 def total():
     s=0
     for cane in cani:
         s=s+cani[cane][1]
     print(f"The total of the peso is {s}")
 

# Elimina specifico cane
def delete():
     cane=input("Cane da eliminare: ")
     if cane in cani:
         del(cani[cane])
     print(cani)
   
#Elimina il cane col peso massimo
def delpeso():
     peso_massimo = 0
     cane_da_rimuovere = None
     for nome in cani:
         if cani[nome][1] > peso_massimo:
             cane_da_rimuovere = nome
             peso_massimo = cani[nome][1]
     if cane_da_rimuovere is not None:
      del cani[cane_da_rimuovere]
     print(cani)
 
     

