package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.exception.NotFoundException;
import com.my.service.CustomerService;

public class DubChkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerService service;
	
	public DubChkServlet() {
		service = new CustomerService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청 데이터 수신
		String id = request.getParameter("id");
		String str = service.dupchk(id);
		request.setAttribute("result", str);

		// 현재 페이지: http://localhost:8080/servlet5/jq/a.html
		// URI의		 	/: 지금 사용중인 web context의 하위 경로라는 뜻
		// String path = "/result"; --> http://localhost:8080/servlet5/result
		// *주의: html의	/: root web context에 있는 자원
		// <form action="/result"></form> --> http://localhost:8080/result
		// <form action="../result"></form> --> http://localhost:8080/servlet5/result
		String path = "/result";	// result페이지에서 응답 송신 작업을 진행 (결과 보여주기)
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
