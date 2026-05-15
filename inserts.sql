create user leonardo@localhost identified by "flandia";
GRANT ALL PRIVILEGES ON mydb.* TO 'leonardo'@'localhost' WITH GRANT OPTION;

INSERT INTO `File` VALUES ('EFTA00015037',' https://www.justice.gov/epstein/files/DataSet%208/EFTA00015037.pdf','2025-01-01',8,91,'Persone arrestate da NYPD',3),('EFTA00077895',' https://www.justice.gov/epstein/files/DataSet%208/EFTA00077895.pdf','2025-01-01',9,89,'Persone arrestate da NYPD',5);
insert into `File` values("EFTA00163914", "https://www.justice.gov/epstein/files/DataSet%209/EFTA00163914.pdf", "2025-01-01", "8", "95", "Beef tra UK e USA", 10);
insert into `File` values("EFTA00163940","https://www.justice.gov/epstein/files/DataSet%209/EFTA00163940.pdf", "2025-01-01", "8", "95", "ZIONIST NYPD", 15);
insert into `File` values("EFTA01626049","https://www.justice.gov/epstein/files/DataSet%2010/EFTA01626049.pdf", "2025-01-01", "8", "50", "Liste di chiamate", 15);

INSERT INTO `Persona` VALUES ('CSFSVSVFSV','Alonzo','Quinn',NULL,NULL,'M','Stati Uniti',NULL,NULL,NULL,'Poliziotto corrotto',NULL, NULL, NULL),('PSCOP','Patrick','Simmons',NULL,NULL,'M','Stati Uniti',NULL,NULL,NULL,'Poliziotto corrotto',NULL, NULL);
insert into Persona values ("JLCOP", "John", "Laskey", NULL, NULL, "M", "Stati Uniti", NULL, NULL, NULL, 'Poliziotto corrotto', NULL);
insert into Persona values ("unknown", "John", "Reese", NULL, NULL, "M", "Stati Uniti", NULL, NULL, NULL, "Agente", NULL);
insert into Persona values ("secret", "Harold", "Finch", NULL, NULL, "M", "Stati Uniti", NULL, NULL, NULL, "Ingegnere AI", NULL);
insert into Persona values ("redacted", "Eve", "May", "root", NULL, "F", "Stati Uniti", NULL, NULL, NULL, "Admin", NULL);
insert into Persona values ("LFCOP", "Lionel", "Fusco", NULL, NULL, "M", "Stati Uniti", NULL, NULL, NULL, "Agente triplo", NULL);
insert into Persona values ("JCCOP", "Jocelyn", "Carter", NULL, NULL, "F", "Stati Uniti", NULL, NULL, NULL, "Detective", NULL);
insert into Persona values ("PACCCP", "Pyotr", "Andrejev", NULL, NULL, "M", "URSS", NULL, NULL, NULL, "Boss Mafioso", NULL);
insert into Persona values ("IVCCCP", "Igor", "Viter", NULL, NULL, "M", "URSS", NULL, NULL, NULL, "Lavasoldi", NULL);
insert into Persona values ("ABCCCP", "Andrej", "Bashmachkin", "Pyotrovich", NULL, "M", "URSS", NULL, NULL, NULL, "Lavasoldi", NULL);
insert into Persona values ("BCHLS", "Tyrone", "Smith", "Bottlecap", NULL, "M", "Stati Uniti", NULL, NULL, NULL, "Senzatetto", NULL);
insert into Persona values ("GVNCCC62E14Z404O", "Giovanni", "Caracciolo", NULL, "Don", "M", "Italia", NULL, NULL, NULL, "Don della Mafia", NULL);
insert into Persona values ("PTRCCC84P05Z404R", "Pietro", "Caracciolo", "Giovanni", "Don", "M", "Italia", NULL, NULL, NULL, "Don della Mafia", NULL);
insert into Persona values ("LBRSRN63B16A251S", "Alberto", "Sorrentino", NULL, "Don", "M", "Italia", NULL, NULL, NULL, "Don della Mafia", NULL);
insert into Persona values ("CNTRL", "Alicia", "Jones", "Control", NULL, "F", "Stati Uniti", NULL, NULL, NULL, "Coordinatrice di NL", NULL);
insert into Persona values ("classified", "Sameen", "Shaw", NULL, NULL, "F", "Stati Uniti", NULL, NULL, NULL, "Agente", NULL);
insert into Persona values ("ELIAS", "Carl", "Elias", "Giovanni", NULL, "M", "Stati Uniti", NULL, NULL, NULL, "Boss", NULL);




