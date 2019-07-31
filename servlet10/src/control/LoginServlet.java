package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.dao.CustomerDAO;
import com.my.exception.NotFoundException;
import com.my.service.CustomerService;
import com.my.vo.Customer;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// servlet의 인스턴스 변수: 여러 client가 동시 접속 할 시에는 공유 객체가 됨
	private CustomerService service;

	public LoginServlet() {
		service = new CustomerService();	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 요청 데이터 수신, 결과 만들기
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		String str = service.login(id, pwd);	// 응답할 결과값까지 Service layer가 만들어줌
		request.setAttribute("result", str);

		//String path = "/result";	// result페이지에서 응답 송신 작업을 진행 (결과 보여주기)
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
