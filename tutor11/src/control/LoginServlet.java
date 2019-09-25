package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.my.service.CustomerService;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerService service;
	public LoginServlet() {
		 service = new CustomerService();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*--아이디기억----*/
//		String c = request.getParameter("c");
//		if("save".equals(c)) { //아이디기억
//			//1)쿠키생성
//			Cookie cookie = new Cookie("savedId", 
//					request.getParameter("id"));
//			//2)쿠키유효기간설정
//			cookie.setMaxAge(60);//1분간 사용가능한 쿠키
//			//3)쿠키 응답헤더에 추가
//			response.addCookie(cookie);
//		}else { //아이디기억해제
//			//1)쿠키생성
//			Cookie cookie = new Cookie("savedId", 
//					request.getParameter("id"));
//			//2)쿠키유효기간설정
//			cookie.setMaxAge(0);//0초간 사용가능한 쿠키-기존쿠키 무효화
//			//3)쿠키 응답헤더에 추가
//			response.addCookie(cookie);
//		}
		/*--------------*/
		HttpSession session = request.getSession();
		session.removeAttribute("loginInfo");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		String str = service.login(id, pwd);
		/*--로그인성공시 HttpSession객체의 속성으로 추가 --*/
		JSONParser parser = new JSONParser();
		try {
			Object obj = parser.parse(str);
			JSONObject jsonObj = (JSONObject)obj;
			if((Long)jsonObj.get("status") == 1) {//로그인 성공!
				session.setAttribute("loginInfo", id);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		/*-------*/
		request.setAttribute("result", str);
		//String path = "/result";
		String path = "/result.jsp";
		RequestDispatcher rd = 
				request.getRequestDispatcher(path);			
		rd.forward(request, response);		
	}
}
