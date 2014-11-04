create database cs585_hw2;
use cs585_hw2;

create user 'java'@'localhost' identified by 'password';
grant all on cs585_hw2.* to 'java'@'localhost' identified by 'password';

show tables;

CREATE TABLE STUDENTS ( 
	student_id VARCHAR(20) UNIQUE NOT NULL,
	location POINT NOT NULL,
    SPATIAL INDEX(location),
    PRIMARY KEY (student_id)
) ENGINE = MyISAM;
-- will get error 1464 if you use InnoDB

drop table if exists STUDENTS;

INSERT INTO STUDENTS (student_id, location) VALUES ( 'p0' , GeomFromText( ' POINT(228 102) ' ) ); 
select student_id, AsText(location) from students;

CREATE TABLE TRAMSTOPS (
	tram_id VARCHAR(20) UNIQUE NOT NULL,
    location POINT NOT NULL,
    radius INT NOT NULL,
    SPATIAL INDEX(location),
    PRIMARY KEY(tram_id)
) ENGINE = MyISAM;

drop table if exists TRAMSTOPS;

INSERT INTO TRAMSTOPS (tram_id, location, radius) VALUES ('t1psa' , GeomFromText( ' POINT(180 120) ' ), 100); 
select tram_id, AsText(location), radius from tramstops;

CREATE TABLE BUILDINGS ( 
	building_id VARCHAR(20) UNIQUE NOT NULL,
    building_name VARCHAR(100),
    numVertices INT,
	geom GEOMETRY NOT NULL,
    SPATIAL INDEX(geom),
    PRIMARY KEY (building_id)
) ENGINE = MyISAM;

drop table if exists BUILDINGS;

-- b1, OHE, 4, 226, 150, 254, 164, 240, 191, 212, 176
INSERT INTO BUILDINGS (building_id, building_name, numVertices, geom)
VALUES (
	'b1', 'OHE', 4,
    GeomFromText( ' POLYGON( (226 150,254 164,240 191,212 176,226 150) ) ' )
    );
select building_id, building_name, numVertices, AsText(geom) from buildings;