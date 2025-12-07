DDL naredbe za generisanje tabela i ograničenja

--DDL
IF object_id('RADNI_NALOG_ZA_TP','u') is NOT NULL 
DROP TABLE RADNI_NALOG_ZA_TP

IF object_id('OBAVLJA_OSTALE_USLUGE','u') is NOT NULL
DROP TABLE obavlja_ostale_usluge

IF object_id('KORACI_RN','u') is NOT NULL
DROP TABLE KORACI_RN

IF object_id('IZDAJE','u') is NOT NULL
DROP TABLE IZDAJE

IF object_id('FAKTURA','u') is NOT NULL
DROP TABLE FAKTURA

IF object_id('IZVESTAJ','u') is NOT NULL
DROP TABLE izvestaj

IF object_id ('PORUDZBENICA','u') is NOT NULL
DROP TABLE PORUDZBENICA

IF object_id('ZAHTEV','u') is NOT NULL
DROP TABLE ZAHTEV

IF object_id('PROMOCIJA','u') is NOT NULL
DROP TABLE PROMOCIJA

IF object_id('LICENCA','u') is NOT NULL
DROP TABLE LICENCA

IF object_id('RADNIK_ADMIN','u') is NOT NULL
DROP TABLE RADNIK_ADMIN

IF object_id('RADNIK_KONTROLOR','u') is NOT NULL
DROP TABLE RADNIK_KONTROLOR

IF object_id('RADNIK_OSTALI','u') is NOT NULL
DROP TABLE RADNIK_OSTALI

IF object_id('RADNIK_TEHNICKI','u') is NOT NULL
DROP TABLE RADNIK_TEHNICKI


IF object_id('RADNICI','u') is NOT NULL
DROP TABLE RADNICI



 
CREATE TABLE RADNICI (
id_r NUMERIC(5) PRIMARY KEY CONSTRAINT ck_radnik_id_r CHECK(id_r>0),
jmbg NUMERIC(13) NOT NULL CONSTRAINT ck_radnik_jmbg CHECK(len(jmbg)=13),
ime VARCHAR(20) NOT NULL,
prz VARCHAR(20) NOT NULL,
God DATE,
plata NUMERIC(6) NOT NULL CONSTRAINT ck_radnik_plata CHECK(plata>35000),
sss VARCHAR(3), CONSTRAINT ck_radnik_sss CHECK (sss in ('IV','V','VI','VII')),
radno_mesto VARCHAR(20) CONSTRAINT ck_radnik_rm CHECK (radno_mesto in ('RADNIK_TEHNICKI','RADNIK_OSTALI ','RADNIK_KONTROLOR','RADNIK_ADMIN')),
sef NUMERIC(5), 
CONSTRAINT RADNICI_SEF_FK FOREIGN KEY (SEF) REFERENCES RADNICI (ID_R),
brtel VARCHAR(11) NOT NULL,
email VARCHAR(30) NOT NULL
);

CREATE TABLE RADNIK_TEHNICKI (
id_r_tehnicki NUMERIC(5) PRIMARY KEY,
CONSTRAINT fk_radnik_tehnicki_id_r FOREIGN KEY(id_r_tehnicki) REFERENCES radnici(id_r)
);

CREATE TABLE RADNIK_OSTALI (
id_r_ostali NUMERIC(5) PRIMARY KEY,
CONSTRAINT fk_radnik_tehnicki_id_r_ostali FOREIGN KEY(id_r_ostali) REFERENCES radnici(id_r)
);

CREATE TABLE RADNIK_KONTROLOR (
id_r_kONtrolor NUMERIC(5) PRIMARY KEY,
CONSTRAINT fk_radnik_tehnicki_id_r_kONtrolor FOREIGN KEY(id_r_kONtrolor) REFERENCES radnici(id_r)
);

CREATE TABLE RADNIK_ADMIN (
id_r_admin NUMERIC(5) PRIMARY KEY,
CONSTRAINT fk_radnik_tehnicki_id_r_admiin FOREIGN KEY(id_r_admin) REFERENCES radnici(id_r)
);

CREATE TABLE LICENCA (
broj_licence NUMERIC(5) PRIMARY KEY CONSTRAINT ck_licena_br_licence CHECK (broj_licence>0),
vrsta_licence VARCHAR(100) NOT NULL,
datum_izdavanja DATE NOT NULL,
datum_isteka DATE NOT NULL,
izdata_u VARCHAR(20)
)

