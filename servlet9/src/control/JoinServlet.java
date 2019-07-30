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

import com.my.service.CustomerService;
import com.my.vo.Customer;
import com.my.vo.Post;

public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CustomerService service;

	public JoinServlet() {
		service = new CustomerService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 요청 데이터 수신
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String addr2 = request.getParameter("addr2");
		String buildingno = request.getParameter("buildingno");

		// Customer 객체 생성
		Customer c = new Customer();
		c.setId(id);
		c.setPwd(pwd);
		c.setName(name);
		c.setAddr(addr2);

		Post p = new Post();
		p.setBuildingno(buildingno);
		c.setPost(p);

		String str = service.join(c);
		request.setAttribute("result", str);

		String path = "/result.jsp"; // result페이지에서 응답 송신 작업을 진행 (결과 보여주기)
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
