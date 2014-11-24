/*
Author : Olivier NICOLE
Creation date : 17.11.2014
Description : Module SQL2 project for TCC (Tennis Club Chavornay)

Table creation example
CREATE TABLE tblname
(
	id int IDENTITY(1,1),
	other varchar(255),
);
GO
*/

USE master
GO

--Force delete database if exist
IF EXISTS(select * from sys.databases where name='TCCONE')
BEGIN
	ALTER DATABASE TCCONE SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TCCONE
END
GO

CREATE DATABASE TCCONE
GO

USE TCCONE
GO

--Tables creation
CREATE TABLE persons
(
	idPerson int IDENTITY(1,1),
	firstname varchar(255) NOT NULL,
	lastname varchar(255) NOT NULL,
	address varchar(255),
	phone text,
	mail varchar(255),
	creationDate datetime,
	disabledDate datetime,
	checkInformations bit,
	invitationRight bit,
	validated bit,
	PRIMARY KEY(idPerson)
);
GO

CREATE TABLE roles
(
	idRole int IDENTITY(1,1),
	name varchar(255),
	PRIMARY KEY(idRole)
);
GO

CREATE TABLE credentials
(
	idCredential int IDENTITY(1,1),
	login varchar(255) UNIQUE,
	password varchar(255),
	fkRole int,
	fkPerson int,
	PRIMARY KEY(idCredential),
	FOREIGN KEY(fkRole) REFERENCES roles(idRole) ON DELETE SET NULL,
	FOREIGN KEY(fkPerson) REFERENCES persons(idPerson)
);
GO

CREATE TABLE courts
(
	idCourt int IDENTITY(1,1),
	maxDureationBeforeBookingDuration int,
	comment text,
	PRIMARY KEY(idCourt)
);
GO

CREATE TABLE bookings
(
	idBooking int IDENTITY(1,1),
	startDate datetime CHECK ((startDate > GETDATE()) AND ((datepart(month,startDate)-datepart(month,GETDATE()))<1)),
	endDate datetime CHECK ((endDate > GETDATE()) AND ((datepart(month,endDate)-datepart(month,GETDATE()))<1)),
	fkCourt int,
	fkPerson int,
	recurrence varchar(10) NOT NULL CHECK (recurrence IN('aucune','quotidienne','hebdomadaire','mensuelle')) --It's like an ENUM type in MYSQL
	PRIMARY KEY(idBooking),
	FOREIGN KEY(fkCourt) REFERENCES courts(idCourt),
	FOREIGN KEY(fkPerson) REFERENCES persons(idPerson)
);
GO

CREATE TABLE participants
(
	idParticipant int IDENTITY(1,1),
	fkPerson int,
	fkBooking int,
	PRIMARY KEY(idParticipant),
	FOREIGN KEY(fkPerson) REFERENCES persons(idPerson),
	FOREIGN KEY(fkBooking) REFERENCES bookings(idBooking)
);
GO

CREATE TABLE configs
(
	idConfig int IDENTITY(1,1),
	value varchar(255),
	PRIMARY KEY(idConfig)
);
GO

