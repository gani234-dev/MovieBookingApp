package com.mba.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


public class Bookingservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
 
     */
    public Bookingservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		String name=request.getParameter("hidi");
		String movie=request.getParameter("movie");
		String dob=request.getParameter("date");
		String time=request.getParameter("time");
		String nt=request.getParameter("seats");
		
		 String jdbcURL = "jdbc:mysql://localhost:3306/mba";
         String dbUser = "root";         // change as needed
         String dbPassword = "root123";  // change as needed

         String insertSQL = "INSERT INTO booking (movie,name,dob,time,ticket) VALUES (?, ?, ?,?,?)";

         try {
             // Load JDBC Driver (optional in newer versions)
             Class.forName("com.mysql.cj.jdbc.Driver");

             // Establish connection
             Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(insertSQL);

             // Set parameters
             stmt.setString(1, movie);
             stmt.setString(2, name);
             stmt.setString(3,dob );
             stmt.setString(4, time);
             stmt.setString(5, nt);
             request.setAttribute("movie", movie);
             request.setAttribute("name", name);
             request.setAttribute("dob", dob);
             request.setAttribute("time", time);
             request.setAttribute("nt", nt);
             
             
             int rowsInserted = stmt.executeUpdate();
             
     		RequestDispatcher rd=request.getRequestDispatcher("/confirm.jsp");
    		rd.forward(request, response);	
		
	}
         catch(Exception e) 
         {
        	 e.printStackTrace();
         }
	}
}
