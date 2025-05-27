package com.mba.Connection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GetConnection {
	public Connection getConnection(){
		String url="jdbc:mysql://localhost:3306/mba";
		String username="root";
		String password="root123";
		Connection con=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Loaded and Registered the Driver");
			con=DriverManager.getConnection(url,username,password);
			System.out.println("Connection Established");
			return con;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
}