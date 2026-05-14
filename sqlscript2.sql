SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

DROP TABLE IF EXISTS `mydb`.`File` ;
DROP TABLE IF EXISTS `mydb`.`Destinatari` ;
DROP TABLE IF EXISTS `mydb`.`Immagine` ;
DROP TABLE IF EXISTS `mydb`.`Lavoro` ;
DROP TABLE IF EXISTS `mydb`.`Mail` ;
DROP TABLE IF EXISTS `mydb`.`Organizzazione` ;
DROP TABLE IF EXISTS `mydb`.`Persona` ;
DROP TABLE IF EXISTS `mydb`.`Persona in immagine` ;
DROP TABLE IF EXISTS `mydb`.`Soggetto` ;


CREATE TABLE IF NOT EXISTS `mydb`.`Destinatari` (
  `Num Destinatario` INT(5) NOT NULL AUTO_INCREMENT,
  `Mail ID` VARCHAR(25) NOT NULL,
  `Indirizzo mail destinatario` VARCHAR(45) NULL,
  `Num telefono destinatario` VARCHAR(20) NULL,
  `Pers o org` ENUM("pers", "org") NOT NULL,
  `ID Persona` VARCHAR(25) NULL,
  `ID Organizzazione` VARCHAR(30) NULL,
  PRIMARY KEY (`Num Destinatario`, `Mail ID`, `Pers o org`))
ENGINE = InnoDB;

alter table `mydb`.`Destinatari` add tipo varchar(10);

