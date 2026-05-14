create user leonardo@localhost identified by "flandia";
GRANT ALL PRIVILEGES
ON mydb.*
TO 'leonardo'@'localhost'
WITH GRANT OPTION;

INSERT INTO `File` VALUES ('EFTA00015037',' https://www.justice.gov/epstein/files/DataSet%208/EFTA00015037.pdf','2025-01-01',8,91,'Persone arrestate da NYPD',3),('EFTA00077895',' https://www.justice.gov/epstein/files/DataSet%208/EFTA00077895.pdf','2025-01-01',9,89,'Persone arrestate da NYPD',5);

INSERT INTO `Persona` VALUES ('CSFSVSVFSV','Alonzo','Quinn',NULL,NULL,'M','Stati Uniti',NULL,NULL,NULL,'Poliziotto corrotto',NULL),('PSCOP','Patrick','Simmons',NULL,NULL,'M','Stati Uniti',NULL,NULL,NULL,'Poliziotto corrotto',NULL);
insert into Persona values ("JLCOP", "John", "Laskey", NULL, NULL, "M", "Stati Uniti", NULL, NULL, NULL, 'Poliziotto corrotto', NULL);

INSERT INTO `Organizzazione` VALUES ('CRORGUSANY001','NYPD-HR','CSFSVSVFSV','Stati Uniti',NULL,NULL,NULL,'Polizia corrotta',NULL),('DOJPDNY01','NYPD',NULL,'Stati Uniti',NULL,NULL,NULL,'Polizia',NULL);

INSERT INTO `Lavoro` VALUES (1,'CSFSVSVFSV',500000,'Boss',NULL,'CRORGUSANY001','org');

insert into `lavoro` values (2,'PSCOP',100000,'Secondo del boss','CSFSVSVFSV',NULL,'pers');

INSERT INTO `Soggetto` VALUES (1,'EFTA00077895','CRORGUSANY001',NULL,'org');

insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("PSCOP", 40000, "Poliziotto", "DOJPDNY01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("PSCOP", 300000, "Mano destra del boss", 'CRORGUSANY001',"org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("CSFSVSVFSV", 110000, "Capo della polizia", "DOJPDNY01", "org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JLCOP", 511000, "Scagnozzo", 'CRORGUSANY001',"org"); --non entra causa trigger
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JLCOP", 40000, "Scagnozzo", 'CRORGUSANY001',"org");
insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperorg, OrgOpers) values ("JLCOP", 30000, "Poliziotto", "DOJPDNY01","org");


insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00015037", 23, "Mugshot di Patrick Simmons", 0, "NYPD Police station 5", "2024-01-01");
insert into `Immagine`(`ID Immagine`, `Dimensione KB`, Descrizione, `Redacted%`, `Nome luogo`, `Data e tempo`) values ("IMGEFTA00015037-1", 21, "Mugshot di Alonzo Quinn", 0, "NYPD Police station 5", "2024-01-01");

insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("CSFSVSVFSV", "IMGEFTA00015037-1", "EFTA00015037");
insert into `Persona in immagine`(`ID Persona`, `ID Immagine`, `ID File`) values ("PSCOP", "IMGEFTA00015037", "EFTA00015037");

insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("PSCOP", "EFTA00015037", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("CSFSVSVFSV", "EFTA00015037", "pers");
insert into `Soggetto`(`ID Persona`, `File ID`, PersOorg) values ("PSCOP", "EFTA00077895", "pers");

insert into `Lavoro`(`ID Lavoratore`, Salario, tipo, lavoraperpersona, orgopers) values ('CRORGUSANY001', 100000, "Crimini", 'CSFSVSVFSV', "pers"); --non si inserisce causa trigger
delete from Lavoro where `ID Lavoratore` = 'CRORGUSANY001' and lavoraperpersona = 'CSFSVSVFSV';

insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `Indirizzo mittente`, tipo) values 
('CMEFTA00015037', 'EFTA00015037', "PSCOP", "pers", 10, "2024-01-01", "Problemino col tizio", 
"Il secondo del boss descrive un incontro con il misterioso tizio col vestito nero (andato stramale)", "Patrick.Simmons@hotmail.com", "Mail");
insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `Indirizzo mittente`, tipo, `Risposta`) values 
('CMEFTA00015037-1', 'EFTA00015037', 'CSFSVSVFSV', "pers", 10, "2024-01-01", "Siete stupidi", 
"Il boss del HR riprovera il suo secondo per la sua incompetenza", "Alonzo.Quinn@hotmail.com", "Mail", 'CMEFTA00015037');


insert into mail(`Mail ID`, `File ID`, `ID Mittente Persona`, `Org o Pers`, `Redacted%`, `Data e tempo`, Oggetto, Descrizione, `num telefono mittente`, tipo) values 
('CMEFTA00015037-2', 'EFTA00015037', "PSCOP", "pers", 10, "2024-01-01", "Problema risolto", 
"Il secondo del boss informa il capo che hanno completato un contratto", "041515215", "telefonata");

insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00015037', "Alonzo.Quinn@hotmail.com", "pers", 'CSFSVSVFSV', "mail");
insert into destinatari(`Mail ID`, `Indirizzo mail destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00015037-1', "Patrick.Simmons@hotmail.com", "pers", 'PSCOP', "telefonata");
insert into destinatari(`Mail ID`, `Num telefono destinatario`, `Pers o org`, `ID Persona`, `tipo`) values ('CMEFTA00015037-2', "0941515125", "pers", 'CSFSVSVFSV', "telefonata");


select * from file;
select * from soggetto;