CREATE TABLE PROMOCIJA(
id_p NUMERIC(5) PRIMARY KEY CONSTRAINT ck_promocija_id_p CHECK(id_p>0),
naziv VARCHAR(50),
datum_pocetka DATE NOT NULL,
datum_isteka DATE NOT NULL
)

 
CREATE TABLE ZAHTEV(
id_zaht NUMERIC (5) PRIMARY KEY CONSTRAINT ck_zahtev_id_zaht CHECK(id_zaht>0),
datum DATE NOT NULL

)

CREATE TABLE PORUDZBENICA(
id_por NUMERIC(5) PRIMARY KEY CONSTRAINT ck_porudzbenica_id_por CHECK(id_por>0),
lista_materijala VARCHAR(20),
kolicina NUMERIC(6) NOT NULL,
ukupan_iznos NUMERIC(7) NOT NULL
)

CREATE TABLE IZVESTAJ(
id_izv NUMERIC(5) PRIMARY KEY CONSTRAINT ck_izvestaj_id_izv CHECK(id_izv>0),
dat_izvrsenja DATE NOT NULL,
komer_oznaka VARCHAR(10) NOT NULL,
napomena VARCHAR(200)
)

CREATE TABLE FAKTURA(
id_f NUMERIC(5) PRIMARY KEY CONSTRAINT ck_faktura_id_f CHECK(id_f>0),
naziv_kupca VARCHAR(20) NOT NULL,
naziv_usluge VARCHAR(20),
cena_usluge NUMERIC(7) NOT NULL,
rok_placanja DATE NOT NULL,
datum_izdavanja DATE NOT NULL,
ukupan_iznos NUMERIC(7) NOT NULL,
nacin_uplate VARCHAR (20) NOT NULL CONSTRAINT ck_faktura_nacin_uplate CHECK (nacin_uplate in ('GOtovinsko placanje','putem racuna')),
)

CREATE TABLE IZDAJE(
id_izv NUMERIC(5),
id_r_admin NUMERIC(5),
CONSTRAINT pk_izdaje PRIMARY KEY (id_izv, id_r_admin),
CONSTRAINT fk_izdaje_id_izv FOREIGN KEY (id_izv) REFERENCES izvestaj (id_izv),
CONSTRAINT fk_izdaje_id_r_admin FOREIGN KEY (id_r_admin) REFERENCES radnik_admin (id_r_admin),
)

CREATE TABLE KORACI_RN(
rbr_krn NUMERIC(5) PRIMARY KEY CONSTRAINT ck_rbr_krn CHECK(rbr_krn>0)
)

CREATE TABLE OBAVLJA_OSTALE_USLUGE(
rbr_krn NUMERIC (5),
id_r_ostali NUMERIC(5),
CONSTRAINT fk_obavlja_ostale_usluge_rbr_krn FOREIGN KEY (rbr_krn) REFERENCES koraci_rn (rbr_krn),
CONSTRAINT fk_obavlja_ostale_usluge_id_r_ostali FOREIGN KEY (id_r_ostali) REFERENCES radnik_ostali (id_r_ostali),
CONSTRAINT pk_obavlja_ostale_usluge PRIMARY KEY (rbr_krn, id_r_ostali),
)

CREATE TABLE RADNI_NALOG_ZA_TP(
id_rntp NUMERIC (5) PRIMARY KEY
)
2.	Sekvence
--1. Sekvenca
CREATE SEQUENCE sekvenca15
increment BY 5
START WITH 15

INSERT INTO zahtev (id_zaht,datum) VALUES (NEXT value FOR sekvenca1,'3/6/2023')

--2. Sekvenca
IF object_id('sekvenca','s') is NOT NULL
DROP SEQUENCE sekvenca
CREATE SEQUENCE sekvenca 
increment BY -1 
START WITH 100 
maxvalue 100 
minvalue 1

