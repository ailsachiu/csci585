Ailsa Chiu 
CSCI 585
HW 2

This is done in MySQL server with MySQL Spatial, not Oracle 11.
createdb.sql was generated from an 'Export Data' from MySQL Developer.
Use this to create and populate the database.

To compile:
javac -classpath mysql-connector-java-5.1.33-bin.jar hw2.java

To run:
java -cp .:mysql-connector-java-5.1.33-bin.jar hw2 [query type] [arguments]


Notes:

Fixed query 4
ST_Distance() produces a different difference calculation than Oracle SQL distance.
To try to account for this, instead of using ST_Distance(student.location,building.geom), I use ST_Distance(student.location, ExteriorRing(building.geom)).

Fixed query 5
MySQL does not have aggregate functions on GEOMETRY types, so I manually created aggregation through the available MySQL spatial functions.