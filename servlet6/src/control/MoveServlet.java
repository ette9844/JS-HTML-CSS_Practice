package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 페이지 이동 예제 서블릿
public class MoveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 주소url 직접 입력 -> doGet 메서드 호출
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 페이지 이동 방법 1 - 성공
		// location객체의 href 속성을 주는 것과 같은 동작
//		response.sendRedirect("http://www.google.com");

		// 페이지 이동 방법 2 - 실패: 응답코드 404 /servlet4/http://www.google.com
//		String path = "http://www.google.com";
//		RequestDispatcher rd = request.getRequestDispatcher(path);
//		rd.forward(request, response);	// 같은 webcontext의 하위 url로만 이동할 수 있다.

		String opt = request.getParameter("opt");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (opt == null || opt.equals("")) {
			out.println("<form method='post' action='move'>");	// post방식으로 move url 요청: doPost 메서드 호출
			out.println("<input type='hidden' name='opt'>");
			out.println("<button type='button' id='redirect'>리다이렉트</button>");
			out.println("<button type='button' id='forward'>포워드</button>");
			out.println("<button type='button' id='include'>인클루드</button>");
			out.println("</form>");
			out.println("<script>");
			out.println("var r = document.querySelector('#redirect');");
			out.println("var f = document.querySelector('#forward');");
			out.println("var i = document.querySelector('#include');");
			out.println("var form = document.querySelector('form');");
			out.println("var hidden = document.querySelector('input[type=hidden]');");
			out.println("r.addEventListener('click', function(){ hidden.value = 'redirect'; form.submit(); });");
			out.println("f.addEventListener('click', function(){ hidden.value = 'forward'; form.submit(); });");
			out.println("i.addEventListener('click', function(){ hidden.value = 'include'; form.submit(); });");
			out.println("</script>");
		}
		// String path = "login";
		// http://localhost:8080/servlet4/jq/login.html
		// 주소가 바뀌고 client 사이드에서 login.html을 재요청 하게 됨
		// 새로운 request/response 객체가 만들어짐
//		response.sendRedirect(path);

		// http://localhost:8080/servlet4/move
		// 서버 사이드에서 login.html을 요청하고 client로 전송
		// sendRedirect보다 많이 쓰임

		// **서버 사이드에서의 이동 방법 : Forwarding!**
		// RequestDispatcher: 기존 페이지의 request를 다른 페이지에게 전달한다
		// RequestDispatcher rd = request.getRequestDispatcher(path);
		// forward: 전달하고 돌아오지 않는다 = 페이지 이동
		// rd.forward(request, response);
		// request: 전달하고 다시 돌아온다 = 포함한다
		// rd.include(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opt = request.getParameter("opt");
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// write at response buffer
		out.print("BEFORE<br>");	// include 작업에서는 출력되지만 forward 작업에서는 출력되지 않음
		if (opt.equals("redirect")) {
			// client 차원에서의 재요청(GET방식의 요청): localhost:8080/servlet4/login을 주소창에 직접 요청하는 것과 같음
			// loginServlet에는 doGet처리 메서드가 없기 때문에 405
			response.sendRedirect("login");
		} else if (opt.equals("forward")) {
			// move url이 유지, loginServlet의 결과값이 출력
			// login path로 이동후 돌아오지 않음 -> login의 결과값만 출력됨
			String path = "login";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			// response buffer clear -> BEFORE 사라짐
			rd.forward(request, response);
		} else if (opt.equals("include")) {
			// loginServlet의 결과를 포함
			String path = "login";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.include(request, response);
		}
		out.print("<br>AFTER");	// include 작업에서는 출력되지만 forward 작업에서는 출력되지 않음
	}
}