3.	DML naredbe za unos podataka u tabele
--INSERT INTO radnici
INSERT INTO radnici VALUES(1,06079998202655,'KONstantin','Sec','6/7/1999',100000,'V','RADNIK_TEHNICKI',null,0615231888, 'sec.kONstantin@gmail.com')
INSERT INTO radnici VALUES(2,07079998202655,'Tina','TomASic','7/7/1999',80000,'V','RADNIK_OSTALI',null,06013456789,'tina.tomASic@gmai.com')
INSERT INTO radnici VALUES (3, 08079998202655, 'Marko', 'Markovic', '8/7/1999', 90000, 'VI', 'RADNIK_KONTROLOR',1, 0629876543, 'marko.markovic@gmail.com')
INSERT INTO radnici VALUES (4, 09079998202655, 'Ana', 'Andric', '9/7/1999', 95000, 'IV', 'RADNIK_OSTALI',1, 0631234567, 'ana.andric@gmail.com')
INSERT INTO radnici VALUES (5, 1007999820265, 'Milos', 'Milosevic', '10/7/1999', 85000, 'VII', 'RADNIK_ADMIN',2, 0645678912, 'milos.milosevic@gmail.com')
INSERT INTO radnici VALUES (6, 1107999820265, 'Jelena', 'Jankovic', '11/7/1999', 95000, 'V', 'RADNIK_OSTALI',null, 0657891234, 'jelena.jankovic@gmail.com')
INSERT INTO radnici VALUES (7, 1207999820265, 'Stefan', 'Stefanovic', '12/7/1999', 90000, 'VI', 'RADNIK_KONTROLOR',2, 0664567891, 'stefan.stefanovic@gmail.com')
INSERT INTO radnici VALUES (8, 1307999820265, 'Maja', 'Maric', '12/7/1999', 85000, 'IV', 'RADNIK_OSTALI',2, 0677891234, 'maja.maric@gmail.com')
INSERT INTO radnici VALUES (9, 1407999820265, 'Petar', 'Petrovic', '10/7/1999', 92000, 'VII', 'RADNIK_TEHNICKI',null, 0681234567, 'petar.petrovic@gmail.com')
INSERT INTO radnici VALUES (10, 1507999820265, 'Jovana', 'Jovanovic', '9/7/1999', 88000, 'IV', 'RADNIK_ADMIN',null, 0692345678, 'jovana.jovanovic@gmail.com')
INSERT INTO radnici VALUES(15, 1507999820265, 'Jovana', 'Jovanovic', '9/7/1999', 88000, 'IV', 'RADNIK_ADMIN',3, 0692345678, 'jovana.jovanovic@gmail.com')
INSERT INTO radnici VALUES(12, 1507999820265, 'Jovana', 'Markovic', '9/7/1999', 88000, 'IV', 'RADNIK_OSTALI',2, 0692345678, 'jovana.markovic@gmail.com')
INSERT INTO radnici VALUES (11, 09079998202655, 'Milan', 'Andric', '9/7/1999', 95000, 'IV', 'RADNIK_OSTALI',1, 0631234567, 'milan.andric@gmail.com')
INSERT INTO radnici VALUES (13, 09079998202655, 'Dejan', 'Lazarevic', '9/7/1999', 95000, 'IV', 'RADNIK_OSTALI',null, 0631234567, 'dejan.lazarevic@gmail.com')
INSERT INTO radnici VALUES (14, 09079998202655, 'Dejan', 'Lazarevic', '9/7/1999', 95000, 'IV', 'RADNIK_OSTALI',null, 0631234567, 'dejan.lazarevic@gmail.com')
INSERT INTO radnici VALUES (19, 09079998202655, 'Dejan', 'Lazarevic', '9/7/1999', 95000, 'IV', 'RADNIK_OSTALI',null, 0631234567, 'dejan.lazarevic@gmail.com')

--INSERT INTO Faktura
INSERT INTO faktura
VALUES (1, 'Milos Milosevic', 'Vulkanizer', 5500, '2023-06-30', '2023-06-09', 5500, 'GOtovinsko placanje');
INSERT INTO faktura
VALUES (2, 'Ana Jankovic', 'Pranje Vozila', 7000, '2023-07-05', '2023-06-10', 7000, 'GOtovinsko placanje');
INSERT INTO faktura
VALUES (3, 'Autoskola Liman', 'Tehnicki pregled', 7000, '2023-07-05', '2023-06-10', 7000, 'putem racuna');
INSERT INTO faktura
VALUES (4, 'FTN', 'Vulkanizer', 4000, '2023-07-02', '2023-06-12', 4000, 'GOtovinsko placanje');
INSERT INTO faktura
VALUES (5, 'Kosta Sec', 'Pranje Vozila', 300, '2023-07-08', '2023-06-13', 6500, 'GOtovinsko placanje');
INSERT INTO faktura
VALUES (6, 'Autoskola C', 'Tehnički Pregled', 5000, '2023-07-15', '2023-06-14', 5000, 'putem racuna');
INSERT INTO faktura
VALUES (7, 'Crveni taxi', 'Vulkanizer', 7500, '2023-07-20', '2023-06-15', 7500, 'GOtovinsko placanje');
INSERT INTO faktura
VALUES (8, 'Tina TomASic', 'Pranje vozila', 300, '2023-07-12', '2023-06-16', 6000, 'GOtovinsko placanje');
INSERT INTO faktura
VALUES (9, 'FTN', 'Tehnički Pregled', 9500, '2023-07-18', '2023-06-17', 9500, 'putem racuna');
INSERT INTO faktura
VALUES (10, 'Meris Ugljanin', 'Pranje Vozila', 700, '2023-07-25', '2023-06-18', 7000, 'GOtovinsko placanje');

