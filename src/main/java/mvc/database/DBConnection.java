package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated constructor stub
		
		Connection conn=null;
		
		String url="jdbc:mysql://localhost:3306/MovieDB";
		String user="root";
		String password="1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url,user,password);
		return conn;
	}

}