/*
	Generated by http://generatedata.com/
*/
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Sean','Sims','Ap #401-1340 Nisi. St.','01 49 65 59 10','ipsum.ac@Phasellusat.com','2014-06-21 19:52:51',1,1,1),('Slade','Figueroa','P.O. Box 787, 6762 Ultrices. Rd.','01 58 62 47 97','arcu.Aliquam.ultrices@anuncIn.ca','2014-07-01 15:42:55',1,1,1),('Yuli','Grimes','P.O. Box 545, 9234 Euismod St.','05 87 61 19 57','amet.consectetuer.adipiscing@necmetusfacilisis.com','2014-12-06 21:41:32',1,1,1),('Ronan','Berry','Ap #416-4800 Eget Ave','04 08 40 73 24','semper@ornarefacilisiseget.edu','2014-04-03 01:19:33',1,1,1),('Ezra','Jacobson','P.O. Box 408, 5648 Condimentum. St.','03 73 83 74 60','sed@tellussemmollis.edu','2015-05-24 15:25:28',1,1,1),('Silas','Ramsey','2897 Sed Rd.','07 97 23 69 41','ullamcorper.Duis@nec.net','2014-10-17 14:56:32',1,1,1),('Neville','Alvarez','Ap #989-3833 Neque St.','01 28 32 41 43','cursus.et@Vivamuseuismod.org','2015-10-10 23:39:52',1,1,1),('Quamar','Mcdaniel','Ap #232-9017 Ornare Ave','01 27 66 46 68','eu@adipiscing.org','2014-10-29 04:45:07',1,1,1),('Clark','Hodge','P.O. Box 668, 793 Elit, Av.','05 49 42 68 21','volutpat.ornare.facilisis@vulputatemauris.org','2015-03-15 14:29:23',1,1,1),('Daniel','Peterson','Ap #857-3590 Ante Av.','07 49 52 80 55','risus.Morbi@placerataugue.co.uk','2015-07-13 00:29:31',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Kibo','Buckner','6591 Metus. St.','04 70 94 38 92','sed.dui@Vestibulumanteipsum.org','2015-07-18 06:08:53',1,1,1),('Fritz','Brennan','181-8210 In Av.','09 24 15 93 94','magna@amet.edu','2015-09-12 14:19:49',1,1,1),('Jermaine','Montoya','Ap #949-541 Nunc Rd.','02 18 46 16 72','mattis.ornare.lectus@Maurisvel.edu','2013-12-16 17:05:14',1,1,1),('Valentine','Ortiz','4965 Nec, Street','02 87 42 99 70','Nulla.facilisis.Suspendisse@orciPhasellus.edu','2015-04-14 08:11:20',1,1,1),('Melvin','Casey','247-5057 Dui Rd.','02 00 33 29 21','ac.mattis.velit@pellentesquemassa.org','2014-02-11 07:28:42',1,1,1),('Malik','Wong','Ap #926-1332 Lectus St.','08 95 58 99 53','In@eueleifend.co.uk','2014-09-07 09:07:32',1,1,1),('Hammett','Benson','8223 Quam Road','07 45 44 87 47','et.netus@Nulla.net','2014-07-23 12:11:14',1,1,1),('Ivor','Anthony','P.O. Box 458, 8782 Lacus. Rd.','09 95 03 35 03','congue@urnajustofaucibus.net','2014-09-29 16:17:44',1,1,1),('Jesse','Parsons','793-3353 Aliquam Rd.','07 38 81 20 15','Aliquam.erat.volutpat@tellusSuspendissesed.edu','2014-02-27 06:29:19',1,1,1),('Wayne','Terry','P.O. Box 603, 4843 Sed Avenue','04 26 18 56 40','ornare.libero.at@purusgravidasagittis.org','2014-07-23 17:25:53',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Todd','Wiggins','821-3857 Vel Road','05 43 89 95 88','sem.Nulla.interdum@facilisisnon.com','2015-11-19 22:39:41',1,1,1),('Gary','Alvarado','P.O. Box 604, 6509 Consectetuer St.','05 06 62 41 50','per.conubia@nibhPhasellusnulla.com','2014-12-10 01:36:46',1,1,1),('Abraham','Silva','Ap #834-2030 Curabitur Rd.','05 21 91 74 95','ante@urnanec.net','2014-05-05 22:20:49',1,1,1),('Kato','Deleon','P.O. Box 164, 3628 Mi. Av.','06 18 00 46 12','neque.et@Duis.com','2015-09-22 12:43:35',1,1,1),('Brenden','Haley','P.O. Box 850, 6214 Tellus St.','09 67 67 84 95','facilisi.Sed@tinciduntnibh.org','2015-04-20 08:30:05',1,1,1),('Logan','Tucker','5866 Lectus St.','02 30 06 11 19','gravida@Quisque.net','2014-04-17 07:53:48',1,1,1),('Colby','Barnes','Ap #782-7407 Integer St.','09 94 78 27 59','consequat.auctor@sitamet.edu','2014-11-21 13:05:17',1,1,1),('Gary','Franco','Ap #436-8156 Sit Road','04 24 06 92 09','Suspendisse.sed.dolor@Cras.ca','2015-08-31 05:20:08',1,1,1),('Boris','Vargas','Ap #751-198 Curae; Rd.','09 50 88 67 89','placerat@etmagnaPraesent.co.uk','2015-03-04 22:10:20',1,1,1),('Kareem','Wolfe','602-4525 Et Av.','08 96 11 47 76','Nunc.lectus.pede@erategettincidunt.edu','2014-04-06 18:20:18',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Lamar','Tate','Ap #394-1590 Cras Av.','07 86 50 56 51','Aliquam.ornare.libero@sitametnulla.ca','2014-12-28 20:53:15',1,1,1),('Brent','Shepard','P.O. Box 255, 4981 Aliquam Avenue','09 58 71 22 21','Donec.nibh@neque.com','2015-08-20 02:24:23',1,1,1),('Bruno','Romero','P.O. Box 389, 6411 Elit Avenue','03 23 64 70 49','Donec@semmollis.org','2014-04-05 03:11:21',1,1,1),('Harper','Salazar','P.O. Box 475, 1841 Feugiat Avenue','09 24 21 17 64','Fusce.aliquet@Maecenas.org','2014-05-10 08:53:22',1,1,1),('Thaddeus','Becker','Ap #310-6424 Est Rd.','03 33 27 80 48','Cras.eu@infaucibusorci.edu','2014-01-06 23:32:19',1,1,1),('Elmo','Ochoa','P.O. Box 519, 3903 Viverra. St.','03 43 38 32 36','ut@seddolorFusce.co.uk','2014-12-31 10:37:37',1,1,1),('Leroy','Santos','Ap #395-1380 Eleifend Avenue','09 28 08 24 77','Ut.semper@conubianostra.ca','2015-01-03 23:09:21',1,1,1),('Benjamin','Oneil','P.O. Box 624, 411 Et Road','01 11 10 08 96','Vestibulum@magnisdisparturient.com','2015-02-15 17:16:36',1,1,1),('Hakeem','Foreman','P.O. Box 636, 7517 Et St.','09 41 21 08 67','tellus.faucibus.leo@egestasligula.net','2015-03-24 08:57:01',1,1,1),('Burke','Jacobson','P.O. Box 909, 5506 Libero. St.','07 08 81 70 73','arcu@Nuncquisarcu.ca','2014-01-27 19:56:48',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Dexter','Barron','178-7154 Nonummy Avenue','01 16 83 16 03','Curabitur.massa@pharetra.com','2015-09-20 09:43:22',1,1,1),('Julian','Hinton','838-6611 Interdum. Ave','06 55 32 88 02','nulla.magna@odioPhasellus.org','2014-09-28 07:46:27',1,1,1),('Seth','Maldonado','1813 Pellentesque St.','09 08 37 71 81','fringilla.Donec.feugiat@convallisligula.org','2014-12-06 15:20:20',1,1,1),('Calvin','Greene','6549 Sollicitudin St.','09 55 60 14 14','malesuada@magna.net','2014-09-25 05:41:52',1,1,1),('Silas','Molina','P.O. Box 239, 326 Pharetra. Rd.','05 57 13 27 59','eget.odio@inlobortistellus.org','2014-01-16 10:09:19',1,1,1),('Stewart','Bailey','P.O. Box 538, 4390 Luctus St.','01 28 96 05 12','magna.Nam@etipsum.ca','2013-12-15 20:28:35',1,1,1),('Jerome','Bird','P.O. Box 841, 332 Placerat. St.','02 90 72 94 70','in.aliquet@loremtristiquealiquet.edu','2015-03-12 22:14:33',1,1,1),('Carter','Maldonado','P.O. Box 416, 7063 Tincidunt St.','03 36 06 98 92','quam.vel@semNulla.edu','2014-03-15 13:34:21',1,1,1),('Jeremy','Vargas','P.O. Box 366, 9189 Pede, Avenue','08 45 11 78 34','non.feugiat.nec@vel.com','2015-10-30 18:21:39',1,1,1),('Hector','Blair','Ap #857-7384 Sagittis Avenue','04 18 59 05 76','dui.semper.et@acfeugiatnon.edu','2015-10-25 20:06:00',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Cole','Boyle','910-7845 Mollis. St.','04 63 93 70 73','nisi@Sedneque.net','2014-02-17 12:34:15',1,1,1),('Adam','Patel','P.O. Box 849, 9609 Integer St.','02 57 09 99 53','eu.lacus@at.ca','2015-03-29 05:33:28',1,1,1),('Gannon','Rasmussen','Ap #515-1441 Lectus Av.','01 15 04 90 90','ut.odio.vel@duilectus.co.uk','2014-11-14 14:36:45',1,1,1),('Theodore','Obrien','906-4920 Eget Avenue','03 59 98 20 07','purus@aauctornon.org','2015-04-27 22:27:03',1,1,1),('Trevor','Leblanc','P.O. Box 620, 9840 Nulla. Road','02 72 25 07 58','dignissim.pharetra.Nam@augue.net','2014-08-02 09:21:42',1,1,1),('Steel','James','Ap #429-2570 Vitae, Ave','09 41 01 50 67','lorem.fringilla@Nunclectuspede.co.uk','2015-09-03 11:22:47',1,1,1),('Clinton','Slater','2298 Volutpat Rd.','01 27 96 48 53','rutrum.magna@erat.com','2015-03-08 01:19:52',1,1,1),('Oren','Bailey','7883 Dolor Rd.','04 50 58 69 08','a.odio.semper@penatibuset.com','2014-08-03 01:18:05',1,1,1),('Noah','Gray','1632 Nulla Rd.','06 57 23 41 47','eu@Inmi.edu','2014-04-26 09:58:31',1,1,1),('Russell','Maynard','180-6575 Ut, Ave','04 42 11 60 78','dictum.eu.placerat@pedeSuspendissedui.ca','2015-02-08 16:46:10',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Armand','Turner','828-6819 Eu Rd.','07 95 77 52 35','ipsum@eratvitaerisus.net','2015-10-24 03:46:18',1,1,1),('Chaney','Galloway','3415 Erat St.','03 45 98 08 31','elit@estcongue.net','2014-08-10 10:53:09',1,1,1),('Camden','Chaney','2263 Rutrum Street','09 68 51 12 90','eu@placeratCras.com','2015-03-18 00:01:11',1,1,1),('Arsenio','Wooten','521-9401 Orci. St.','07 90 26 37 21','a.mi.fringilla@dui.edu','2015-01-14 13:41:32',1,1,1),('Mannix','Moses','P.O. Box 188, 9312 Interdum. Rd.','09 93 88 68 26','faucibus.orci@nisi.com','2015-10-02 00:38:32',1,1,1),('Leonard','Lane','812-2730 Diam. St.','01 95 05 28 93','amet.diam.eu@sempercursusInteger.com','2014-04-19 09:19:09',1,1,1),('Oleg','Gates','381-6397 Molestie Road','08 10 11 04 55','enim@nulla.net','2015-02-13 05:58:29',1,1,1),('Quamar','Castro','Ap #836-4184 Magna St.','08 09 51 23 40','ac@scelerisque.org','2015-08-13 08:06:01',1,1,1),('Hayes','Foreman','417-3396 Amet Avenue','09 38 05 84 42','mattis.Cras.eget@egestasascelerisque.co.uk','2015-09-23 11:15:10',1,1,1),('Emerson','Juarez','Ap #850-5472 Non Rd.','06 74 37 47 59','dui.Fusce@iaculisodio.edu','2015-10-03 07:20:30',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Dennis','Orr','Ap #491-1815 Vel Rd.','03 61 91 07 96','felis@velitdui.edu','2015-10-07 09:55:59',1,1,1),('Tanek','Riggs','775-6702 Nullam Road','02 47 50 09 06','Praesent@urna.org','2015-03-11 08:03:12',1,1,1),('Xanthus','Frazier','877-8456 Felis Av.','02 14 71 01 78','Nullam.enim.Sed@Duisatlacus.edu','2015-04-08 08:39:27',1,1,1),('Aquila','Rowland','943-6745 Sed St.','01 99 54 78 16','In.mi.pede@mollisduiin.com','2015-09-22 14:24:31',1,1,1),('Judah','Bates','Ap #258-9528 Turpis Rd.','05 50 09 39 19','egestas.hendrerit.neque@Proinsedturpis.com','2015-04-10 18:36:41',1,1,1),('Yardley','Ratliff','P.O. Box 898, 8127 Ipsum. Avenue','03 86 47 23 12','turpis.Nulla@scelerisqueneque.com','2014-05-03 05:38:56',1,1,1),('Lev','Baker','444-7495 Condimentum. Avenue','08 01 35 35 72','dapibus@vehicula.edu','2015-09-29 05:08:33',1,1,1),('Jerry','Ortega','2911 Suspendisse Street','07 66 08 84 12','Donec@nislelementum.co.uk','2015-10-01 17:47:59',1,1,1),('Jermaine','Steele','9808 Pellentesque Avenue','03 84 43 50 95','Sed@Suspendissesed.edu','2013-12-25 18:41:07',1,1,1),('Nicholas','Guerra','P.O. Box 934, 2877 Nec St.','08 40 95 29 47','Cum@ipsum.co.uk','2014-05-12 01:47:05',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Theodore','Santiago','P.O. Box 865, 385 Semper St.','02 76 92 81 35','augue.ut@natoquepenatibuset.com','2014-05-17 10:47:57',1,1,1),('Thaddeus','Steele','9435 Ipsum Rd.','04 42 26 42 85','neque.tellus@ornareFusce.edu','2014-07-17 00:31:19',1,1,1),('Keaton','Mcfarland','990-3031 Egestas. Avenue','04 35 23 72 02','et@atnisi.net','2015-10-19 11:05:49',1,1,1),('Owen','Sanchez','P.O. Box 634, 6805 Ipsum. Road','08 97 51 04 69','turpis.nec.mauris@imperdiet.edu','2015-07-25 11:36:29',1,1,1),('Judah','Talley','329-5569 Duis Rd.','03 07 87 38 35','molestie.tellus.Aenean@eleifendCrassed.org','2015-10-03 13:05:07',1,1,1),('Nash','Dalton','571-5571 Nec, St.','09 94 84 79 66','nunc.sed.libero@diamloremauctor.edu','2015-05-25 05:53:49',1,1,1),('Jacob','Meyer','Ap #950-5196 Lectus Street','07 57 96 84 27','consectetuer.ipsum@nasceturridiculus.edu','2015-02-27 21:00:35',1,1,1),('Drake','Turner','3001 A, Rd.','08 21 84 41 63','pellentesque@orciPhasellusdapibus.net','2015-10-09 02:38:42',1,1,1),('Felix','Chavez','Ap #593-6712 Lectus. Rd.','03 27 92 01 59','gravida@sed.co.uk','2014-05-20 00:58:30',1,1,1),('Porter','Melton','Ap #384-1347 Est. Av.','08 89 88 93 94','purus.ac.tellus@inhendrerit.net','2015-09-25 13:15:24',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Leo','Noel','Ap #639-8066 Hymenaeos. Avenue','06 72 76 30 62','aptent@commodohendrerit.co.uk','2014-06-16 10:49:10',1,1,1),('Richard','Hull','Ap #458-5966 Ut Road','07 28 53 83 52','tellus@turpisIn.com','2014-07-30 02:39:08',1,1,1),('Kasimir','Martin','4659 Eget Avenue','05 83 82 75 30','laoreet.ipsum@rhoncusProinnisl.co.uk','2015-04-09 01:59:58',1,1,1),('Zane','Hill','Ap #795-3483 Mi Rd.','02 49 02 09 51','tincidunt@disparturient.edu','2015-04-11 17:18:21',1,1,1),('Harlan','Tyler','P.O. Box 268, 5117 Est. Ave','04 40 70 83 97','elit.Etiam@elit.org','2014-08-31 04:57:40',1,1,1),('Uriel','Clarke','6949 Pede. Av.','08 11 07 71 22','feugiat.nec.diam@metusAeneansed.com','2015-01-25 12:28:39',1,1,1),('Lance','Gardner','799-7202 Donec Av.','07 15 36 82 46','magnis.dis.parturient@sollicitudinadipiscing.co.uk','2015-01-01 06:11:28',1,1,1),('Alden','Bowen','Ap #693-8374 Maecenas Street','07 59 48 77 00','neque.sed.sem@Nullasemper.org','2014-10-15 19:20:41',1,1,1),('Allen','Hendricks','481-9009 Vestibulum Avenue','02 07 11 97 31','dictum.eu@aliquetPhasellusfermentum.net','2014-02-02 18:15:49',1,1,1),('Price','Travis','643-3033 Libero Av.','04 33 96 13 88','justo.faucibus@eu.net','2015-01-26 17:35:27',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Quinlan','Briggs','P.O. Box 802, 1409 Mauris, Rd.','07 03 00 13 13','dapibus.ligula.Aliquam@anteblandit.com','2014-04-14 12:51:41',1,1,1),('Vaughan','Zimmerman','P.O. Box 603, 6671 Magna. Avenue','09 28 24 24 61','nec@Maecenasliberoest.net','2015-05-14 00:02:03',1,1,1),('Leonard','Norton','P.O. Box 431, 882 Ipsum St.','09 12 73 26 43','eleifend.non@gravida.org','2014-04-01 22:27:35',1,1,1),('Ulric','Lowery','Ap #898-2460 Arcu. St.','04 28 98 23 51','malesuada@maurisanunc.edu','2015-02-26 16:00:57',1,1,1),('Eric','Mcdaniel','7663 Hendrerit Rd.','06 29 38 72 54','iaculis.aliquet.diam@tellus.net','2015-06-21 06:07:44',1,1,1),('Cain','Rivas','Ap #975-1441 Vel, Rd.','05 68 05 31 61','viverra.Donec.tempus@egestasAliquamnec.ca','2014-10-24 00:01:01',1,1,1),('Slade','Lindsay','P.O. Box 502, 2151 In St.','02 85 96 87 00','Donec.tempus.lorem@necante.ca','2014-03-19 22:29:00',1,1,1),('Harding','Boone','4874 Netus Road','02 17 53 46 44','conubia.nostra@mi.ca','2015-08-28 23:50:05',1,1,1),('Malachi','Wilkinson','564-8466 A Av.','05 64 12 51 91','tellus.sem.mollis@lorem.org','2015-05-27 15:29:24',1,1,1),('Galvin','Hall','3432 Non, Av.','04 19 03 98 23','justo.eu.arcu@Nunc.ca','2015-06-02 18:39:45',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Raymond','Boyer','Ap #658-4613 Est Rd.','06 52 27 10 99','eget@tincidunt.net','2014-01-07 15:18:46',1,1,1),('Brent','Howe','8020 Diam St.','02 17 33 86 01','Ut.tincidunt.vehicula@duiin.net','2014-01-30 10:37:33',1,1,1),('Ray','Gilliam','Ap #729-3910 Malesuada St.','05 28 01 75 52','Phasellus.fermentum.convallis@eget.edu','2014-03-22 07:40:52',1,1,1),('Dylan','Roberts','Ap #736-7635 Purus, St.','08 19 81 18 92','ipsum.non@inconsectetueripsum.net','2014-05-09 16:19:00',1,1,1),('Evan','Perez','902-3825 Justo Road','07 86 74 49 97','Quisque@diam.ca','2014-12-28 14:12:38',1,1,1),('Elton','Erickson','2732 Nec, Avenue','02 89 44 57 95','eleifend@amet.net','2015-05-26 00:16:02',1,1,1),('Malachi','Jacobson','898-3179 Justo St.','09 07 09 27 00','Nunc@tellusjustosit.net','2014-07-07 22:10:53',1,1,1),('Alden','Barber','P.O. Box 136, 6246 Condimentum St.','09 96 58 98 02','lacus.Mauris@nibhlaciniaorci.co.uk','2013-12-11 07:13:37',1,1,1),('Merritt','Reese','Ap #756-2045 Vitae St.','01 02 78 11 31','lectus.pede@elitNulla.org','2014-06-18 15:03:27',1,1,1),('Ira','Henderson','P.O. Box 663, 4305 Libero Street','01 97 83 18 67','Morbi.vehicula.Pellentesque@nequeMorbiquis.com','2014-12-17 22:49:46',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Walter','Nunez','P.O. Box 614, 1174 Montes, Rd.','05 00 64 36 39','interdum.Sed@ornareFusce.ca','2015-05-09 12:09:00',1,1,1),('Denton','Mcfadden','8250 Feugiat. St.','08 16 72 92 46','fringilla@cursuspurus.co.uk','2015-04-10 11:58:59',1,1,1),('Derek','Lindsay','7250 Id, Avenue','07 37 09 91 86','cursus@liberoettristique.com','2015-08-17 13:20:34',1,1,1),('Harlan','Booth','Ap #886-5419 Tellus. Ave','05 40 36 49 99','ullamcorper@blandit.co.uk','2015-03-10 04:55:55',1,1,1),('Kasimir','Kramer','P.O. Box 883, 9726 Venenatis Avenue','02 39 31 48 57','mi.pede@MorbimetusVivamus.edu','2015-09-04 12:35:20',1,1,1),('Raymond','Cooke','Ap #801-8171 Eget St.','03 97 03 02 17','neque@tellusNunc.co.uk','2015-05-09 20:48:52',1,1,1),('Deacon','Weaver','355-1128 Et, Ave','02 75 76 10 79','mi@sapien.org','2014-07-01 19:22:41',1,1,1),('Kato','Patel','6101 Erat Ave','09 82 83 83 11','facilisis@vehiculaetrutrum.ca','2014-09-03 02:27:45',1,1,1),('George','Drake','277-1998 Egestas. St.','05 15 11 27 53','nisl.Quisque@odiosagittissemper.com','2015-06-27 04:40:15',1,1,1),('Kieran','Cervantes','9986 Congue St.','07 17 24 66 65','sodales.Mauris@tristique.org','2015-11-06 09:51:59',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Tate','Morin','745-7447 Tristique Avenue','04 48 75 05 02','varius.Nam.porttitor@ipsumdolorsit.ca','2014-02-10 12:23:54',1,1,1),('Philip','Gillespie','521-6288 Cras Rd.','06 52 12 99 88','magna.Nam.ligula@vitae.co.uk','2015-04-05 20:07:04',1,1,1),('Octavius','Chan','P.O. Box 178, 1831 Tincidunt Rd.','05 74 19 15 78','aliquam.arcu@Nullamscelerisque.co.uk','2014-08-25 19:44:51',1,1,1),('Macon','Lee','P.O. Box 922, 6349 Etiam Rd.','03 28 52 17 66','tempor.augue@eratvelpede.co.uk','2015-11-11 03:10:57',1,1,1),('Quinlan','Parks','P.O. Box 809, 7760 Vestibulum. Street','07 00 74 00 15','parturient@purus.org','2015-11-08 22:25:28',1,1,1),('Plato','Humphrey','P.O. Box 584, 1094 Pellentesque Avenue','02 63 05 45 79','sem.Pellentesque.ut@Integersemelit.net','2013-12-27 00:50:25',1,1,1),('Paki','Ross','261 Porttitor Avenue','08 76 09 98 95','vitae@auctorquistristique.co.uk','2015-04-08 05:35:39',1,1,1),('Bradley','Simpson','Ap #380-2157 Feugiat Ave','09 85 80 74 61','accumsan.interdum@sodalespurusin.edu','2014-07-21 23:01:47',1,1,1),('Kamal','Alexander','5496 Donec Avenue','02 22 79 37 92','hymenaeos.Mauris.ut@Sed.ca','2014-04-01 11:14:03',1,1,1),('Basil','Perry','Ap #325-4726 Dictum Rd.','08 54 07 18 09','in@egetnisi.net','2015-09-21 10:19:01',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Oliver','Ryan','Ap #436-1081 Varius Ave','09 77 96 21 44','elit@orcisem.org','2014-07-31 15:08:51',1,1,1),('Jackson','Hines','236-5484 Elementum, Ave','02 10 77 34 88','nunc.ullamcorper@Pellentesquehabitant.net','2015-08-26 00:02:18',1,1,1),('Marvin','Small','Ap #819-5433 Ligula. Ave','07 69 61 04 50','sem.eget.massa@convallisestvitae.ca','2015-05-13 00:30:45',1,1,1),('Linus','Ferrell','8533 A Street','07 88 40 47 29','suscipit@ac.net','2014-03-08 12:34:13',1,1,1),('Otto','Molina','5637 At Ave','06 08 87 68 06','ultrices@Donectincidunt.ca','2015-10-31 14:20:22',1,1,1),('Burke','Tucker','2188 Lacinia. Rd.','06 65 02 98 29','sem.Pellentesque@eget.edu','2015-06-20 13:12:05',1,1,1),('Colin','Gallagher','6217 Dictum St.','05 21 47 85 62','luctus@semperNam.org','2015-04-05 05:36:43',1,1,1),('Yardley','Vaughn','P.O. Box 310, 4366 Risus. St.','02 16 46 81 46','convallis@etnetuset.org','2014-01-24 07:54:02',1,1,1),('Grady','Stokes','3369 Fusce Street','04 69 24 01 28','imperdiet.dictum.magna@euneque.co.uk','2014-12-20 13:02:45',1,1,1),('Brenden','Clemons','114-5657 Integer Av.','04 96 81 07 14','tempus.lorem.fringilla@egetnisidictum.org','2015-04-19 11:43:41',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Randall','Montgomery','2924 Nunc. Rd.','06 89 25 40 79','lacus.varius@scelerisqueloremipsum.co.uk','2013-11-30 17:29:55',1,1,1),('Cullen','Boyle','P.O. Box 205, 9079 Non Ave','07 85 98 05 99','Nunc@nislNullaeu.edu','2014-09-03 18:16:23',1,1,1),('Merritt','Ratliff','Ap #373-2995 Scelerisque Ave','03 30 53 51 43','non@tellus.com','2014-08-17 01:18:52',1,1,1),('Jackson','Riggs','P.O. Box 337, 7746 Sapien. Road','01 31 37 85 83','magnis.dis@mauriselitdictum.edu','2015-09-19 14:48:57',1,1,1),('Brendan','Craft','P.O. Box 856, 1289 Mauris Street','06 08 50 15 60','Ut.semper@neque.org','2014-01-16 10:13:11',1,1,1),('Grady','Lloyd','P.O. Box 502, 3200 Arcu. Road','07 20 63 09 97','dictum.eu.eleifend@fringillaporttitor.com','2015-06-24 19:05:11',1,1,1),('Kane','Alvarado','284-7638 Parturient Rd.','07 04 66 20 88','vel.convallis.in@iderat.net','2014-03-15 08:56:32',1,1,1),('Amos','Brennan','Ap #373-9483 Vulputate, Street','06 98 01 80 67','Quisque.imperdiet.erat@Maurisut.co.uk','2013-12-01 05:19:58',1,1,1),('Cairo','Soto','P.O. Box 788, 2772 Sem Ave','03 00 49 28 06','non@dapibusrutrum.net','2014-03-27 20:28:52',1,1,1),('Jarrod','Bray','P.O. Box 232, 8239 Tincidunt Rd.','01 10 18 90 05','Integer@vestibulum.net','2015-02-09 23:11:45',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Anthony','Bender','Ap #170-6350 Primis Av.','08 50 11 64 41','interdum@aliquamadipiscing.edu','2015-05-09 10:34:56',1,1,1),('Cairo','Tran','728-5071 Scelerisque Rd.','01 33 53 25 30','eget.laoreet.posuere@Pellentesquehabitantmorbi.org','2014-01-17 11:07:02',1,1,1),('Cullen','Humphrey','1259 Semper Rd.','03 67 17 29 04','tincidunt@ipsumportaelit.org','2015-07-22 22:24:20',1,1,1),('Logan','Beasley','Ap #132-9829 Litora Ave','03 23 10 06 47','imperdiet.ornare.In@lorem.co.uk','2014-03-11 00:51:07',1,1,1),('Keith','Boyd','2890 Ipsum Avenue','01 63 89 42 38','et.magnis@pede.com','2015-08-29 09:51:44',1,1,1),('Kennan','Clayton','Ap #736-543 Egestas. Ave','03 12 55 84 96','rutrum.urna.nec@tellusnonmagna.co.uk','2015-03-19 01:58:12',1,1,1),('Graiden','Sutton','4567 Quisque Rd.','04 04 32 25 07','Phasellus.elit.pede@nibhenim.com','2014-11-11 03:26:30',1,1,1),('Octavius','Perry','2077 Pede. Avenue','08 32 25 42 81','iaculis.aliquet@Nullamscelerisque.net','2014-04-30 17:23:09',1,1,1),('Clinton','Espinoza','Ap #140-7528 Eu Ave','01 73 17 01 25','et.magnis@leo.co.uk','2015-01-08 23:06:45',1,1,1),('Charles','Fuentes','Ap #381-256 Sagittis St.','04 91 69 93 51','Proin@fermentumvel.ca','2015-07-05 14:06:18',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Cain','Manning','P.O. Box 786, 9444 Mauris Av.','08 19 09 51 13','mauris.sapien.cursus@risusInmi.org','2014-07-17 10:26:51',1,1,1),('Galvin','Figueroa','740-2094 Velit Avenue','09 92 40 44 59','pede.et@Quisque.com','2015-04-05 19:02:12',1,1,1),('Guy','Spencer','P.O. Box 405, 5425 Feugiat Rd.','05 22 05 97 67','metus.Aenean.sed@non.ca','2014-11-29 22:13:04',1,1,1),('Noah','Vaughan','728-5196 Pede Rd.','05 99 30 31 81','sit.amet@purus.co.uk','2015-04-16 05:20:18',1,1,1),('Josiah','Vazquez','321-3985 Quis, St.','09 15 65 09 25','urna.justo.faucibus@insodaleselit.edu','2014-04-20 03:19:29',1,1,1),('Timothy','Richards','P.O. Box 143, 3733 Ornare Avenue','01 27 67 78 74','in.faucibus@orcilobortisaugue.org','2014-04-10 21:24:44',1,1,1),('Maxwell','Leon','978-7466 Et Ave','05 17 03 25 59','Suspendisse.commodo@FuscemollisDuis.org','2015-03-19 12:04:01',1,1,1),('Murphy','Higgins','Ap #964-7694 Sed Rd.','05 45 04 89 89','sit.amet.ultricies@afeugiat.org','2014-02-19 16:11:48',1,1,1),('Xenos','Clements','322 Nec Avenue','05 81 93 35 42','diam.vel.arcu@Phasellus.net','2014-08-18 19:28:31',1,1,1),('Holmes','Sharpe','7209 Consequat Street','08 52 39 26 61','bibendum.sed@bibendum.org','2014-06-01 11:30:55',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Elton','Jennings','6030 Elit St.','01 65 25 20 09','neque.pellentesque.massa@rhoncusProinnisl.org','2014-07-09 15:09:00',1,1,1),('Ivor','Howell','P.O. Box 650, 4093 Facilisis Av.','09 78 06 47 51','pede.Cras@luctuset.co.uk','2015-06-03 01:59:23',1,1,1),('Brian','Farrell','P.O. Box 496, 3208 Lobortis St.','07 24 30 02 93','mollis.nec.cursus@arcueu.ca','2015-06-28 13:43:27',1,1,1),('Jordan','Rojas','897-7050 Ultrices. St.','03 25 97 21 42','pede.Praesent.eu@imperdietdictum.co.uk','2015-03-18 11:19:16',1,1,1),('Jared','Richard','6646 Luctus Avenue','03 17 95 98 28','et.arcu.imperdiet@cursusaenim.org','2014-11-08 05:07:38',1,1,1),('Guy','Rich','4486 Praesent Av.','06 50 22 94 26','vehicula@semPellentesqueut.edu','2015-11-10 11:07:25',1,1,1),('Adam','Jimenez','493-7812 A, St.','03 14 40 18 18','eget@penatibus.ca','2014-01-28 18:55:37',1,1,1),('Kane','Workman','Ap #727-3627 Molestie St.','02 30 52 81 36','penatibus.et.magnis@nonsapien.edu','2015-01-25 17:54:36',1,1,1),('Ahmed','Colon','1948 Rhoncus Rd.','08 98 43 85 90','arcu@duiCum.ca','2014-05-27 02:39:09',1,1,1),('Leo','Lawrence','4874 Euismod Av.','02 08 18 99 91','vitae@adipiscing.org','2014-10-02 13:53:52',1,1,1);
INSERT INTO persons([firstname],[lastname],[address],[phone],[mail],[creationDate],[checkInformations],[invitationRight],[validated]) VALUES('Quentin','Holcomb','1919 Fusce Avenue','07 47 11 85 82','orci.adipiscing.non@duisemper.ca','2014-07-18 15:31:27',1,1,1),('Adrian','Bender','P.O. Box 956, 5458 Tempor, Rd.','04 88 52 90 38','eleifend.Cras@egestasFuscealiquet.co.uk','2013-12-02 14:59:25',1,1,1),('Maxwell','Curry','821-5216 Curabitur Ave','08 97 41 22 31','convallis.est@hendrerit.edu','2015-04-29 02:15:04',1,1,1),('George','Pierce','140-5615 Non, St.','01 02 22 96 30','laoreet@malesuada.edu','2014-04-10 11:39:51',1,1,1),('Griffin','Sutton','Ap #960-976 Eget St.','01 13 80 49 22','a.felis.ullamcorper@ridiculus.ca','2015-04-21 03:54:05',1,1,1),('Travis','Stanton','702-5291 Tortor St.','05 19 19 17 95','Suspendisse.sagittis.Nullam@necligulaconsectetuer.net','2015-03-17 09:35:27',1,1,1),('Murphy','Hubbard','424-8265 Dui, St.','08 46 65 80 86','nisi.Cum.sociis@ornarelectus.edu','2015-03-02 20:29:57',1,1,1),('Joseph','Freeman','Ap #410-4251 Diam. Av.','09 97 92 34 11','dictum@gravidanonsollicitudin.co.uk','2014-01-31 20:26:17',1,1,1),('Emery','Morton','P.O. Box 154, 5317 Curabitur Av.','08 50 13 62 85','eget.nisi@nuncinterdum.edu','2013-12-12 09:10:56',1,1,1),('Aquila','Rollins','Ap #320-2583 Varius. Ave','02 68 56 70 88','Quisque.purus@loremDonec.co.uk','2015-06-27 20:55:46',1,1,1);