--INSERT INTO izvestaj
INSERT INTO izvestaj VALUES (1, '2/6/2023', 'Komentar 1', 'Napomena 1')
INSERT INTO izvestaj VALUES (2, '3/6/2023', 'Komentar 2', 'Napomena 2')
INSERT INTO izvestaj VALUES (3, '4/6/2023', 'Komentar 3', 'Napomena 3')
INSERT INTO izvestaj VALUES (4, '5/6/2023', 'Komentar 4', 'Napomena 4')
INSERT INTO izvestaj VALUES (5, '6/6/2023', 'Komentar 5', 'Napomena 5')
INSERT INTO izvestaj VALUES (6, '7/6/2023', 'Komentar 6', 'Napomena 6')
INSERT INTO izvestaj VALUES (7, '8/6/2023', 'Komentar 7', 'Napomena 7')
INSERT INTO izvestaj VALUES (8, '9/6/2023', 'Komentar 8', 'Napomena 8')
INSERT INTO izvestaj VALUES (9, '10/6/2023', 'Komentar 9', 'Napomena 9')

-	INSERT INTO licenca
INSERT INTO licenca VALUES (123, 'Licenca za obavljanje tehničkog pregleda nad putničkim vozilima', '2023-05-20', '2024-05-20', 'U Novom Sadu');
INSERT INTO licenca VALUES (234, 'Licenca za obavljanje tehničkog pregleda nad teretnim vozilima', '2023-08-20', '2024-08-20', 'U Beogradu');
INSERT INTO licenca VALUES (345, 'Licenca za obavljanje vulkanizerskih usluga', '2023-07-10', '2024-07-10', 'U Subotici');
INSERT INTO licenca VALUES (456, 'Licenca za obavljanje usluga pranja vozila', '2023-09-05', '2024-09-05', 'U Nišu');
INSERT INTO licenca VALUES (567, 'Licenca za obavljanje tehničkog pregleda nad motociklima', '2023-06-15', '2024-06-15', 'U Novom Sadu');
INSERT INTO licenca VALUES (678, 'Licenca za obavljanje usluga autoelektričara', '2023-10-30', '2024-10-30', 'U Beogradu');
INSERT INTO licenca VALUES (789, 'Licenca za obavljanje tehničkog pregleda nad autobusima', '2023-11-25', '2024-11-25', 'U Novom Sadu');
INSERT INTO licenca VALUES (890, 'Licenca za obavljanje usluga limarije', '2023-12-10', '2024-12-10', 'U Subotici');
INSERT INTO Llicenca VALUES (901, 'Licenca za obavljanje tehničkog pregleda nad prikolicama', '2023-07-05', '2024-07-05', 'U Beogradu');
INSERT INTO licenca VALUES (912, 'Licenca za obavljanje usluga autoelektrONike', '2023-09-15', '2024-09-15', 'U Beogradu');

--INSERT INTO Porudzbenica
INSERT INTO porudzbenica VALUES (10, 'SampON', 10, 5000);
INSERT INTO porudzbenica VALUES (15, 'Alat', 10, 10000);
INSERT INTO porudzbenica VALUES (20, 'Cetka', 5, 2000);
INSERT INTO porudzbenica VALUES (25, 'Elektronika', 2, 15000);
INSERT INTO porudzbenica VALUES (30, 'Gume', 8, 8000);
INSERT INTO porudzbenica VALUES (35, 'Monitor', 15, 30000);
INSERT INTO porudzbenica VALUES (40, 'Nameštaj', 3, 25000);
INSERT INTO porudzbenica VALUES (45, 'Kompresor', 6, 12000);
INSERT INTO porudzbenica VALUES (50, 'Farba', 12, 6000);
INSERT INTO porudzbenica VALUES (55, 'Električni aparati', 4, 18000);

