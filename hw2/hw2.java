import java.util.*;
import java.lang.*;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class hw2 { 
	public static void main(String args[]) {
		String queryType = args[0].toLowerCase();
		if(queryType.equals("window")) {
			if(args.length < 6) {
				System.out.println("Use: java hw2 window [object] [lower x] [lower y] [upper x] [upper y]");
				System.exit(0);
			}

			String object = args[1].toLowerCase();
			if(!object.equals("student") && !object.equals("building") && !object.equals("tramstop")) {
				System.out.println("Invalid object; choose from: student, building, tramstop");
				System.exit(0);
			}

			int x0 = Integer.parseInt(args[2]);
			int y0 = Integer.parseInt(args[3]);
			int xf = Integer.parseInt(args[4]);
			int yf = Integer.parseInt(args[5]);
			
			if(object.equals("student")) {
				windowQuery("students", x0, y0, xf, yf);
			}
			else if(object.equals("building")) {
				System.out.println("window building");
				windowQuery("buildings", x0, y0, xf, yf);
			}
			else if(object.equals("tramstop")) {
				System.out.println("window tramstop");
				windowQuery("tramstops", x0, y0, xf, yf);
			}
		} // end of window

		else if(queryType.equals("within")) {
			if(args.length < 3) {
				System.out.println("Use: java hw2 within [student_id] [distance]");
				System.exit(0);
			}

			String student_id = args[1].toLowerCase();
			int distance = Integer.parseInt(args[2]);
			if(distance < 0) {
				System.out.println("Invalid distance");
				System.exit(0);
			}
			withinQuery(student_id,distance);
		} // end of within

		else if(queryType.equals("nearest-neighbor")) {
			if(args.length < 4) {
				System.out.println("Use: java hw2 nearest-neighbor [neighbor object type] [object id] [number of neighbors]");
				System.exit(0);
			}

			String neighborObject = args[1].toLowerCase();
			String id = args[2].toLowerCase();
			int numNeighbors = Integer.parseInt(args[3]);

			if(!neighborObject.equals("student") && !neighborObject.equals("building") && !neighborObject.equals("tramstop")) {
				System.out.println("Invalid object; choose from: student, building, tramstop");
				System.exit(0);
			}
			if(numNeighbors < 1) {
				System.out.println("No neighbors to find");
				System.exit(0);
			}

			System.out.println(neighborObject + " " + id + " " + numNeighbors);
			nearestNeighborsQuery(neighborObject, id, numNeighbors);
		} // end of nearest-neighbor

		else if(queryType.equals("fixed")) {
			if(args.length < 2) {
				System.out.println("Use: java hw2 fixed [query number]");
				System.exit(0);
			}

			int queryNumber = Integer.parseInt(args[1]);
			if(queryNumber == 1) {
				queryOne();
			}
			else if(queryNumber == 2) {
				queryTwo();
			}
			else if(queryNumber == 3) {
				queryThree();
			}
			else if(queryNumber == 4) {
				queryFour();
			}
			else if(queryNumber == 5) {
				queryFive();
			}
		}

		System.out.println("Done");
	}

	public static void windowQuery(String tablename, int x0, int y0, int xf, int yf) {
		Connection conn = null;
		String geom = "";
		String id = "";

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	return;
		    }

		    Statement stmt = conn.createStatement();
		    if(tablename.equals("students")) {
		    	id = "student_id";
		    	geom = "location";
		    }
		    else if(tablename.equals("tramstops")) {
		    	id = "tramstop_id";
		    	geom = "Buffer(location,radius)";
		    }
		    else if(tablename.equals("buildings")) {
		    	id = "building_id";
		    	geom = "geom";
		    }
		    String query = "select " + id + " as id from " + tablename + " where ST_Within(" + geom + ",Envelope(GeomFromText('LineString(" 
		    	+ x0 + " " + y0 + "," + xf + " " + yf + ")'))) order by id;";

			ResultSet rs = stmt.executeQuery(query);
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();
		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(",  ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); // + " " + rsmd.getColumnName(i));
		        }
        		System.out.println();
    		}

		    rs.close();		    
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	}

	public static void withinQuery(String student_id, int distance) {
		Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }

		    Statement stmt = conn.createStatement();
		    String query = "select location from students where student_id = '" + student_id + "';";
			ResultSet rs = stmt.executeQuery(query);
			if(!rs.next()) {
				System.out.println("Invalid student id");
				rs.close();
				stmt.close();
				conn.close();
				return;
			}

			stmt.executeUpdate("set @loc = (select location from students where student_id = '" + student_id + "');");
			query = "(select building_id as id from buildings where ST_Contains(Buffer(@loc," + distance + "),geom)) " 
				+ "union (select tramstop_id from tramstops where ST_Contains(Buffer(@loc," + distance + "),location));";

			rs = stmt.executeQuery(query);
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();
		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(",  ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); 
		        }
        		System.out.println();
    		}

		    rs.close(); 
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}	
	}

	public static void nearestNeighborsQuery(String neighborObject, String object_id, int numNeighbors) {
		Connection conn = null;
		String tablename = "";
		String id = "";
		String geom = "";

		if(neighborObject.equals("student")) {
			tablename = "students";
			id = "student_id";
			geom = "location";
		}
		else if(neighborObject.equals("tramstop")) {
			tablename = "tramstops";
			id = "tramstop_id";
			geom = "Buffer(location,radius)";
		}
		else if(neighborObject.equals("building")) {
			tablename = "buildings";
			id = "building_id";
			geom = "geom";
		}

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }

		    Statement stmt = conn.createStatement();
		    String query = "select * from " + tablename + " where " + id + " = '" + object_id + "';";
			ResultSet rs = stmt.executeQuery(query);
			if(!rs.next()) {
				System.out.println("Invalid " + neighborObject + " id");
				rs.close();
				stmt.close();
				conn.close();
				return;
			}

			/*
			set @geom = (select geom from buildings where building_id = 'b3');
			select building_id
			from buildings
			where ST_Within(geom, Buffer(@geom,1000)) and building_id != 'b3'
			order by ST_Distance(geom,@geom)
			limit 5;
			*/	

			String geometry = "(select " + geom + " from " + tablename + " where " + id + " = '" + object_id + "')";
			StringBuffer sb = new StringBuffer("select " + id + " from " + tablename + " where ST_Within(" + geom + ", Buffer(" + geometry + ",1000)) and " + id + " != '" + object_id + "' " 
				+ "order by ST_Distance(" + geom + ", " + geometry + ") limit " + numNeighbors + ";");
			/*
			stmt.executeUpdate("set @geom = (select " + geom + " from " + tablename + " where " + id + " = '" + object_id + "');");
			query = "select " + id + " from " + tablename + " where ST_Within(" + geom + ", Buffer(@geom,1000)) and " + id + " != '" + object_id + "' " 
				+ "order by ST_Distance(" + geom + ", @geom) limit " + numNeighbors + ";";
			*/


			rs = stmt.executeQuery(sb.toString());
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();
		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(",  ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); 
		        }
        		System.out.println();
    		}

		    rs.close(); 
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	}

	public static void queryOne() {
		System.out.println("Fixed query 1");
		// Find the ids of all the students and buildings cover by tram stops: t2ohe and t6ssl.
		Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }

		    Statement stmt = conn.createStatement();
		    String t1 = "(select Buffer(location,radius) from tramstops where tramstop_id = 't2ohe')";
		    String t2 = "(select Buffer(location,radius) from tramstops where tramstop_id = 't6ssl')"; 
		    
		    StringBuffer sb = new StringBuffer("(select student_id as id from students ");
		    sb.append("where ST_Within(location," + t1 + ") and ST_Within(location," + t2 + ")) ");
		    sb.append("union");
		   	sb.append("(select t1b.building_id from ");
		   	sb.append("(select building_id from buildings where ST_Within(geom," + t1 + ")) as t1b ");
		   	sb.append("inner join");
		   	sb.append("(select building_id from buildings where ST_Within(geom," + t2 + ")) as t2b ");
		   	sb.append("on t1b.building_id = t2b.building_id );");

			ResultSet rs = stmt.executeQuery(sb.toString());
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();
		    if(!rs.next()) {
		    	System.out.println("Empty result set");
		    	return;
		    }
		    rs.beforeFirst(); // reset back if there are rows
		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(",  ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); 
		        }
        		System.out.println();
    		}

		    rs.close(); 
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	} // end of queryOne

	public static void queryTwo() {
		System.out.println("Fixed query 2");


	} // end of queryTwo

	public static void queryThree() {
		System.out.println("Fixed query 3");
		// We say a tram stop covers a building if it is within distance 250 to that building.
		// Find the ID’s of the tram stop that cover the most buildings.
		Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }

		    Statement stmt = conn.createStatement();
		    
		    String query = "select t.tramstop_id, count(distinct b.building_id) as numBuildings from tramstops t, buildings b where ST_Distance(b.geom, t.location) <= 250 group by t.tramstop_id order by numBuildings desc;";

			ResultSet rs = stmt.executeQuery(query);
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();

		    if(!rs.next()) {
		    	System.out.println("Empty result set");
		    	return;
		    }
		    rs.beforeFirst(); // reset back if there are rows

		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(", ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); 
		        }
        		System.out.println();
    		}

		    rs.close(); 
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	} // end of queryThree

	public static void queryFour() {
		System.out.println("Fixed query 4");
		// We say a student is called a reverse nearest neighbor of a building if it is that
		// building’s nearest student. Find the ID’s of the top 5 students that have the most 
		// reverse nearest neighbors together with their number of reverse nearest neighbors.
		Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }

		    Statement stmt = conn.createStatement();
		    
		    StringBuffer sb = new StringBuffer("select t3.student_id, count(t3.building_id) as count from (");
		    sb.append("select s.student_id, building_id, ST_Distance(s.location,geom) from students s inner join ");
		    sb.append("(select building_id, geom, min(ST_Distance(location,geom)) as minDist from students, buildings group by building_id) as t2 ");
		    sb.append(" on ST_Distance(s.location,t2.geom) = t2.minDist ) as t3 group by t3.student_id order by count desc limit 5;");

			ResultSet rs = stmt.executeQuery(sb.toString());
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();

		    if(!rs.next()) {
		    	System.out.println("Empty result set");
		    	return;
		    }
		    rs.beforeFirst(); // reset back if there are rows

		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(", ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); 
		        }
        		System.out.println();
    		}

		    rs.close(); 
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	} // end of queryFour

	public static void queryFive() {
		System.out.println("Fixed query 5");
		// Find the coordinates of the lower left and upper right vertex of the MBR that fully 
		// contains all buildings whose names are of the form ’SS%’. Note that you cannot manually figure out these buildings in your program.

		Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }

		    Statement stmt = conn.createStatement();

		    String envelope = "(select Envelope(GeomFromText(concat(concat(\"geometrycollection(\",group_concat(AsText(geom))),\")\"))) "
		    	+ "from( select geom from buildings where building_name like 'ss%' ) as ssBuildings)";

		    String lowerLeftPoint = "(PointN((select ExteriorRing(" + envelope + ")),1))";	 // Linestring starts from 1
		    String upperRightPoint = "(PointN((select ExteriorRing(" + envelope + ")),3))";
		    
		    StringBuffer sb = new StringBuffer("(select X(" + lowerLeftPoint + "), Y(" + lowerLeftPoint + ") )");
		   	sb.append("union ");
		   	sb.append("(select X(" + upperRightPoint + "), Y(" + upperRightPoint + ")); ");

			ResultSet rs = stmt.executeQuery(sb.toString());
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();

		    if(!rs.next()) {
		    	System.out.println("Empty result set");
		    	return;
		    }
		    rs.beforeFirst(); // reset back if there are rows

		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(", ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue); 
		        }
        		System.out.println();
    		}

		    rs.close(); 
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	} // end of queryFive
}