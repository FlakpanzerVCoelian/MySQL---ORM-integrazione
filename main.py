##IMPORTS

from tkinter import * ##SEMBRA CHE IMPORT ALL NON IMPORTA TUTTO... UGHHH PYTHOOOON
import tkinter.font
from tkinter import messagebox
from tkinter import Entry
from tkinter import ttk
import os
import shutil
import codecs
from sqlalchemy import create_engine, String, select, func, DateTime, Date, text
import pymysql
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, sessionmaker
import datetime 
from sqlalchemy.sql import func 
from sqlalchemy.dialects.mysql import LONGTEXT, TINYINT, DOUBLE
import enum

USERNAME = 'leonardo' 
PASSWORD = 'flandia' #security first...
HOST = 'localhost'
PORT = '3306'
DATABASE = 'mydb'

connADB = f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}" #connessione
motore = create_engine(connADB, echo = True) #echo = True per debugging

class Base(DeclarativeBase): #classe base
    pass

class TipoENUM(enum.Enum): #classe per definite l'ENUM
    org = "org"
    pers = "pers"


class Persona(Base):
    __tablename__ = "Persona"
    id: Mapped[str] = mapped_column("ID persona",String(25), primary_key=True)
    nome: Mapped[str] = mapped_column(String(20))
    cognome: Mapped[str] = mapped_column(String(20))
    secondonome: Mapped[str] = mapped_column("Secondo nome",String(45))
    titolo: Mapped[str] = mapped_column(String(45))
    sesso: Mapped[str] = mapped_column(String(1))
    Stato: Mapped[str] = mapped_column("Stato di residenza",String(30))
    Comune: Mapped[str] = mapped_column(String(45))
    Via: Mapped[str] = mapped_column(String(45))
    cap: Mapped[int] = mapped_column("CAP")
    Ruolo: Mapped[str] = mapped_column("Tipo/Ruolo",String(45))
    Lavora: Mapped[str] = mapped_column("Lavora per",String(30))

class Organizzazione(Base):
    __tablename__ = "Organizzazione"
    id: Mapped[str] = mapped_column("ID Organizzazione",String(30), primary_key=True)
    nome: Mapped[str] = mapped_column(String(20))
    proprietario: Mapped[str] = mapped_column("ID Proprietario",String(30))
    Stato: Mapped[str] = mapped_column("Paese",String(30))
    Comune: Mapped[str] = mapped_column(String(45))
    Via: Mapped[str] = mapped_column("Sede (indirizzo)",String(45))
    cap: Mapped[int] = mapped_column("CAP")
    Ruolo: Mapped[str] = mapped_column("Tipo/Ruolo",String(45))
    Lavora: Mapped[str] = mapped_column("Lavora per",String(30))

class File(Base):
    __tablename__ = "File"
    id: Mapped[str] = mapped_column("File ID",String(20), primary_key=True)
    link: Mapped[str] = mapped_column("Link",String(100))
    data: Mapped[datetime.date] = mapped_column(Date)
    Batch: Mapped[int] = mapped_column("Batch",TINYINT)
    Redacted: Mapped[int] = mapped_column("Redacted %",TINYINT)
    descrizione: Mapped[str] = mapped_column(String(400))
    size: Mapped[int] = mapped_column("Dimensione (KB)")

class Immagine(Base):
    __tablename__ = "Immagine"
    id: Mapped[str] = mapped_column(String(25), primary_key=True)
    Redacted: Mapped[int] = mapped_column("Redacted%",TINYINT)
    descrizione: Mapped[str] = mapped_column(String(400))
    size: Mapped[int] = mapped_column("Dimensione KB")
    Luogo: Mapped[str] = mapped_column("Nome Luogo",String(30))
    Stato: Mapped[str] = mapped_column("Paese",String(30))
    Comune: Mapped[str] = mapped_column(String(45))
    Via: Mapped[str] = mapped_column(String(45))
    cap: Mapped[int] = mapped_column("CAP")
    data: Mapped[datetime.datetime] = mapped_column(DateTime)

class Mail(Base): #comunicazione
    __tablename__ = "Mail"
    id: Mapped[str] = mapped_column("Mail ID",String(25), primary_key=True)
    Redacted: Mapped[int] = mapped_column("Redacted%",TINYINT)
    fil: Mapped[str] = mapped_column("File ID",String(20))
    enum: Mapped[TipoENUM] = mapped_column("Org o Pers")
    data: Mapped[datetime.datetime] = mapped_column(DateTime)
    persona: Mapped[str] = mapped_column("ID Mittente Persona",String(25))
    organizzazione: Mapped[str] = mapped_column("ID Mittente Organizzazione",String(30))
    descrizione: Mapped[str] = mapped_column("Descrizione",String(400))
    risposta: Mapped[str] = mapped_column("Risposta",String(25))
    tipo: Mapped[str] = mapped_column("tipo",String(10))
    indirizzo: Mapped[str] = mapped_column("Indirizzo Mittente",String(45))
    telefono: Mapped[str] = mapped_column("Num telefono mittente",String(20))
    oggetto: Mapped[str] = mapped_column("Oggetto",String(45))