--INSERT INTO Promocija
INSERT INTO promocija VALUES (1, 'Promocija 10% Tehnički pregled', '6/2/2023', '6/4/2023');
INSERT INTO promocija VALUES (2, 'Promocija 20% Vulkanizer', '7/10/2023', '7/15/2023');
INSERT INTO promocija VALUES (3, 'Promocija 15% Pranje vozila', '8/5/2023', '8/10/2023');
INSERT INTO promocija VALUES (4, 'Promocija 30% Zamena ulja', '9/1/2023', '9/7/2023');
INSERT INTO promocija VALUES (5, 'Promocija 25% Autoelektrika', '10/12/2023', '10/15/2023');
INSERT INTO promocija VALUES (6, 'Promocija 10% Automehanika', '11/8/2023', '11/12/2023');
INSERT INTO promocija VALUES (7, 'Promocija 20% AutoelektrONika', '12/5/2023', '12/10/2023');
INSERT INTO promocija VALUES (8, 'Promocija 15% Vulkanizer', '1/20/2024', '1/25/2024');
INSERT INTO promocija VALUES (9, 'Promocija 30% Tehnički pregled', '2/15/2024', '2/20/2024');
INSERT INTO promocija VALUES (10, 'Promocija 25% Pranje vozila', '3/10/2024', '3/15/2024');

--INSERT INTO zahtev
INSERT INTO zahtev VALUES (1, '6/10/2023');
INSERT INTO zahtev VALUES (2, '6/11/2023');
INSERT INTO zahtev VALUES (3, '6/12/2023');
INSERT INTO zahtev VALUES (4, '6/13/2023');
INSERT INTO zahtev VALUES (5, '6/14/2023');
INSERT INTO zahtev VALUES (6, '6/15/2023');
INSERT INTO zahtev VALUES (7, '6/16/2023');
INSERT INTO zahtev VALUES (8, '6/17/2023');
INSERT INTO zahtev VALUES (9, '6/18/2023');
INSERT INTO zahtev VALUES (10, '6/19/2023');

 
--INSERT INTO koraci_rn
INSERT INTO koraci_rn VALUES (1);
INSERT INTO koraci_rn VALUES (2);
INSERT INTO koraci_rn VALUES (3);
INSERT INTO koraci_rn VALUES (4);
INSERT INTO koraci_rn VALUES (6);
INSERT INTO koraci_rn VALUES (7);
INSERT INTO koraci_rn VALUES (8);
INSERT INTO koraci_rn VALUES (9);
INSERT INTO koraci_rn VALUES (10);
INSERT INTO koraci_rn VALUES (11);
INSERT INTO koraci_rn VALUES (12);

--INSERT INTO radni_nalog_za tp
INSERT INTO radni_nalog_za_tp VALUES (1);
INSERT INTO radni_nalog_za_tp VALUES (2);
INSERT INTO radni_nalog_za_tp VALUES (3);
INSERT INTO radni_nalog_za_tp VALUES (4);
INSERT INTO radni_nalog_za_tp VALUES (6);
INSERT INTO radni_nalog_za_tp VALUES (7);
INSERT INTO radni_nalog_za_tp VALUES (8);
INSERT INTO radni_nalog_za_tp VALUES (9);
INSERT INTO radni_nalog_za_tp VALUES (10);


4.	SQL upiti

/*1)   Izlistati podatke o radnicima koji su zaposleni na RADNIK_TEHNICKI kao: 
1.	ID radnika
2.	Ime i prezime
3.	Plata
za sve radnike cija je plata veca od plate radnika ciji je id_r=5. 
Ispis sortirati po opadajucem redosledu prezimena.*/

SELECT r.id_r AS "ID Radnika", r.ime+' '+r.prz AS "Ime i prezime", ISNULL(r.plata,0) AS "Plata", radno_mesto AS "Naziv radnog mesta"
FROM radnici r join  radnik_tehnicki rt ON (r.id_r=rt.id_r_tehnicki) 
WHERE plata > (SELECT plata FROM radnici WHERE id_r=15)
order BY r.prz desc;

/* 2)  Izlistati podatke o radnicima koji imaju sefa kao: 
1.	ID radnika 
2.	Ime i prezime radnika
3.	Plata
4.	Sef
*/

