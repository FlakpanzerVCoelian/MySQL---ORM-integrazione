--calcola il salario per ID

delimiter $$$
create function contasoldi(var char(30)) returns int deterministic begin
    return (select sum(salario) from Lavoro where `ID Lavoratore` = var);
end $$$
delimiter ;

delimiter $$$
create procedure contasoldiSP(IN var char(30)) begin
	select sum(salario) from Lavoro where `ID Lavoratore` = var;
end $$$
delimiter ;

drop procedure contasoldiSP;

--conta il salario totale dei dipendenti
delimiter $$$

create function contasalario(var char(30)) returns int deterministic BEGIN
	return (select sum(salario) from Lavoro where lavoraperorg = var);
end $$$

delimiter ;

delimiter $$$
create procedure contasalarioSP(IN var char(30)) begin
	select sum(salario) from Lavoro where lavoraperorg = var;
end $$$
delimiter ;

--conta quante volte qualcuno fu visto in immagini

delimiter $$$ 
create procedure contarefimgs(IN IDPERS varchar(25)) begin
	select count(pi.`ID Immagine`) as nrif from Persona p join Soggetto using (`ID Persona`) join `File` ff using(`File ID`) join `Persona in immagine` pi on ff.`File ID` = pi.`ID File` where p.`ID Persona` = IDPERS group by `ID Immagine`;
END $$$
delimiter ;

--conta quante volte qualcuno fu menzionato in files

delimiter $$$
create procedure contareffiles(IN IDPERS varchar(25)) begin
	select count(soggetto.`File ID`) as nrif from Persona join Soggetto using (`ID Persona`) where `ID Persona` = IDPERS;
END $$$
delimiter ;

-- seleziona tutti gli indirizzi mail del soggetto e numeri di telefono

delimiter $$$
create procedure ritornacom(IN IDSOGG varchar(30), IN OOP char(4)) begin
	if OOP = "pers" then
		select distinct `indirizzo mittente` as comunicazione from mail where `indirizzo mittente` is not null and `ID mittente persona` = IDSOGG union 
        select distinct `num telefono mittente` from mail  where `num telefono mittente` is not null  and `ID mittente persona` = IDSOGG;
	elseif OOP = "org" then
		select distinct `indirizzo mittente` as comunicazione from mail where `indirizzo mittente` is not null and `ID mittente organizzazione` = IDSOGG union 
        select distinct `num telefono mittente` from mail  where `num telefono mittente` is not null  and `ID mittente organizzazione` = IDSOGG;
    else
		signal sqlstate "45510"
        set message_text = "Argomento invalido per la SP ritornacom(. , .)";
	end if;
END $$$
delimiter ;

--ritorna il numero di comunicazioni che ha fatto la persona (o org)

delimiter $$$
create procedure quanticomMITT(IN IDSOGG varchar(30), IN OOP char(4), IN spec varchar(10)) begin
	if OOP = "pers" then
		if spec = "000" then
			select count(*) from Mail where `ID mittente persona` = IDSOGG;
		else 
			select count(*) from Mail where `ID mittente persona` = IDSOGG and tipo = spec;
		end if;
    elseif OOP = "org" then
		if spec = "000" then
			select count(*) from Mail where `ID mittente organizzazione` = IDSOGG;
		else 
			select count(*) from Mail where `ID mittente organizzazione` = IDSOGG and tipo = spec;
		end if;
    else
		signal sqlstate "45520"
        set message_text = "Argomento invalido per la SP quanticom(. , ., .)";
	end if;
END $$$
delimiter ;

--ritorna quanti lavori fa la persona e per chi

delimiter $$$
create procedure `Che lavori fai`(IN IDPERS varchar(30)) begin
	select org.Nome as `Datore di lavoro`, la.tipo, la.salario as `Compenso` from Lavoro la join Organizzazione org on lavoraperorg = `ID Organizzazione` where la.OrgOpers = "org" 
    and la.`ID lavoratore` = IDPERS union (select pers.cognome as `Datore di lavoro`, la.tipo, la.salario from Lavoro la join Persona pers on la.lavoraperpersona = `ID Persona` where la.OrgOpers = "pers" 
    and la.`ID lavoratore` = IDPERS) union (select count(*), "Salario totale:", sum(la.salario) from Lavoro la where `ID lavoratore` = IDPERS);
END $$$
delimiter ;

--calcola il salario totale dei dipendenti