INSERT INTO courts([maxDureationBeforeBookingDuration], [comment]) VALUES (5,'Cot� ville'),(5,'Cot� autoroute');

INSERT INTO roles([name]) VALUES ('Membre'),('Non-membre'),('Administrateur'),('Comit�');

/*
	Generated by http://generatedata.com/
*/
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Richards','ITV87QKZ6JH',3,1),('Gonzalez','TOK91FQY2EB',2,2),('Browning','YAO23SHG8LF',1,3),('Nash','NQF02LSY3BE',2,4),('Hicks','BVE12YLS5MF',3,5),('Brooks','PLJ95TNU5AT',2,6),('Conner','ITM05FGT5LG',3,7),('Madden','ZCF16FAN0IP',3,8),('Lawrence','EFI87HXT1FK',3,9),('Maxwell','IXX25HBE2FS',1,10);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Merrill','OKW46CBU2MH',1,11),('Bell','AGB01OGL9ZE',1,12),('Nichols','LVO56RKQ6DL',1,13),('Michael','EXV18BRG6TO',1,14),('Medina','RQY34YKD6ML',2,15),('Mercer','NFB28FQT1MI',3,16),('Ward','IAN15KKR6CZ',3,17),('Shaw','ZWZ23BWV4NR',2,18),('Lynn','LTY25PYO1LF',3,19),('Flowers','APV66DBU5EM',2,20);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Salinas','AGZ57FXP1NH',1,21),('Nunez','NNI42QQD5OL',3,22),('Wood','HSJ08RDY3QV',1,23),('Benson','MSU61YZR7GS',3,24),('Weeks','OHJ18LZY6TP',2,25),('Vance','PVE76WRS5DZ',3,26),('Carter','SGP19PBK4IH',3,27),('Tillman','KTA94NNC6UZ',2,28),('Andrews','IOH51WJM8KK',3,29),('Buckner','XVX24HVG7ZV',2,30);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Ellis','TON75ALK9FJ',2,31),('Cline','HNQ32XBF3FX',3,32),('Harmon','BWA46CSN3WW',1,33),('Parker','AGV47YIJ9LE',2,34),('Webb','UKH09ZXP0SV',1,35),('Merrillaa','CPQ57VYS9QE',2,36),('Pratt','ADI84MIW4EE',2,37),('Salazar','RIY63NUH2LJ',3,38),('Mack','SHU27ARU1WJ',1,39),('Webbob','YTK51ZMJ0AI',1,40);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Carrillo','POR18MUK4HM',3,41),('Casey','NRG26JRX7NO',3,42),('Skinner','HZU55DVZ5UH',1,43),('Edwards','MCL40OYS7WB',2,44),('Bentley','ENE63RXF3QU',1,45),('Vasquez','UDB18LYX4FS',2,46),('Meyer','JHN89CRG2XZ',1,47),('Matthews','MTD91KYW8VH',2,48),('Rosales','OHO51KMA9PZ',1,49),('Howell','ZPA89AYA0UN',1,50);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Alvarado','DKG45VKZ1JR',1,51),('Frederick','NHG69UJF0GN',2,52),('Wardon','XLA28QKJ5LU',2,53),('Robbins','IYW42XXW0IT',2,54),('Waller','SRA91ULS8MW',1,55),('Shepherd','PDF00RHJ9NK',3,56),('Yates','DYP53TPE1NF',3,57),('Newman','VDO11FMW9PS',3,58),('Anderson','NXZ31TAX4AL',1,59),('Hull','FRM95SQM4ZN',3,60);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Rivera','LJK13UAZ4TZ',1,61),('Ryan','UCE60KNG3OT',2,62),('Mcpherson','LSW38UTD2IQ',3,63),('Case','JNR45EFN4DJ',2,64),('Hardin','WET44VHV2YH',2,65),('Elliott','VHQ03NHX3KG',2,66),('Reese','ECG23IDE7QB',2,67),('Ellison','WHU52XGG4QL',2,68),('Collins','UHP52XFL8VI',1,69),('Gallegos','IRL82PSA4SU',1,70);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Hopper','BTJ83SWP3TJ',1,71),('Klein','NPL65BUJ0VG',2,72),('Holt','ZXY38NEH5PA',1,73),('Mcfadden','EHE13KMN7WT',1,74),('Randolph','GUV46EXX0AX',1,75),('Wise','AYC07CJP9AR',2,76),('Golden','FMR05EBR4YY',1,77),('Ellisonnel','EXL35WNM4YZ',3,78),('Justice','ZUE32DBC8VE',3,79),('Gamble','YHZ93DBL0WH',1,80);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Mcdonald','QVI40LRN3BS',1,81),('Ross','OGM79BWF9HO',2,82),('Estrada','QMX63YTG5MR',2,83),('Cobb','QDK90OHP3IQ',2,84),('Harvey','XDP81PYK0FE',3,85),('Odonnell','LNF06CGU5MZ',3,86),('Elliottte','GDV04QBP6UV',1,87),('Sargent','WTT77TZX4OD',3,88),('Blankenship','LTK60BKJ4ZK',1,89),('Hendrix','FHQ87OYO3IF',3,90);
INSERT INTO credentials([login],[password],[fkRole],[fkPerson]) VALUES('Campbell','VAR64DAG2CJ',3,91),('Landry','FSU90SMP5JJ',3,92),('Lancaster','KAI00PMT8IF',2,93),('Franks','VII93CXS6LY',1,94),('Riley','FHP08DCP3ID',2,95),('Mckenzie','ZQP59QDE6TO',2,96),('Mayer','CHC42LDR2OU',3,97),('Oneal','JET67SUR4NI',2,98),('Bowman','HSG70NZH5LB',3,99),('Payne','ULJ76VNT0QO',2,100);


