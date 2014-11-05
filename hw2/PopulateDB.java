import java.util.*;
import java.lang.*;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class PopulateDB {
	public static ArrayList<String> queries = new ArrayList<String>();

	public static void main(String args[]) {
		try {
		    System.out.println("Loading driver...");
		    Class.forName("com.mysql.jdbc.Driver");
		    System.out.println("Driver loaded!");
		} catch (ClassNotFoundException e) {
		    throw new RuntimeException("Cannot find the driver in the classpath!", e);
		}


/**

		 Populate insertion statements in queries list
*/

		
		insertStudentQueries("students.txt");		

		Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }
		    System.out.println("Successful connection");

		    Statement stmt = conn.createStatement();
		    for(String s: queries)
		    	stmt.addBatch(s);
		   	stmt.executeBatch();
		    
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
		


/**

		Populate tram stops
*/

		insertTramStopQueries("tramstops.txt");
		//Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }
		    System.out.println("Successful connection");

		    Statement stmt = conn.createStatement();
		    for(String s: queries)
		    	stmt.addBatch(s);
		   	stmt.executeBatch();
		    
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}


/**

		Populate buildings
*/
		
		insertBuildingQueries("building.txt");
		//for(String s: queries)
		//	System.out.println(s);
		
		//Connection conn = null;

		try {
		    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs585_hw2","java","password");

		    if(conn == null) {
		    	System.out.println("Failed connection");
		    	System.exit(0);
		    }
		    System.out.println("Successful connection");

		    Statement stmt = conn.createStatement();
		    for(String s: queries)
		    	stmt.addBatch(s);
		   	stmt.executeBatch();
		    
		    stmt.close();
		    conn.close();

		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}


		    /*
		    ResultSet rs = stmt.executeQuery("SHOW TABLES");
		    ResultSetMetaData rsmd = rs.getMetaData();
		    int columnsNumber = rsmd.getColumnCount();
		    while (rs.next()) {
		        for (int i = 1; i <= columnsNumber; i++) {
		            if (i > 1) System.out.print(",  ");
		            String columnValue = rs.getString(i);
		            System.out.print(columnValue + " " + rsmd.getColumnName(i));
		        }
        		System.out.println("");
    		}

		    rs.close();
		    */

	} // end of main


	public static void insertStudentQueries(String csvFile) {
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		queries.clear();
	 
		try {
	 
			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
	
			    // use comma as separator
				String[] student = line.split(cvsSplitBy);
				queries.add("INSERT INTO STUDENTS (student_id, location) VALUES ( '" + 
					student[0].trim() + "' , GeomFromText( ' POINT(" + student[1].trim() + " " + student[2].trim() + ") ' ) );");

	 		}
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	 
		System.out.println("Done");
	}

	public static void insertTramStopQueries(String csvFile) {
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		queries.clear();
		try {
	 
			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
			    // use comma as separator
				String[] tramstop = line.split(cvsSplitBy);
				
				//INSERT INTO TRAMSTOPS (tramstop_id, location, radius) VALUES ('t1psa' , GeomFromText( ' POINT(180 120) ' ), 100); 
				queries.add("INSERT INTO TRAMSTOPS (tramstop_id, location, radius) VALUES ( '" + tramstop[0].trim() 
					+ "', GeomFromText( ' POINT(" + tramstop[1].trim() + " " + tramstop[2].trim() + ") ' ), " 
					+ tramstop[3].trim() + ");");
	 		}
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	 
		System.out.println("Done");
	}

	public static void insertBuildingQueries(String csvFile) {
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		queries.clear();
		try {
	 
			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
			    // use comma as separator
				String[] building = line.split(cvsSplitBy);

				// INSERT INTO BUILDINGS  VALUES ('b1', 'OHE', 4, GeomFromText( ' POLYGON( (226 150,254 164,240 191,212 176,226 150) ) ' ));
				StringBuilder sb = new StringBuilder("INSERT INTO BUILDINGS (building_id, building_name, numVertices, geom) VALUES (");
				sb.append("'" + building[0] + "', '" + building[1].trim() + "', " + building[2].trim() + ", ");	
				sb.append("GeomFromText( 'POLYGON( (");

				for(int i=3; i < building.length; i+=2) {
					sb.append(building[i].trim() + " " + building[i+1].trim() + ", ");
				}
				sb.append(building[3].trim() + " " + building[4].trim()); // starting point
				sb.append(")) ' )"); // end paren of polygon
				sb.append(");"); 	// end paren of values
				queries.add(sb.toString());
	 		}
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	 
		System.out.println("Done");
	}
}