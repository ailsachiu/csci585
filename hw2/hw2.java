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

			}
			else if(queryNumber == 3) {

			}
			else if(queryNumber == 4) {

			}
			else if(queryNumber == 5) {

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
		    	System.exit(0);
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
				System.exit(0);
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
				System.exit(0);
			}

			/*
			set @geom = (select geom from buildings where building_id = 'b3');
			select building_id
			from buildings
			where ST_Within(geom, Buffer(@geom,1000)) and building_id != 'b3'
			order by ST_Distance(geom,@geom)
			limit 5;
			*/	
			stmt.executeUpdate("set @geom = (select " + geom + " from " + tablename + " where " + id + " = '" + object_id + "');");
			query = "select " + id + " from " + tablename + " where ST_Within(" + geom + ", Buffer(@geom,1000)) and " + id + " != '" + object_id + "' " 
				+ "order by ST_Distance(" + geom + ", @geom) limit " + numNeighbors + ";";

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

	public static void queryOne() {
		// Find the ids of all the students and buildings cover by tram stops: t2ohe and t6ssl.

	}
}