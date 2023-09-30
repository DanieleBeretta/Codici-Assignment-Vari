
materie={1:"algebra", 2:"geometria", 3:"scienze", 4:"storia",
         5:"geografia", 6:"italiano"}
voti = {1: 5, 2: 9, 3: 6, 4: 7, 5: 8, 6: 9}

#inserisci una nuova materia e il suo corrispondente voto
n=6
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

#Modifca o materia o voto
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

#Osserva totale e media voti
def med():
     avg=0
     s=0
     for k in voti:
         s=s+voti[k]
         avg=s/len(voti)
     print(f"The total is {s} and the average is {avg}")
 
 

# change the name of materie that start with "s"
def lists():
     for k in materie:
         if materie[k][0]=="s":
             newmateria=input("Nuova materia")
             materie[k]=newmateria
     print(materie)
 
     
#Save
def Save():
     myfile=open("materie.txt", "w")
     print(materie, file=myfile)
     print(voti, file=myfile)
     myfile.close()
     print("Dati salvati")
 