SELECT r.id_r AS 'ID radnika', r.prz+' '+r.ime AS 'Ime i prezime radnika', s.ime+' '+s.prz AS 'Ime i prezime sefa'
FROM radnici r join radnici s ON (r.sef=s.id_r)


 
-- 3) Izlistati ukupnu platu za sve radnike koji su Administratori
SELECT SUM(plata) AS "ukupna_plata"
FROM RADNICI
WHERE radno_mesto = 'RADNIK_ADMIN';

--4) Izlistati imena prezimena zaposlenih koji rade na radnim nalozim ciji su redni brojevi veci od 5
SELECT ime+' '+prz AS "Ime i prezime"
FROM radnici r join OBAVLJA_OSTALE_USLUGE ou ON (r.id_r=ou.id_r_ostali) 
WHERE rbr_krn>5

--5) Izlistati ukupan iznos koji kupci treba da plate GOtovinskim placanjem
SELECT sum(ukupan_iznos)
FROM FAKTURA
WHERE nacin_uplate='GOtovinsko placanje'

5.	T-SQL 
6.	Procedure

--PROCEDURE
/*1.) Procedura koja kao ulazni parametar ima radno mesto radnika i koja izlistava podatke o radniku sa zadatim radnim mestom u sledecoj FORmi:
a)
Radno mesto <radno_mesto> imaju sledeci radnici:

b)(lista u kursoru)
id_r, ime, prz, ukupan br radnika na tom radnom mestu

c) Ako nema podataka o tom radnom mestu ispisati gresku: Radno mesto ne postoji u bazi

*/


IF object_id('procedura_rm', 'p') is NOT NULL
    DROP PROCEDURE procedura_rm;
GO

CREATE PROCEDURE procedura_rm
    @radno_mesto VARCHAR(30)
AS
BEGIN
    DECLARE @br_radnika NUMERIC = (SELECT COUNT(id_r) FROM radnici WHERE radno_mesto = @radno_mesto);
    DECLARE @id_r NUMERIC, @ime VARCHAR(30), @prz VARCHAR(30), @brojac NUMERIC = 1;
    DECLARE @kursor_rm CURSOR;

    IF @radno_mesto not in ('radnik_admin', 'radnik_kONtrolor', 'radnik_ostali', 'radnik_tehnicki')
    BEGIN
        THROW 50001, 'ne postoji radno mesto u bazi. pokusati pONovo!', 0;
    END
    ELSE
    BEGIN
        PRINT('radno mesto ' + @radno_mesto + ' imaju sledeći radnici:');

        SET @kursor_rm = CURSOR FOR
        SELECT id_r, ime, prz
        FROM radnici
        WHERE radno_mesto = @radno_mesto;

        OPEN @kursor_rm;
        FETCH NEXT FROM @kursor_rm into @id_r, @ime, @prz;

        WHILE @@FETCH_status = 0
        BEGIN
            PRINT(cASt(@brojac AS VARCHAR) + '. ' + cASt(@id_r AS VARCHAR) + ' ' + @ime + ' ' + @prz);
            SET @brojac += 1;
            FETCH NEXT FROM @kursor_rm into @id_r, @ime, @prz;
        END;

        close @kursor_rm;
    END;
    
    DEALLOCATE @kursor_rm;
END;
GO


EXEC procedura_rm RADNIK_ADMIN
EXEC procedura_rm kdkd

/*2.) Procedura koja za prosleđen ID radnika (id_r) ispisuje podatke o radnicima kojima je ta osoba šef */

IF object_id('radnici_sefa', 'p') is NOT NULL
DROP PROCEDURE radnici_sefa;
GO
CREATE PROCEDURE radnici_sefa
@id_r NUMERIC
AS
DECLARE 
@imeprzsefa VARCHAR(60)=(SELECT ime+' '+prz FROM radnici WHERE id_r=@id_r),
@brradnika NUMERIC=(SELECT COUNT(id_r) FROM radnici WHERE sef=@id_r),
@brojac NUMERIC=1,
@imeradnika VARCHAR(30),
@przradnika VARCHAR(40),
@nazrmradnika VARCHAR(40);

DECLARE radnici_k CURSOR FOR
SELECT ime, prz, radno_mesto
FROM radnici 
WHERE sef=@id_r;
BEGIN
IF @id_r not in (SELECT id_r FROM radnici)
	BEGIN
		;THROW 50001, 'Ne postoji radnik sa ovim ID u bazi!', 0;
	END;