class Destinatari(Base):
    __tablename__ = "Destinatari"
    num: Mapped[int] = mapped_column("Num Destinatario",primary_key= True)
    id: Mapped[str] = mapped_column("Mail ID",String(25), primary_key= True)
    indirizzo: Mapped[str] = mapped_column("Indirizzo mail destinatario",String(45))
    telefono: Mapped[str] = mapped_column("Num telefono destinatario",String(20))
    enum: Mapped[TipoENUM] = mapped_column("Org o Pers", primary_key= True)
    persona: Mapped[str] = mapped_column("ID Persona",String(25))
    organizzazione: Mapped[str] = mapped_column("ID Organizzazione",String(30))
    tipo: Mapped[str] = mapped_column(String(10))

class Soggetto(Base):
    __tablename__ = "Soggetto"
    num: Mapped[int] = mapped_column("N. rif del file",primary_key= True)
    id: Mapped[str] = mapped_column("File ID",String(20), primary_key= True)
    enum: Mapped[TipoENUM] = mapped_column("Org o Pers", primary_key= True)
    persona: Mapped[str] = mapped_column("ID Persona",String(25))
    organizzazione: Mapped[str] = mapped_column("ID Organizzazione",String(30))

class PersINimg(Base):
    __tablename__ = "Persona in immagine"
    id: Mapped[str] = mapped_column("ID Immagine",String(25), primary_key= True)
    pers: Mapped[str] = mapped_column("ID Persona",String(25), primary_key= True)
    fil: Mapped[str] = mapped_column("ID File",String(20))

class Lavoro(Base):
    __tablename__ = "Lavoro"
    num: Mapped[int] = mapped_column("Num. Lavoro",primary_key= True)
    id: Mapped[str] = mapped_column("ID Lavoratore",primary_key= True)
    salario: Mapped[int] = mapped_column("Salario")
    enum: Mapped[TipoENUM] = mapped_column("OrgoPers", primary_key= True)
    persona: Mapped[str] = mapped_column("Lavoraperpersona",String(25))
    organizzazione: Mapped[str] = mapped_column("Lavoraperorg",String(30))
    tipo: Mapped[str] = mapped_column("Tipo",String(45))

    Base.metadata.create_all(bind=motore)

Connessione = sessionmaker(bind=motore)
db = Connessione()

##SETUP FINITO




storedPROCS = ["contasoldiSP", "contasalarioSP", "contarefimgs", "contareffiles", "ritornacom", "quanticomMITT", "`Che lavori fai`", "dipendenti", "`Dove sei scattato`", "ChiCOMMS"]
nargs = [1, 1, 1, 1, 2, 3, 1, 2, 1, 2]

def determinaIDX(x):
    for i in range(len(storedPROCS)):
        if x == storedPROCS[i]:
            return i


##inizializzazione Tkinter
a = Tk()
a.geometry("1400x900+50+50")
a.config(bg = "#ffffff")
a.title("Programmino")

combox = ttk.Combobox(a, values = storedPROCS)
combox.grid(row = 3, column = 2)

l1 = Label(a, text="Argomento 1")
l1.grid(row = 0, column = 0)
e1 = Entry(a, width = 50)
e1.grid(row = 0, column = 1)
l2 = Label(a, text="Argomento 2")
l2.grid(row = 1, column = 0)
e2 = Entry(a, width = 50)
e2.grid(row = 1, column = 1)
l3 = Label(a, text="Argomento 3")
l3.grid(row = 2, column = 0)
e3 = Entry(a, width = 50)
e3.grid(row = 2, column = 1)

def FAIquery():
    SPdaeseg = combox.get()
    arg1  = e1.get()
    arg2 = e2.get()
    arg3 = e3.get()
    idx = determinaIDX(SPdaeseg)
    figlio = Toplevel()
    figlio.geometry("1000x600+50+50")
    figlio.config(bg = "#ffffff")
    figlio.title("Risultato query")
    scroll = Scrollbar(figlio)
    scroll.pack(side = RIGHT, fill = Y)
    listbox = Listbox(figlio, yscrollcommand = scroll.set, width= 400)
    
    if nargs[idx] == 1:
        quer = "CALL " + storedPROCS[idx] + " (:arg1)"
        query = text(quer)
        tabquery = db.execute(query, {"arg1": arg1})
    elif nargs[idx] == 2:
        quer = "CALL " + storedPROCS[idx] + "(:arg1, :arg2)"
        query = text(quer)
        tabquery = db.execute(query, {"arg1": arg1, "arg2": arg2})
    elif nargs[idx] == 3:
        quer = "CALL " + storedPROCS[idx] + "(:arg1, :arg2, :arg3)"
        query = text(quer)
        tabquery = db.execute(query, {"arg1": arg1, "arg2": arg2, "arg3": arg3})
    for riga in tabquery:
        listbox.insert(END, riga)
    listbox.pack(expand= True)

bott = Button(a, text = "esegui query", command = FAIquery)
bott.grid(row = 4, column= 1)


#config finito per tkinter

a.mainloop()