CREATE TABLE IF NOT EXISTS `mydb`.`File` (
  `File ID` CHAR(20) NOT NULL,
  `Link` VARCHAR(100) NOT NULL,
  `Data` DATE NOT NULL,
  `Batch` TINYINT(1) NOT NULL,
  `Redacted %` TINYINT(1) NOT NULL,
  `Descrizione generale` VARCHAR(400) NULL,
  `Dimensione (KB)` INT(8) NULL,
  PRIMARY KEY (`File ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Immagine` (
  `Id Immagine` VARCHAR(25) NOT NULL,
  `Dimensione KB` INT(8) NULL,
  `Descrizione` VARCHAR(400) NULL,
  `Redacted%` TINYINT(3) NULL,
  `Nome luogo` VARCHAR(45) NULL,
  `Data e tempo` DATETIME(6) NOT NULL,
  `Paese` VARCHAR(30) NULL,
  `Regione` VARCHAR(30) NULL,
  `Comune` VARCHAR(30) NULL,
  `Via` VARCHAR(30) NULL,
  `CAP` INT(5) NULL,
  PRIMARY KEY (`Id Immagine`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Lavoro` (
  `Num. Lavoro` INT(5) NOT NULL AUTO_INCREMENT,
  `Id lavoratore` VARCHAR(30) NOT NULL,
  `Salario` INT(8) NULL,
  `Tipo` VARCHAR(45) NULL,
  `Lavoraperpersona` VARCHAR(30) NULL,
  `Lavoraperorg` VARCHAR(30) NULL,
  `OrgOpers` ENUM("org", "pers") NOT NULL,
  PRIMARY KEY (`Num. Lavoro`, `Id lavoratore`, `OrgOpers`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Mail` (
  `Mail ID` VARCHAR(25) NOT NULL,
  `File ID` CHAR(20) NOT NULL,
  `ID Mittente Organizzazione` VARCHAR(30),
  `ID Mittente Persona` VARCHAR(30),
  `Org o Pers` ENUM("org", "pers") NOT NULL,
  `Data e Tempo` DATETIME(6) NOT NULL,
  `Risposta` VARCHAR(25) NULL DEFAULT NULL,
  `Redacted%` TINYINT(3) NULL,
  `Oggetto` VARCHAR(45) NULL DEFAULT NULL,
  `Descrizione` VARCHAR(400) NULL,
  `Indirizzo mittente` VARCHAR(45) NULL,
  `Num telefono mittente` VARCHAR(20) NULL,
  `tipo` VARCHAR(10) NULL,
  PRIMARY KEY (`Mail ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Organizzazione` (
  `ID Organizzazione` VARCHAR(30) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `ID Proprietario` VARCHAR(30) NULL DEFAULT NULL,
  `Paese` VARCHAR(45) NULL,
  `Comune` VARCHAR(45) NULL,
  `Sede (indirizzo)` VARCHAR(45) NULL,
  `CAP` INT(7) NULL,
  `Tipo` VARCHAR(20) NULL,
  `Lavora per` VARCHAR(30) NULL,
  PRIMARY KEY (`ID Organizzazione`))

ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `ID Persona` VARCHAR(30) NOT NULL,
  `Nome` VARCHAR(20) NOT NULL,
  `Cognome` VARCHAR(20) NOT NULL,
  `Secondo nome` VARCHAR(45) NULL DEFAULT NULL,
  `Titolo` VARCHAR(30) NULL DEFAULT NULL,
  `Sesso` CHAR(1) NOT NULL,
  `Stato di residenza` VARCHAR(30) NOT NULL,
  `Comune` VARCHAR(45) NULL,
  `Via` VARCHAR(45) NULL,
  `CAP` INT(7) NULL,
  `Tipo/Ruolo` VARCHAR(45) NULL,
  `Lavora per` VARCHAR(30) NULL,
  PRIMARY KEY (`ID Persona`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Persona in immagine` (
  `ID Persona` VARCHAR(30) NULL DEFAULT NULL,
  `ID Immagine` VARCHAR(25) NOT NULL,
  `ID File` CHAR(20) NOT NULL,
  PRIMARY KEY (`ID Immagine`, `ID File`),
  INDEX `ID Persona_idx` (`ID Persona` ASC) VISIBLE,
  INDEX `ID File_idx` (`ID File` ASC) VISIBLE)

ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Soggetto` (
  `N. rif del file` INT(5) NOT NULL AUTO_INCREMENT,
  `File ID` CHAR(20) NOT NULL,
  `ID Organizzazione` VARCHAR(30) NULL,
  `ID Persona` VARCHAR(45) NULL,
  `PersOorg` ENUM("org", "pers") NOT NULL,
  PRIMARY KEY (`N. rif del file`, `File ID`, `PersOorg`))
ENGINE = InnoDB;



alter table `mydb`.`Destinatari`

  add CONSTRAINT `Mail ID dest`
    FOREIGN KEY (`Mail ID`)
    REFERENCES `mydb`.`Mail` (`Mail ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `ID Persona dest`
    FOREIGN KEY (`ID Persona`)
    REFERENCES `mydb`.`Persona` (`ID Persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `ID Org dest`
    FOREIGN KEY (`ID Organizzazione`)
    REFERENCES `mydb`.`Organizzazione` (`ID Organizzazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

alter table `mydb`.`Lavoro`

  add FOREIGN KEY (`Lavoraperpersona`) REFERENCES `mydb`.`Persona` (`ID Persona`),
  add FOREIGN KEY (`Lavoraperorg`) REFERENCES `mydb`.`Organizzazione` (`ID Organizzazione`);



alter table `mydb`.`Mail`

  add CONSTRAINT `Mittente mail`
    FOREIGN KEY (`ID Mittente Organizzazione`)
    REFERENCES `mydb`.`Organizzazione` (`ID Organizzazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `Mittente1`
    FOREIGN KEY (`ID Mittente Persona`)
    REFERENCES `mydb`.`Persona` (`ID Persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `Risposta mail`
    FOREIGN KEY (`Risposta`)
    REFERENCES `mydb`.`Mail` (`Mail ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `File ID mail`
    FOREIGN KEY (`File ID`)
    REFERENCES `mydb`.`File` (`File ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

alter table `mydb`.`Organizzazione`
  add CONSTRAINT `ID Proprietario org`
    FOREIGN KEY (`ID Proprietario`)
    REFERENCES `mydb`.`Persona` (`ID Persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

alter table `mydb`.`Persona in immagine`
  add CONSTRAINT `ID Persona Pers in img`
    FOREIGN KEY (`ID Persona`)
    REFERENCES `mydb`.`Persona` (`ID Persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `ID File pers in img`
    FOREIGN KEY (`ID File`)
    REFERENCES `mydb`.`File` (`File ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `ID Immagine pers in img`
    FOREIGN KEY (`ID Immagine`)
    REFERENCES `mydb`.`Immagine` (`Id Immagine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

alter table `mydb`.`Soggetto`

  add CONSTRAINT `File ID sogg`
    FOREIGN KEY (`File ID`)
    REFERENCES `mydb`.`File` (`File ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `Lavoraperpersona sogg`
    FOREIGN KEY (`ID Persona`)
    REFERENCES `mydb`.`Persona` (`ID Persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  add CONSTRAINT `Lavoraperorg sogg`
    FOREIGN KEY (`ID Organizzazione`)
    REFERENCES `mydb`.`Organizzazione` (`ID Organizzazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;




USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreDEST` $$
USE `mydb`$$
CREATE TRIGGER `ControllapuntatoreDEST` AFTER INSERT ON `Destinatari` FOR EACH ROW
BEGIN
	if new.`Pers o org` not in ("org", "pers") or (new.`ID Persona` is not null and new.`ID Organizzazione` is not null) or (new.`ID Persona`  is null and new.`ID Organizzazione` is null) then 
		signal sqlstate "45210"
        set message_text = "Il record deve avere uno ed uno solo puntatore a persono o ad organizzazione";
	end if;
    
	if new.`Pers o org` = "org" and (new.`ID Persona`  is not null or new.`ID Organizzazione` is null) then 
		signal sqlstate "45220"
        set message_text = "Mismatch tra riferimento all'esterno (non è organizzazione)";
	elseif new.`Pers o org` = "pers" and (new.`ID Persona`  is null or new.`ID Organizzazione` is not null) then 
		signal sqlstate "45230"
        set message_text = "Mismatch tra riferimento all'esterno (non è persona)";
     end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`controllaesistenzaDEST` $$
USE `mydb`$$
CREATE  TRIGGER `controllaesistenzaDEST` AFTER INSERT ON `Destinatari` FOR EACH ROW
BEGIN
	if new.`Pers o org` = "org" and not exists (select 1 from Organizzazione where `ID Organizzazione` = new.`ID Organizzazione`) then
		signal sqlstate "45040"
        set message_text = "Quell' organizzazione non esiste ed il soggetto non può lavorare per essa";
	elseif new.`Pers o org` = "pers" and not exists (select 1 from Persona where `ID Persona` = new.`ID Persona`) then
		signal sqlstate "45041"
        set message_text = "Quella persona non esiste ed il soggetto non può lavorare per essa";
	end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreAUDEST` $$
USE `mydb`$$
CREATE TRIGGER `ControllapuntatoreAUDEST` AFTER UPDATE ON `Destinatari` FOR EACH ROW
BEGIN
	if new.`Pers o org` not in ("org", "pers") or (new.`ID Persona` is not null and new.`ID Organizzazione` is not null) or (new.`ID Persona`  is null and new.`ID Organizzazione` is null) then 
		signal sqlstate "45210"
        set message_text = "Il record deve avere uno ed uno solo puntatore a persono o ad organizzazione";
	end if;
    
	if new.`Pers o org` = "org" and (new.`ID Persona`  is not null or new.`ID Organizzazione` is null) then 
		signal sqlstate "45220"
        set message_text = "Mismatch tra riferimento all'esterno (non è organizzazione)";
	elseif new.`Pers o org` = "pers" and (new.`ID Persona`  is null or new.`ID Organizzazione` is not null) then 
		signal sqlstate "45230"
        set message_text = "Mismatch tra riferimento all'esterno (non è persona)";
     end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreMAIL` $$
USE `mydb`$$

CREATE TRIGGER `ControllapuntatoreMAIL` after insert on `Mail` FOR EACH ROW
BEGIN
	if new.`Org o Pers` not in ("org", "pers") or (new.`ID Mittente Persona` is not null and new.`ID Mittente Organizzazione` is not null) or (new.`ID Mittente Persona` is null and new.`ID Mittente Organizzazione` is null) then
	signal sqlstate "45410"
	set message_text = "Riferimento all' esterno non valido";
end if;
end $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreMAIL` $$
USE `mydb`$$

CREATE TRIGGER `ControllapuntatoreMAILAU` after UPDATE on `Mail` FOR EACH ROW
BEGIN
	if new.`Org o Pers` not in ("org", "pers") or (new.`ID Mittente Persona` is not null and new.`ID Mittente Organizzazione` is not null) or (new.`ID Mittente Persona` is null and new.`ID Mittente Organizzazione` is null) then
	signal sqlstate "45410"
	set message_text = "Riferimento all' esterno non valido";
end if;
end $$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`controllaesistenzaAUDEST` $$
USE `mydb`$$
CREATE  TRIGGER `controllaesistenzaAUDEST` AFTER update ON `Destinatari` FOR EACH ROW
BEGIN
	if new.`Pers o org` = "org" and not exists (select 1 from Organizzazione where `ID Organizzazione` = new.`ID Organizzazione`) then
		signal sqlstate "45040"
        set message_text = "Quell' organizzazione non esiste ed il soggetto non può lavorare per essa";
	elseif new.`Pers o org` = "pers" and not exists (select 1 from Persona where `ID Persona` = new.`ID Persona`) then
		signal sqlstate "45041"
        set message_text = "Quella persona non esiste ed il soggetto non può lavorare per essa";
	end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreLAV` $$
USE `mydb`$$
CREATE TRIGGER `ControllapuntatoreLAV` AFTER INSERT ON `Lavoro` FOR EACH ROW
BEGIN
	if new.OrgOpers not in ("org", "pers") or (new.Lavoraperpersona is not null and new.Lavoraperorg is not null) or (new.Lavoraperpersona is null and new.Lavoraperorg is null) then 
		signal sqlstate "45010"
        set message_text = "Il record deve avere uno ed uno solo puntatore a persono o ad organizzazione";
	end if;
    
	if new.Orgopers = "org" and (new.Lavoraperpersona is not null or new.Lavoraperorg is null) then 
		signal sqlstate "45020"
        set message_text = "Mismatch tra riferimento all'esterno (non è organizzazione)";
	elseif new.Orgopers = "pers" and (new.Lavoraperpersona is null or new.Lavoraperorg is not null) then 
		signal sqlstate "45030"
        set message_text = "Mismatch tra riferimento all'esterno (non è persona)";
     end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`controllaesistenzaLAV` $$
USE `mydb`$$
CREATE  TRIGGER `controllaesistenzaLAV` AFTER INSERT ON `Lavoro` FOR EACH ROW
BEGIN
	if new.OrgOpers = "org" and not exists (select 1 from Organizzazione where `ID Organizzazione` = new.Lavoraperorg) then
		signal sqlstate "45040"
        set message_text = "Quell' organizzazione non esiste ed il soggetto non può lavorare per essa";
	elseif new.OrgOpers = "pers" and not exists (select 1 from Persona where `ID Persona` = new.Lavoraperpersona) then
		signal sqlstate "45041"
        set message_text = "Quella persona non esiste ed il soggetto non può lavorare per essa";
	end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreAULAV` $$
USE `mydb`$$
CREATE TRIGGER `ControllapuntatoreAULAV` AFTER UPDATE ON `Lavoro` FOR EACH ROW
BEGIN
	if new.OrgOpers not in ("org", "pers") or (new.Lavoraperpersona is not null and new.Lavoraperorg is not null) or (new.Lavoraperpersona is null and new.Lavoraperorg is null) then 
		signal sqlstate "45010"
        set message_text = "Il record deve avere uno ed uno solo puntatore a persono o ad organizzazione";
	end if;
    
	if new.Orgopers = "org" and (new.Lavoraperpersona is not null or new.Lavoraperorg is null) then 
		signal sqlstate "45020"
        set message_text = "Mismatch tra riferimento all'esterno (non è organizzazione)";
	elseif new.Orgopers = "pers" and (new.Lavoraperpersona is null or new.Lavoraperorg is not null) then 
		signal sqlstate "45030"
        set message_text = "Mismatch tra riferimento all'esterno (non è persona)";
     end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`controllaesistenzaAULAV` $$
USE `mydb`$$
CREATE  TRIGGER `controllaesistenzaAULAV` AFTER UPDATE ON `Lavoro` FOR EACH ROW
BEGIN
	if new.OrgOpers = "org" and not exists (select 1 from Organizzazione where `ID Organizzazione` = new.Lavoraperorg) then
		signal sqlstate "45040"
        set message_text = "Quell' organizzazione non esiste ed il soggetto non può lavorare per essa";
	elseif new.OrgOpers = "pers" and not exists (select 1 from Persona where `ID Persona` = new.Lavoraperpersona) then
		signal sqlstate "45041"
        set message_text = "Quella persona non esiste ed il soggetto non può lavorare per essa";
	end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreSOGG` $$
USE `mydb`$$
CREATE TRIGGER `ControllapuntatoreSOGG` AFTER INSERT ON `Soggetto` FOR EACH ROW
BEGIN
	if new.PersOorg not in ("org", "pers") or (new.`ID Persona` is not null and new.`ID Organizzazione` is not null) or (new.`ID Persona` is null and new.`ID Organizzazione` is null) then 
		signal sqlstate "45110"
        set message_text = "Il record deve avere uno ed uno solo puntatore a persono o ad organizzazione";
	end if;
    
	if new.PersOorg = "org" and (new.`ID Persona` is not null or new.`ID Organizzazione` is null) then 
		signal sqlstate "45120"
        set message_text = "Mismatch tra riferimento all'esterno (non è organizzazione)";
	elseif new.PersOorg = "pers" and (new.`ID Persona` is null or new.`ID Organizzazione`is not null) then 
		signal sqlstate "45130"
        set message_text = "Mismatch tra riferimento all'esterno (non è persona)";
     end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`controllaesistenzaSOGG` $$
USE `mydb`$$
CREATE  TRIGGER `controllaesistenzaSOGG` AFTER INSERT ON `Soggetto` FOR EACH ROW
BEGIN
	if new.PersOorg = "org" and not exists (select 1 from Organizzazione where `ID Organizzazione` = new.`ID Organizzazione`) then
		signal sqlstate "45140"
        set message_text = "Quell' organizzazione non esiste ed il soggetto non può lavorare per essa";
	elseif new.PersOorg = "pers" and not exists (select 1 from Persona where `ID Persona` = new.`ID Persona`) then
		signal sqlstate "45141"
        set message_text = "Quella persona non esiste ed il soggetto non può lavorare per essa";
	end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`ControllapuntatoreAUSOGG` $$
USE `mydb`$$
CREATE TRIGGER `ControllapuntatoreAUSOGG` AFTER UPDATE ON `Soggetto` FOR EACH ROW
BEGIN
	if new.PersOorg not in ("org", "pers") or (new.`ID Persona` is not null and new.`ID Organizzazione` is not null) or (new.`ID Persona` is null and new.`ID Organizzazione` is null) then 
		signal sqlstate "45110"
        set message_text = "Il record deve avere uno ed uno solo puntatore a persono o ad organizzazione";
	end if;
    
	if new.PersOorg = "org" and (new.`ID Persona` is not null or new.`ID Organizzazione` is null) then 
		signal sqlstate "45120"
        set message_text = "Mismatch tra riferimento all'esterno (non è organizzazione)";
	elseif new.PersOorg = "pers" and (new.`ID Persona` is null or new.`ID Organizzazione`is not null) then 
		signal sqlstate "45130"
        set message_text = "Mismatch tra riferimento all'esterno (non è persona)";
     end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`controllaesistenzaAUSOGG` $$
USE `mydb`$$
CREATE  TRIGGER `controllaesistenzaAUSOGG` AFTER UPDATE ON `Soggetto` FOR EACH ROW
BEGIN
	if new.PersOorg = "org" and not exists (select 1 from Organizzazione where `ID Organizzazione` = new.`ID Organizzazione`) then
		signal sqlstate "45140"
        set message_text = "Quell' organizzazione non esiste ed il soggetto non può lavorare per essa";
	elseif new.PersOorg = "pers" and not exists (select 1 from Persona where `ID Persona` = new.`ID Persona`) then
		signal sqlstate "45141"
        set message_text = "Quella persona non esiste ed il soggetto non può lavorare per essa";
	end if;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


