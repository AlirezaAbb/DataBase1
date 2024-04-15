/* 
•	Student Name:		Alireza Abbasi
•	Student Number:	    	********
•	Course Section:		DBA625NSB – Winter 2023
•	Professor: 		Dr. Les King
•	School:			Seneca College – SIA Campus

*/

create database music;
use music;

create table bandinfo(
[BandName] varchar(30) not null primary key,
[FormationYear] int,
[CurrentStatus] varchar(8),
[BaseCity] varchar(25),
[BaseCountry] varchar(25),
[NumberOfBandMembers] int,
[NumberOfReleases] int ,
[Genre] varchar(20)
);

insert into bandinfo
values
	('Little Mix',2011,'Inactive','London','England',4,80,'Pop'),
	('Honeyblood',2012,'Active','Glasgow','Scotland',1,15,'Indie Rock'),
	('Queen',1970,'Active','London','England',3,130,'Rock'),
	('The Beatles',1960,'Inactive','Liverpool','England',4,280,'Pop'),
	('Prince & The Revolution',1979,'Active','Minneapolis','USA',6,40,'Funk'),
	('AC/DC',1973,'Active','Sydney','Australia',5,143,'Hard Rock'),
	('Eagles',1971,'Active','Los Angeles','USA',4,51,'Rock'),
	('The Temptations',1960,'Active','Detroit','USA',5,174,'Funk'),
	('The Byrds',1964,'Inactive','Los Angeles','USA',3,97,'Rock'),
	('Fleetwood Mac',1967,'Active','London','England',5,162,'Rock'),
	('The Bee Gees',1958,'Inactive','Manchester','England',3,126,'Pop'),
	('Black Sabbath',1968,'Inactive','Birmingham','England',4,102,'Heavy metal'),
	('ABBA',1972,'Active','Stockholm','Sweden',4,141,'Pop Rock'),
	('Genesis',1967,'Active','Godalming','England',3,136,'Progressive Rock'),
	('The Jam',1972,'Inactive','Woking','England',5,54,'Punk Rock'),
	('Grateful Dead',1965,'Inactive','Palo Alto','USA',5,272,'Rock'),
	('The Stooges',1967,'Inactive','Ann Arbor','USA',4,52,'Proto punk'),
	('King Crimson',1968,'Inactive','London','England',5,69,'Progressive Rock'),
	('Chicago',1967,'Active','Chicago','USA',7,111,'Rock'),
	('The Everly Brothers',1951,'Inactive','Knoxville','USA',2,138,'Country rock');

create table bandrecognition (
[BandName] varchar(30) not null, 
[Award] varchar(25),
[Nomination] char(1),
[Year] int,
foreign key (BandName) references bandinfo (BandName) 
on delete cascade 
on update cascade
);

insert into bandrecognition
values
	('Little Mix','Attitude Awards','A',2018),
	('Little Mix','Brit Awards','N',2016),
	('Queen','Brit Awards','A',1977),
	('Queen','Brit Awards','N',1982),
	('The Beatles','Brit Awards','A',1977),
	('Prince & The Revolution','Grammy','W',1985),
	('Prince & The Revolution','Image Awards','W',1984),
	('AC/DC','Grammy','N',1989),
	('Eagles','Grammy','N',1973),
	('The Temptations','Grammy','A',2013),
	('The Temptations','Grammy','N',2007),
	('Fleetwood Mac','Grammy','N',1978),
	('The Bee Gees','Grammy','A',1978),
	('The Bee Gees','Grammy','A',1979),
	('ABBA','Brit Awards','N',1977),
	('Genesis','American Music Awards','A',1993),
	('Genesis','Grammy','N',1985),
	('Grateful Dead','Grammy','W',2007),
	('Chicago','Grammy','N',1970),
	('The Everly Brothers','Grammy','A',1997);


alter table bandinfo
add releases nvarchar(max);

update bandinfo
set releases='{
    "little-mix-releases":[
        {
            "type":"Studio albums",
            "year":"2012",
            "title":"DNA"
        },
        {
            "type":"Studio albums",
            "year":"2013",
            "title":"Salute"
        },
        {
            "type":"Single",
            "year":"2013",
            "title":"Move"
        },
        {
            "type":"Compilation albums",
            "year":"2021",
            "title":"Between Us"
        }

    ]
}'
where BandName='Little Mix';