delimiter $$$
create procedure dipendenti(IN IDSOGG varchar(30), IN tipo char(4)) begin
	if tipo = "org" then
	select pers.Cognome as `Datore di lavoro`, la.tipo, la.Salario as `Compenso` from Lavoro la join Persona pers on la.`ID Lavoratore` = `ID Persona` where la.lavoraperorg = IDSOGG
    union (select org.Nome, la.tipo, la.salario from Lavoro la join Organizzazione org on `ID Organizzazione` = `ID Lavoratore` where lavoraperorg = IDSOGG) union
    (select count(*), "Salario totale:", sum(la.salario) from Lavoro la where lavoraperorg = IDSOGG);
    elseif tipo = "pers" then
	select pers.Cognome as `Datore di lavoro`, la.tipo, la.Salario as `Compenso` from Lavoro la join Persona pers on la.`ID Lavoratore` = `ID Persona` where la.lavoraperpersona = IDSOGG
    union (select org.Nome, la.tipo, la.salario from Lavoro la join Organizzazione org on `ID Organizzazione` = `ID Lavoratore` where lavoraperpersona = IDSOGG) union
    (select count(*), "Salario totale:", sum(la.salario) from Lavoro la where lavoraperpersona = IDSOGG);
    else
		signal sqlstate "45530"
        set message_text = "Argomenti invalidi per la SP dipendenti(. , .)";
	end if;
END $$$
delimiter ;

--fa vedere dove fu vista la persona (e file di riferimento)

delimiter $$$
create procedure `Dove sei scattato`(IN IDSOGG varchar(25)) begin
	select img.`Nome Luogo` as Dove, pmg.`ID File` as `File di riferimento`, img.`Data e Tempo` as `Quando` from Immagine img join `Persona in immagine` pmg using(`ID Immagine`) 
    where pmg.`ID Persona` = IDSOGG union (select (select cognome from Persona where `ID Persona` = IDSOGG) ,"Fu visto volte:",count(*) from `Persona in immagine` where `ID Persona` = IDSOGG);
END $$$
delimiter ;

--fa vedere con chi comunicava

delimiter $$$
create procedure ChiCOMMS(IN IDSOGG VARCHAR(30), IN tipo char(4)) begin
	if tipo = "pers" then
		select distinct pers.Cognome from mail ma join destinatari dest using(`Mail ID`) join persona pers using(`ID Persona`) where 
		ma.`Mail ID` in (select `Mail ID` from mail ma2 where `ID Mittente Persona` = IDSOGG) union (select distinct org.nome from mail ma join destinatari dest using(`Mail ID`) 
		join organizzazione org using(`ID Organizzazione`) where ma.`Mail ID` in (select `Mail ID` from mail ma2 where `ID Mittente Persona` = IDSOGG));
    elseif tipo = "org" then
		select distinct pers.Cognome from mail ma join destinatari dest using(`Mail ID`) join persona pers using(`ID Persona`) where 
		ma.`Mail ID` in (select `Mail ID` from mail ma2 where `ID Mittente Organizzazione` = IDSOGG) union (select distinct org.nome from mail ma join destinatari dest using(`Mail ID`) 
		join organizzazione org using(`ID Organizzazione`) where ma.`Mail ID` in (select `Mail ID` from mail ma2 where `ID Mittente Organizzazione` = IDSOGG));
	else
		signal sqlstate "45540"
        set message_text = "Argomenti invalidi per la SP ChiCOMMS(. , .)";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `Fall Zyklus 1` after insert on `Lavoro` for each row begin
	declare proprietario varchar(30);
	select `ID proprietario` into proprietario from organizzazione where `ID organizzazione` = new.`ID Lavoratore`;
	if new.`Lavoraperpersona` = proprietario then
		signal sqlstate "45300"
        set message_text = "Una compagnia che ha come proprietario/direttore una persona, non può lavorare per quella stessa persona";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `Fall Zyklus 1 NACH AKT` after update on `Lavoro` for each row begin
	declare proprietario varchar(30);
	select `ID proprietario` into proprietario from organizzazione where `ID lavoratore` = new.`ID lavoratore`;
	if new.`Lavoraperpersona` = proprietario then
		signal sqlstate "45300"
        set message_text = "Una compagnia che ha come proprietario/direttore una persona, non può lavorare per quella stessa persona";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `comm dupl` after insert on `Mail` for each row begin
	if new.`Indirizzo mittente` is not null and new.`num telefono mittente` is not null then
		signal sqlstate "45600"
        set message_text = "La comunicazione non puo essere sia per telefono che per mail allo stesso tempo";
	end if;
    if new.tipo is null then
		signal sqlstate "45610"
        set message_text = "Il tipo della comunicazione non è specificato";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `comm dupl AU` after update on `Mail` for each row begin
	if new.`Indirizzo mittente` is not null and new.`num telefono mittente` is not null then
		signal sqlstate "45600"
        set message_text = "La comunicazione non puo essere sia per telefono che per mail allo stesso tempo";
	end if;
    if new.tipo is null then
		signal sqlstate "45610"
        set message_text = "Il tipo della comunicazione non è specificato";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `comm dupl DEST` after insert on `Destinatari` for each row begin
	if new.`Indirizzo mail destinatario` is not null and new.`Num telefono destinatario` is not null then
		signal sqlstate "45620"
        set message_text = "La comunicazione non puo essere sia per telefono che per mail allo stesso tempo";
	end if;
    if new.tipo is null then
		signal sqlstate "45630"
        set message_text = "Il tipo della comunicazione non è specificato";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `comm dupl DEST AU` after update on `Destinatari` for each row begin
	if new.`Indirizzo mail destinatario` is not null and new.`Num telefono destinatario` is not null then
		signal sqlstate "45620"
        set message_text = "La comunicazione non puo essere sia per telefono che per mail allo stesso tempo";
	end if;
    if new.tipo is null then
		signal sqlstate "45630"
        set message_text = "Il tipo della comunicazione non è specificato";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `Paga minima del boss` after insert on `Lavoro` for each row begin
	if new.`ID Lavoratore` = (select `ID proprietario` from Organizzazione where `ID organizzazione` = new.`lavoraperorg`) and new.Salario < (select max(salario) from Lavoro where Lavoraperorg = new.lavoraperorg) then
		signal sqlstate "45700"
        set message_text = "Il boss non puo avere il salario minore rispetto ad un suo dipendente";
	end if;