INSERT INTO `Organizzazione` VALUES ('CRORGUSANY001','NYPD-HR','CSFSVSVFSV','Stati Uniti',NULL,NULL,NULL,'Polizia corrotta',NULL),('DOJPDNY01','NYPD',NULL,'Stati Uniti',NULL,NULL,NULL,'Polizia',NULL);
insert into `Organizzazione` VALUES ("MACH01", "Machine", "secret", "Stati Uniti", NULL, NULL, NULL, "Agenti indipendenti", NULL);
insert into `Organizzazione` VALUES ("CRORGUSANY002", "Mafia russa", "PACCCP", "Stati Uniti", NULL, NULL, NULL, "Mafia", NULL);
insert into `Organizzazione` VALUES ("BAK01", "Panetteria di Igor", "IVCCCP", "Stati Uniti", NULL, NULL, NULL, "Fronte della mafia", NULL);
insert into `Organizzazione` VALUES ("CRORGUSANY003", "Mafia italiana", NULL, "Stati Uniti", NULL, NULL, NULL, "Mafia", NULL);
insert into `Organizzazione` VALUES ("MACH02", "Northern Lights", NULL, "Stati Uniti", NULL, NULL, NULL, "Agenti del governo", NULL);
insert into `Organizzazione` VALUES ("CRORGUSANY005", "Mafia di ELIAS", "ELIAS", "Stati Uniti", NULL, NULL, NULL, "Mafia", NULL);



INSERT INTO `Lavoro` VALUES (1,'CSFSVSVFSV',500000,'Boss',NULL,'CRORGUSANY001','org');

insert into `lavoro` values (2,'PSCOP',100000,'Secondo del boss','CSFSVSVFSV',NULL,'pers');

INSERT INTO `Soggetto` VALUES (1,'EFTA00077895','CRORGUSANY001',NULL,'org');

insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("PSCOP", 40000, "Poliziotto", "DOJPDNY01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("PSCOP", 300000, "Mano destra del boss", 'CRORGUSANY001',"org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("CSFSVSVFSV", 110000, "Capo della polizia", "DOJPDNY01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JLCOP", 511000, "Scagnozzo", 'CRORGUSANY001',"org"); --non entra causa trigger
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JLCOP", 40000, "Scagnozzo", 'CRORGUSANY001',"org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("LFCOP", 70000, "Poliziotto corrotto", "CRORGUSANY001","org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("LFCOP", 0, "Insider nella polizia", "MACH01","org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JCCOP", 0, "Insider nella polizia", "MACH01","org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JLCOP", 30000, "Poliziotto", "DOJPDNY01","org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JCCOP", 65000, "Detective", "DOJPDNY01","org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("LFCOP", 65000, "Detective", "DOJPDNY01","org");

insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperpersona, OrgOpers) values ("BCHLS", 5000, "Informatore", "JCCOP","pers");

insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("IVCCCP", 40000, "Proprietario", "BAK01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("IVCCCP", 100000, "Ricicla denaro", "CRORGUSANY002", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("PACCCP", 8000000, "Boss", "CRORGUSANY002", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("ABCCCP", 900000, "Secondo del boss", "CRORGUSANY002", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("GVNCCC62E14Z404O", 900000, "Triumvirato della mafia", "CRORGUSANY003", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("PTRCCC84P05Z404R", 900000, "Triumvirato della mafia", "CRORGUSANY003", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("LBRSRN63B16A251S", 900000, "Triumvirato della mafia", "CRORGUSANY003", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("CNTRL", 1000000, "Coordinatrice", "MACH02", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("classified", 100000, "Agente", "MACH02", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("secret", 300000, "Coordinatore", "MACH01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("unknown", 200000, "Agente", "MACH01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("ELIAS", 2000000, "Il BOSS", "CRORGUSANY005", "org");



select * from persona;
select * from organizzazione;




insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00015037", 23, "Mugshot di Patrick Simmons", 0, "NYPD Police station 5", "2024-01-01");
insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00015037-1", 21, "Mugshot di Alonzo Quinn", 0, "NYPD Police station 5", "2024-01-01");
insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00163940-1", 21, "Il gruppo di MACH01 in bar", 0, "Bar", "2024-01-01");
insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00163940-2", 25, "Incontro di un gruppo di poliziotti corrotti", 0, "Porto", "2024-02-01");
insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00163914-1", 43, "Immagine photoshoppata dei don morti", 56, "Club metropolitan", "2024-02-02");


insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("CSFSVSVFSV", "IMGEFTA00015037-1", "EFTA00015037");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("PSCOP", "IMGEFTA00015037", "EFTA00015037");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("secret", "IMGEFTA00163940-1", "EFTA00163940");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("unknown", "IMGEFTA00163940-1", "EFTA00163940");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("CSFSVSVFSV", "IMGEFTA00163940-2", "EFTA00163940");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("PSCOP", "IMGEFTA00163940-2", "EFTA00163940");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("JLCOP", "IMGEFTA00163940-2", "EFTA00163940");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("LFCOP", "IMGEFTA00163940-2", "EFTA00163940");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("GVNCCC62E14Z404O", "IMGEFTA00163914-1", "EFTA00163914");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("PTRCCC84P05Z404R", "IMGEFTA00163914-1", "EFTA00163914");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("LBRSRN63B16A251S", "IMGEFTA00163914-1", "EFTA00163914");



insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("PSCOP", "EFTA00015037", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("CSFSVSVFSV", "EFTA00015037", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("secret", "EFTA01626049", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("unknown", "EFTA01626049", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("CNTRL", "EFTA01626049", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("classified", "EFTA01626049", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("GVNCCC62E14Z404O", "EFTA00163914", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("PTRCCC84P05Z404R", "EFTA00163914", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("LBRSRN63B16A251S", "EFTA00163914", "pers");



insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperpersona, orgopers) values ('CRORGUSANY001', 100000, "Crimini", 'CSFSVSVFSV', "pers"); --non si inserisce causa trigger
delete from Lavoro where `ID Lavoratore` = 'CRORGUSANY001' and lavoraperpersona = 'CSFSVSVFSV';

insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `Indirizzo mittente`, tipo) values 
('CMEFTA00015037', 'EFTA00015037', "PSCOP", "pers", 10, "2024-01-01", "Problemino col tizio", 
"Il secondo del boss descrive un incontro con il misterioso tizio col vestito nero (andato stramale)", "Patrick.Simmons@hotmail.com", "Mail");
insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `Indirizzo mittente`, tipo, `Risposta`) values 
('CMEFTA00015037-1', 'EFTA00015037', 'CSFSVSVFSV', "pers", 10, "2024-01-01", "Siete stupidi", 
"Il boss del HR riprovera il suo secondo per la sua incompetenza", "Alonzo.Quinn@hotmail.com", "Mail", 'CMEFTA00015037');

insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `Indirizzo mittente`, tipo, `Risposta`) values 
('CMEFTA00163914-1', 'EFTA00163914', 'ELIAS', "pers", 10, "2024-01-01", "STATE PER SCADERE", 
"Elias scrive ai boss italiani che stanno per morire", "not@elias.com", "Mail", NULL);

insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `num telefono mittente`, tipo) values 
('CMEFTA00015037-2', 'EFTA00015037', "PSCOP", "pers", 10, "2024-01-01", "Problema risolto", 
"Il secondo del boss informa il capo che hanno completato un contratto", "041515215", "telefonata");

insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `num telefono mittente`, tipo) values 
('CMEFTA01626049-1', 'EFTA01626049', "secret", "pers", 10, "2024-01-01", "Varie comunicazioni", 
"Varie comunicazioni tra Finch e Reese", "<burner>", "telefonata");

insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `num telefono mittente`, tipo) values 
('CMEFTA01626049-2', 'EFTA01626049', "CNTRL", "pers", 10, "2024-01-01", "Varie comunicazioni", 
"Varie comunicazioni tra i dipendenti di Northern Lights", "<burner>", "telefonata");

insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00015037', "Alonzo.Quinn@hotmail.com", "pers", 'CSFSVSVFSV', "mail");
insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00015037-1', "Patrick.Simmons@hotmail.com", "pers", 'PSCOP', "telefonata");
insert into destinatari(`Mail ID`, `Num telefono destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00015037-2', "0941515125", "pers", 'CSFSVSVFSV', "telefonata");
insert into destinatari(`Mail ID`, `Num telefono destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA01626049-1', "<burner>", "pers", 'unknown', "telefonata");
insert into destinatari(`Mail ID`, `Num telefono destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA01626049-2', "<burner>", "pers", 'classified', "telefonata");
insert into destinatari(`Mail ID`, `Num telefono destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA01626049-1', "051531776", "pers", 'LFCOP', "telefonata");
insert into destinatari(`Mail ID`, `Num telefono destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA01626049-1', "091516616", "pers", 'JCCOP', "telefonata");
insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00163914-1', "giovanni@don.com", "pers", 'GVNCCC62E14Z404O', "mail");
insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00163914-1', "pietrogiovanni@don.com", "pers", 'PTRCCC84P05Z404R', "mail");
insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00163914-1', "alberto@don.com", "pers", 'LBRSRN63B16A251S', "mail");


