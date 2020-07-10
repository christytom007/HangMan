package com.isi.web.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.isi.web.model.GameManager;

/**
 * Servlet implementation class RequestHandler
 */
@WebServlet("/requestHandler")
public class RequestHandler extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RequestHandler() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");
		switch (action) {
		case "select":
			String letter = request.getParameter("letter");
			GameManager.checkLetter(letter.charAt(0));
			break;
		case "reset":
			GameManager.initGame();
			break;
		case "home":
			GameManager.initGame();
			response.sendRedirect("index.html");
			return;
		default:
			break;
		}
		response.sendRedirect("gameUpdate.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