END $$$
DELIMITER ;

delimiter $$$
create trigger `Paga minima del boss AU` after update on `Lavoro` for each row begin
	if new.`OrgOpers` = "org" and new.`ID Lavoratore` = (select `ID proprietario` from Organizzazione where `ID organizzazione` = new.`lavoraperorg`) and new.Salario < (select max(salario) from Lavoro where Lavoraperorg = new.lavoraperorg) then
		signal sqlstate "45701"
        set message_text = "Il boss non puo avere il salario minore rispetto ad un suo dipendente";
	end if;
END $$$
DELIMITER ;

DELIMITER $$$
create trigger `Salario massimo del impiegato` after insert on Lavoro for each row begin
	declare IDPROP varchar(25);
    declare SALMAX int;
    select `ID proprietario` into IDPROP from Organizzazione where `ID Organizzazione` = new.`lavoraperorg`;
    select salario into SALMAX from Lavoro where `ID lavoratore` = IDPROP and lavoraperorg = new.`lavoraperorg`;
    if new.`OrgOpers` = "org" and new.`Salario` > SALMAX then
		signal sqlstate "45710"
        set message_text = "Un nuovo dipendente non può avere un salario maggiore a quello del proprietario di tale organizzazione";
	end if;
END $$$
delimiter ;

DELIMITER $$$
create trigger `Salario massimo del impiegato AU` after update on Lavoro for each row begin
	declare IDPROP varchar(25);
    declare SALMAX int;
    select `ID proprietario` into IDPROP from Organizzazione where `ID Organizzazione` = new.`lavoraperorg`;
    select salario into SALMAX from Lavoro where `ID lavoratore` = IDPROP and lavoraperorg = new.`lavoraperorg`;
    if new.`OrgOpers` = "org" and new.`Salario` > SALMAX then
		signal sqlstate "45710"
        set message_text = "Un nuovo dipendente non può avere un salario maggiore a quello del proprietario di tale organizzazione";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `dopo di prima COMM` after insert on `Mail` for each row begin
	if date(new.`Data e Tempo`) > (select data from file ff where ff.`File ID` = new.`File ID`) then
		signal sqlstate "45800"
        set message_text = "Una comunicazione non puo esser pervenuta dopo il rilascio del file che la contiene";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `dopo di prima COMM AU` after update on `Mail` for each row begin
	if date(new.`Data e Tempo`) > (select data from file ff where ff.`File ID` = new.`File ID`) then
		signal sqlstate "45801"
        set message_text = "Una comunicazione non puo esser pervenuta dopo il rilascio del file che la contiene";
	end if;
END $$$
delimiter ;

delimiter $$$
create trigger `dopo di prima IMG` after insert on `Immagine` for each row begin
	if date(new.`Data e Tempo`) > (select data from file ff where ff.`File ID` = (select `ID File` from `Persona in immagine` where `ID Immagine` = new.`ID Immagine`)) then
			signal sqlstate "45810"
        set message_text = "Un'immagine non puo esser scattata dopo il rilascio del file che la contiene";
	end if;
END $$$
delimiter ;	

delimiter $$$
create trigger `dopo di prima IMG AU` after update on `Immagine` for each row begin
	if date(new.`Data e Tempo`) > (select data from file ff where ff.`File ID` = (select `ID File` from `Persona in immagine` where `ID Immagine` = new.`ID Immagine`)) then
			signal sqlstate "45810"
        set message_text = "Un'immagine non puo esser scattata dopo il rilascio del file che la contiene";
	end if;
END $$$
delimiter ;	