ELSE IF @brradnika=0
	BEGIN
		PRINT(@imeprzsefa+' nije nikome sef.');
	END;
ELSE
	BEGIN
	PRINT(@imeprzsefa+' je sef sledecim radnicima:');
	OPEN radnici_k;
	FETCH NEXT FROM radnici_k into @imeradnika, @przradnika, @nazrmradnika
	WHILE @@FETCH_STATUS=0
		BEGIN
			PRINT(cASt(@brojac AS VARCHAR)+' .'+@imeradnika+' '+@przradnika+' radi na radnom mestu '+@nazrmradnika+'. ')
			SET @brojac+=1
			FETCH NEXT FROM radnici_k into @imeradnika, @przradnika,  @nazrmradnika;
		END;
	CLOSE radnici_k;
	PRINT('Ukupno radnika: '+cASt(@brradnika AS VARCHAR));
	END;
END;
DEALLOCATE radnici_k;
GO

EXEC radnici_sefa 1

7.	Trigeri
--1. Triger
--Upisuje vrednosti ključeva iz superklASe IS-a hijerarhije u odGOvarajuće potklASe
IF object_id('trg_insert_radnik','tr') is NOT NULL
DROP TRIGGER trg_insert_radnik
GO
CREATE TRIGGER trg_insert_radnik
ON RADNICI
AFTER INSERT
AS
BEGIN
   

    DECLARE @radno_mesto VARCHAR(50);
    DECLARE @id_r INT;

    SELECT @radno_mesto = radno_mesto, @id_r = id_r
    FROM inserted;

    IF @radno_mesto = 'RADNIK_TEHNICKI'
    BEGIN
        INSERT INTO RADNIK_TEHNICKI (id_r_tehnicki)
        VALUES (@id_r);
    END
    ELSE IF @radno_mesto = 'RADNIK_OSTALI'
    BEGIN
        INSERT INTO RADNIK_OSTALI (id_r_ostali)
        VALUES (@id_r);
    END
    ELSE IF @radno_mesto = 'RADNIK_ADMIN'
    BEGIN
        INSERT INTO RADNIK_ADMIN (id_r_admin)
        VALUES (@id_r);
    END
	  ELSE IF @radno_mesto = 'RADNIK_KONTROLOR'
    BEGIN
        INSERT INTO RADNIK_KONTROLOR (id_r_kONtrolor)
        VALUES (@id_r);
    END
END;

--DRUGI TRIGER ZA POSTAVLJANJE šEFA
--Šef ne moze da bude sef za vise od 5 radnika

IF object_id('trg_sef', 'tr') is NOT NULL
DROP TRIGGER trg_sef;
GO
CREATE TRIGGER trg_sef 
ON radnici
AFTER INSERT, upDATE
AS
DECLARE
@brrad NUMERIC=(SELECT COUNT(id_r) FROM radnici WHERE sef=(SELECT sef FROM inserted));
BEGIN
IF @brrad>5
	BEGIN
		;THROW 50000, 'Sef moze imati najvise 5 podredjenih radnika', 0;
	END;
END;
GO

8.	Funkcije
--1. Funkcija
--Vraća e-mail radnika za njegov prosledjen ID

IF object_id('email_r', 'fn') is NOT NULL
DROP FUNCTION email_r;
GO
CREATE FUNCTION email_r 
(@id_r  NUMERIC)
RETURNs VARCHAR(30)
AS
BEGIN
DECLARE @email VARCHAR(30)=(SELECT email FROM radnici WHERE id_r=@id_r);
RETURN (@email)
END;
GO

SELECT dbo.email_r(1)
GO

 
--2.Funkcija u kombinaciji sa DML-om
--Funkcija vraca ukupan iznos usluge uvecan za 20% odnosno racuna pdv
IF object_id('ukupanIznos20posto', 'fn') is NOT NULL
DROP FUNCTION ukupanIznos20posto;
GO
CREATE FUNCTION  ukupanIznos20posto (@ukupan_iznos NUMERIC)
RETURNs NUMERIC
AS
BEGIN
RETURN(@ukupan_iznos*1.2);
END;
GO

INSERT INTO faktura VALUES ('15','Jovan Jovanovic','Tehnicki pregled',7000,'10/6/2023','4/6/2023',dbo.ukupanIznos20posto(7000), 'GOtovinsko placanje')
