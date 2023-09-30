Python 3.10.7 (tags/v3.10.7:6cc6b13, Sep  5 2022, 14:08:36) [MSC v.1933 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
materie = {1: 'algebra', 2:'geometria', 3: 'scienze', 4: 'storia', 5:
           'geografia', 6:'italiano' }
voti = {1: 5, 2: 9, 3: 6, 4: 7, 5: 8, 6: 9}
SyntaxError: multiple statements found while compiling a single statement

materie={1:"algebra", 2:"geometria", 3:"scienze", 4:"storia",
         5:"geografia", 6:"italiano"}
voti = {1: 5, 2: 9, 3: 6, 4: 7, 5: 8, 6: 9}

#inserisci una nuova materia e il suo corrispondente voto
n=6
def Insert():
    materia=input("Quale materia? ")
    presente=False
    for k in materie:
        if k==materia:
            print("Already recorded")
            presente=True
            break
    if presente==False:
        global n
        voto=float(input("Voto: "))
        n=n+1
        materie[n]=materia
        voti[n]=voto
    print(materie, voti)

    
Insert()
Quale materia? algebra
Voto: *
Traceback (most recent call last):
  File "<pyshell#21>", line 1, in <module>
    Insert()
  File "<pyshell#20>", line 11, in Insert
    voto=float(input("Voto: "))
ValueError: could not convert string to float: '*'
def Insert():
    materia=input("Quale materia? ")
    presente=False
    for k in materie:
        if materie[k]==materia:
            print("Already recorded")
            presente=True
            break
    if presente==False:
        global n
        voto=float(input("Voto: "))
        n=n+1
        materie[n]=materia
        voti[n]=voto
    print(materie, voti)

Insert()
Quale materia? algebra
Already recorded
{1: 'algebra', 2: 'geometria', 3: 'scienze', 4: 'storia', 5: 'geografia', 6: 'italiano'} {1: 5, 2: 9, 3: 6, 4: 7, 5: 8, 6: 9}
Insert()
Quale materia? russo
Voto: 7
{1: 'algebra', 2: 'geometria', 3: 'scienze', 4: 'storia', 5: 'geografia', 6: 'italiano', 7: 'russo'} {1: 5, 2: 9, 3: 6, 4: 7, 5: 8, 6: 9, 7: 7.0}
#Modifca o materia o voto
def mod():
    diz=int(input("Quale dizionario vuoi modificare? "))
    if diz==1:
        materia=input("materia: ")
        newmateria=input("Nuova materia: ")
        for k in materie:
            if materie[k]=materia:
                
SyntaxError: cannot assign to subscript here. Maybe you meant '==' instead of '='?
def mod():
    diz=int(input("Quale dizionario vuoi modificare? "))
    if diz==1:
        materia=input("materia: ")
        newmateria=input("Nuova materia: ")
        for k in materie:
            if materie[k]==materia:
                materie[k]=newmateria
        print(materie)
    elif diz==2:
        oldscore=int(input("chiave voto: "))
        newvoto=int(input("new voto: "))
        for v in voti:
            if v==oldscore:
                voti[v]=newvoto
        print(voti)
    else:
        print("Wrong choice")

        
mod()
Quale dizionario vuoi modificare? 3
Wrong choice
mod()
Quale dizionario vuoi modificare? 1
materia: russo
Nuova materia: francese
{1: 'algebra', 2: 'geometria', 3: 'scienze', 4: 'storia', 5: 'geografia', 6: 'italiano', 7: 'francese'}
mod()
Quale dizionario vuoi modificare? 2
chiave voto: 3
new voto: 10
{1: 5, 2: 9, 3: 10, 4: 7, 5: 8, 6: 9, 7: 7.0}
#Elimina materia e voto più basso
def delmin():
    minimum=float("inf")
    pos=0
    for k in voti:
        if voti[k]<minimum:
            minimum=voti[k]
            pos=k
    del(voti[pos])
    del(materie[pos])
    print(materie,voti)

    
delmin()
{2: 'geometria', 3: 'scienze', 4: 'storia', 5: 'geografia', 6: 'italiano', 7: 'francese'} {2: 9, 3: 10, 4: 7, 5: 8, 6: 9, 7: 7.0}
#Osserva totale e media voti
def med():
    avg=0
    s=0
    for k in voti:
        s=s+s[k]
        avg=s/len(voti)
    print(f"The total is {s} and the average is {avg}")

    
med()
Traceback (most recent call last):
  File "<pyshell#72>", line 1, in <module>
    med()
  File "<pyshell#71>", line 5, in med
    s=s+s[k]
TypeError: 'int' object is not subscriptable
>>> def med():
...     avg=0
...     s=0
...     for k in voti:
...         s=s+voti[k]
...         avg=s/len(voti)
...     print(f"The total is {s} and the average is {avg}")
... 
... 
>>> med()
The total is 50.0 and the average is 8.333333333333334
>>> # change the name of materie that start with "s"
>>> def lists():
...     for k in materie:
...         if materie[k][0]=="s":
...             newmateria=input("Nuova materia")
...             materie[k]=newmateria
...     print(materie)
... 
...     
>>> lists()
Nuova materiaAstrologia
Nuova materiaEconomia
{2: 'geometria', 3: 'Astrologia', 4: 'Economia', 5: 'geografia', 6: 'italiano', 7: 'francese'}
>>> #Save
>>> def Save():
...     myfile=open("materie.txt", "w")
...     print(materie, file=myfile)
...     print(voti, file=myfile)
...     myfile.close()
...     print("Dati salvati")
... 
...     
>>> Save()
Dati salvati
