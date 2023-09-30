Python 3.10.7 (tags/v3.10.7:6cc6b13, Sep  5 2022, 14:08:36) [MSC v.1933 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
DD={"Date"   : {0 : "27-Jan-2023",
                1 : "30-Jan-2023"},
    "Low"    : {0 : 987.20,
                1 : 800.25},
    "High"   : {0 : 1040.35,
                1 : 940.25},
    "Close"  : {0 : 1025.46,
                1 : 920.30},
    "AdjP"   : {0 : 1010.35,
                1 : 935.45},
    "Volume" : {0 : 10000,
                1 : 25000}
    }
#Add new element
n=1
def ins():
    date=input("Inserisci nuova data (dd-Mon-yyyy): ")
    presente=False
    for key in DD["Date"]:
        if DD["Date"][key]==date:
            print("Gia presente")
            presente=True
            break
    if presente==False:
        global n
        lowprice=float(input("New low price: "))
        highprice=float(input("New high price: "))
        closeprice=float(input("New close price: "))
        adjprice=float(input("New adjusted price: "))
        vol=int(input("New Volume: "))
        n=n+1
        DD["Date"][n]=date
        DD["Low"][n]=lowprice
        DD["High"][n]=highprice
        DD["Close"][n]=closeprice
        DD["AdjP"][n]=adjprice
        DD["Volume"][n]=vol
    print(DD)

    
# Change value with n as key
def mod():
    modifica=int(input("Cosa modificare: "))
    if modifica==1:
        chiave=int(input("Quale giorno: "))
        if chiave in DD["Date"]:
            newdate=input("Nuova data: ")
            DD["Date"][chiave]=newdate
            print(DD)
        else:
            print("Wrong choice")
    elif modifica==2:
        chiave=int(input("Quale giorno: "))
        if chiave in DD["Low"]:
            newlowprice=float(input("Nuova LP: "))
            DD["Low"][chiave]=newlowprice
            print(DD)
        else:
            print("Wrong choice")
    elif modifica==3:
        chiave=int(input("Quale giorno: "))
        if chiave in DD["High"]:
            newhighprice=float(input("Nuova HP: "))
            DD["High"][chiave]=newhighprice
            print(DD)
        else:
            print("Wrong choice")
    elif modifica==4:
        chiave=int(input("Quale giorno: "))
        if chiave in DD["Close"]:
            newcloseprice=float(input("Nuova CP: "))
            DD["Close"][chiave]=newcloseprice
            print(DD)
        else:
            print("Wrong choice")
    elif modifica==5:
        chiave=int(input("Quale giorno: "))
        if chiave in DD["AdjP"]:
            newadjprice=int(input("Nuova AP: "))
            DD["AdjP"][chiave]=newadjprice
            print(DD)
        else:
            print("Wrong choice")
    elif modifica==6:
        chiave=int(input("Quale giorno: "))
        if chiave in DD["Volume"]:
            newvol=int(input("Nuovo volume: "))
            DD["Volume"][chiave]=newvol
            print(DD)
        else:
            print("Wrong choice")
    else:
        print("Wrong choice")

        
#For highest price show value and date
        
def hp():
    maxy=0
    chiave=0
    for key in DD:
        for k in DD[key]:
            if DD["High"][k]>maxy:
                maxy=DD["High"][k]
                chiave=k
    print(DD["Date"][chiave], DD["Volume"][chiave])
... 
...         
>>> #Calcola media of AdjP for a month
...         
>>> def AvgAdjP():
...     mese=input("Quale mese (Mon-yyyy): ")
...     avg=0
...     s=0
...     count=0
...     for key in DD:
...         for k in DD[key]:
...             if DD["Date"][k][3:]==mese:
...                 count=count+1
...                 s=s+DD["AdjP"][k]
...                 avg=s/count
...     print(f" the average for {mese} is {avg}")
... 
...     
>>> #Show AdjP for a typed date
...     
>>> def show():
...     date=input("Data: ")
...     for key in DD:
...         for k in DD[key]:
...             if DD["Date"][k]==date:
...                 print(DD["AdjP"][k])
... 
...                 

while True:
    print("""
1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date
""")
    choice=int(input("==> "))
    if choice==1:
        ins()
    elif choice==2:
        mod()
    elif choice==3:
        hp()
    elif choice==4:
        AvgAdjP()
    elif choice==5:
        show()
    elif choice==-1:
        break
    else:
        print("Wrong choice")

        

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 1
Inserisci nuova data (dd-Mon-yyyy): 27-Jan-2023
Gia presente
{'Date': {0: '27-Jan-2023', 1: '30-Jan-2023'}, 'Low': {0: 987.2, 1: 800.25}, 'High': {0: 1040.35, 1: 940.25}, 'Close': {0: 1025.46, 1: 920.3}, 'AdjP': {0: 1010.35, 1: 935.45}, 'Volume': {0: 10000, 1: 25000}}

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 1
Inserisci nuova data (dd-Mon-yyyy): 28-Jan-2023
New low price: 850.45
New high price: 1050.65
New close price: 975.43
New adjusted price: 1030.4
New Volume: 17000
{'Date': {0: '27-Jan-2023', 1: '30-Jan-2023', 2: '28-Jan-2023'}, 'Low': {0: 987.2, 1: 800.25, 2: 850.45}, 'High': {0: 1040.35, 1: 940.25, 2: 1050.65}, 'Close': {0: 1025.46, 1: 920.3, 2: 975.43}, 'AdjP': {0: 1010.35, 1: 935.45, 2: 1030.4}, 'Volume': {0: 10000, 1: 25000, 2: 17000}}

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 2
Cosa modificare: 1
Quale giorno: 2
Nuova data: 29-Jan-2023
{'Date': {0: '27-Jan-2023', 1: '30-Jan-2023', 2: '29-Jan-2023'}, 'Low': {0: 987.2, 1: 800.25, 2: 850.45}, 'High': {0: 1040.35, 1: 940.25, 2: 1050.65}, 'Close': {0: 1025.46, 1: 920.3, 2: 975.43}, 'AdjP': {0: 1010.35, 1: 935.45, 2: 1030.4}, 'Volume': {0: 10000, 1: 25000, 2: 17000}}

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 2
Cosa modificare: 6
Quale giorno: 1
Nuovo volume: 21000
{'Date': {0: '27-Jan-2023', 1: '30-Jan-2023', 2: '29-Jan-2023'}, 'Low': {0: 987.2, 1: 800.25, 2: 850.45}, 'High': {0: 1040.35, 1: 940.25, 2: 1050.65}, 'Close': {0: 1025.46, 1: 920.3, 2: 975.43}, 'AdjP': {0: 1010.35, 1: 935.45, 2: 1030.4}, 'Volume': {0: 10000, 1: 21000, 2: 17000}}

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 2
Cosa modificare: 7
Wrong choice

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 3
29-Jan-2023 17000

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 4
Quale mese (Mon-yyyy): Jan-2023
 the average for Jan-2023 is 992.066666666667

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 5
Data: 28-Jan-2023

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> 5
Data: 29-Jan-2023
1030.4
1030.4
1030.4
1030.4
1030.4
1030.4

1) Add new day
2) Change value
3) Highest price and its date
4) Average adjusted price for a month
5) Adjusted price for a date

==> -1
