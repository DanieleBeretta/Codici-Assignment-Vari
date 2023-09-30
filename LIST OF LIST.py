
LL=[ ['24031', 'Almenno', 5500, 330],
 ['24020', 'Casnigo', 3230, 515],
 ['24030', 'Capizzone', 1190, 655]
 ]
#Inserisci nuovo pases con check
def ins():
    paese=input("Inserisci nome paese: ")
    presente=False
    for lista in range(len(LL)):
        if LL[lista][1]==paese:
            print("Già presente")
            presente=True
            break
    if presente==False:
        L=[]
        cap=input("CAP: ")
        abitanti=int(input("abitanti: "))
        altitudine=int(input("altitudine: "))
        L.append(cap)
        L.append(paese)
        L.append(abitanti)
        L.append(altitudine)
        LL.append(L)
    print(LL)

    
#Inserisci numero supermercato in ogni paese
    
def add():
    for lista in range(len(LL)):
        sup=int(input("Numero supermercato: "))
        LL[lista].append(sup)
    print(LL)

    
#Modifca nome paese il cui cap finisce per 1
    
def mod():
    newnome=input("Nome nuovo: ")
    for lista in range(len(LL)):
        if LL[lista][0][-1]=="1":
            LL[lista][1]=newnome
    print(LL)

    
#Calcola totale e media abitanti per paese
    
def avg():
    s=0
    avg=0
    for lista in range(len(LL)):
        s=s+LL[lista][2]
        avg=s/len(LL)
    print(f"Total is {s} and the average is {avg}")

    
#Elimina il paese con maggiore num supermercati
    
def delete():
    supmagg=0
    lista=None
    for l in range(len(LL)):
        if LL[l][4]>supmagg:
            supmagg=LL[l][4]
            lista=l
    LL.pop(lista)
    print(LL)

    
#Salva
    
def save():
    myfile=open("paesi.txt","w")
    for lista in range(len(LL)):
        print(LL[lista], file=myfile)
    myfile.close()
    print("Dati salvati")

    
while True:
    print("""
1) Insert
2) Add num supermercato
3) Modify
4) Average
5) Delete
6) Save
""")
    choice=int(input("==> "))
    if choice==1:
        ins()
    elif choice==2:
        add()
    elif choice==3:
        mod()
    elif choice==4:
        avg()
    elif choice==5:
        delete()
    elif choice==6:
        save()
    elif choice==-1:
        break
    else:
        print("wrong choice")

        