update bandinfo
set releases='{
    "honeyblood-releases":[
        {
            "type":"Studio albums",
            "year":"2014",
            "title":"Honeyblood "
        },
        {
            "type":"Live albums",
            "year":"2016",
            "title":"Babes Never Die"
        },
        {
            "type":"Single",
            "year":"2012",
            "title":"Thrift Shop"
        },
        {
            "type":"Single",
            "year":"2014",
            "title":"Choker"
        }

    ]
}'
where BandName='Honeyblood';

update bandinfo
set releases='{
    "queen-releases":[
        {
            "type":"Studio albums",
            "year":"1973",
            "title":"Queen"
        },
        {
            "type":"Live albums",
            "year":"1974",
            "title":"Queen II"
        },
        {
            "type":"Compilation albums",
            "year":"1997",
            "title":"Queen Rocks"
        },
        {
            "type":"Single",
            "year":"1974",
            "title":"Killer Queen"
        }

    ]
}'
where BandName='Queen';

update bandinfo
set releases='{
    "beatles-releases":[
        {
            "type":"Studio albums",
            "year":"1963",
            "title":"Please Please Me"
        },
        {
            "type":"Studio albums",
            "year":"1964",
            "title":"A Hard Days Night"
        },
        {
            "type":"Compilation albums",
            "year":"1964",
            "title":"Jolly What!"
        },
        {
            "type":"Compilation albums",
            "year":"1964",
            "title":"The Beatles Beat"
        }

    ]
}'
where BandName='The Beatles';

update bandinfo
set releases='{
    "revolution_releases":[
        {
            "type":"Albums",
            "year":"1985",
            "title":"Around The World In A Day"
        },
        {
            "type":"Albums",
            "year":"1984",
            "title":"Purple Rain"
        },
        {
            "type":"Albums",
            "year":"1986",
            "title":"Parade"
        },
        {
            "type":"Singles",
            "year":"1984",
            "title":"Lets Go Crazy"
        }

    ]
}'
where BandName='Prince & The Revolution';

create table bandmembers (
[BandName] varchar(30), 
[LastName] varchar(15),
[FirstName] varchar(15),
[Role] varchar(25),
[StartYear] int,
[EndYear] int ,
foreign key (BandName) references bandinfo (BandName),
PRIMARY KEY (BandName, LastName,FirstName),
[StartTime] datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
[EndTime] datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) 
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.bandmembersHistory));

insert into bandmembers(BandName,LastName,FirstName,Role,StartYear,EndYear)
values
	('Little Mix','Pinnock','Leigh-Anne','Vocalist',2011,2022),
	('Little Mix','Thirtwall','Jade','Vocalist',2011,2022),
	('Little Mix','Edwards','Perrie','Vocalist',2011,2022),
	('Little Mix','Nelson','Jesy','Vocalist',2011,2020),
	('Honeyblood','McVicar','Shona','Guitarist',2012,2014),
	('Honeyblood','Myers','Cat','Drummer',2014,2019),
	('Queen','Mercury','Freddie','Vocalist',1970,1991),
	('Queen','Deacon','John','Bass',1971,1997),
	('The Beatles','Lenon','John','Vocalist',1960,1970),
	('The Beatles','McCartney','Paul','Vocalist',1960,1970),
	('The Beatles','George','Harrison','Lead Guitarist',1960,1970),
	('The Beatles','Starr','Ringo','Lead Drummer',1960,1970),
	('Prince & The Revolution','Nelson','Prince','Vocalist',1979,1986),
	('Prince & The Revolution','Dickerson','Dez','Vocalist',1979,1983),
	('Prince & The Revolution','Cymone','Andre','Bass Guitarist',1979,1981),
	('Prince & The Revolution','Chapman','Gayle','Keybordist',1979,1980);

insert into bandmembers(BandName,LastName,FirstName,Role,StartYear)
values
	('Prince & The Revolution','Rivkin','Robert','Drummer',1979),
	('Prince & The Revolution','Fink','Matt','Keybordist',1979),
	('Honeyblood','Tweeddale','Stina','Vocalist',2012),
	('Queen','May','Brian','Guitarist',1970),
	('Queen','Taylor','Roger','Drummer',1970);
