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
		if(args[0].equals("window")) {
			if(args.length < 6) {
				System.out.println("Use: window [object] [lower x] [lower y] [upper x] [upper y]");
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
}