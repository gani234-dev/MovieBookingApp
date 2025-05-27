package com.mba.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.mba.Connection.GetConnection;
import com.mba.Model.Information;

/**
 * Servlet implementation class Mba
 */
//@WebServlet("/Mba")
public class Mba extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Mba() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Reached here:");
		String name=request.getParameter("name");
		String dob=request.getParameter("dob");
		String email=request.getParameter("email");
	    String password=request.getParameter("psw");
		System.out.println(name);
		System.out.println(dob);
		System.out.println(email);
		System.out.println(password);
		request.setAttribute("Name", name);
		request.setAttribute("DOB", dob);
		request.setAttribute("Email", email);
		request.setAttribute("Password",password);
		Information info=new Information(name,dob,email,password);
		insertIntoDatabase(info);
		//Database Connection
		RequestDispatcher rd=request.getRequestDispatcher("/login.jsp");
		rd.forward(request, response);	
		
		
		
		
		
		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	public static void insertIntoDatabase(Information info)
	{
		Connection con= null;
		GetConnection gc=new GetConnection();
		Statement stmt=null;
		String insert ="insert into Movie_data values('"+info.getId()+"','"+info.getName()+"','"+info.getDob()+"','"+info.getEmail()+"','"+info.getPassword()+"')";
		try {
			System.out.println("Reached insert into database");
			con=gc.getConnection();
			stmt=con.createStatement();
			int i=stmt.executeUpdate(insert);
			System.out.println("No of rows inserted: "+i);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
