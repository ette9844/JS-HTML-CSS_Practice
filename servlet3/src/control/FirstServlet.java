package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FirstServlet
 */
public class FirstServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FirstServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FirstServlet의 doGet() 호출됨");	// tomcat server console
		// client side의 console.log => chrome web browser console
		
		// getParameter()의 인자값: name
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		System.out.println(id + " : " + pwd);
		
		// name은 같은데 값은 여러개인 경우: getParameterValues / ex. checkbox
		String []cArr = request.getParameterValues("c");
		if(cArr != null) {	// 1개 이상 선택되었을 때
			// NullPointException 회피
			for(int i=0; i<cArr.length; i++) {
				System.out.println(cArr[i]);
			}
		}
		
		// 응답
		// 1. 응답형식 지정하기: MIME(마임) 값 활용
		// https://developer.mozilla.org/ko/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types
		response.setContentType("text/html;charset=utf-8"); // MIME 타입 지정 + 한글 인코딩 설정
		// 2. 응답 출력 스트립 얻기
		PrintWriter out = response.getWriter();
		// 3. 응답하기
		/*
		out.print("<h1>" + id + "님 로그인 성공!</h1>");
		if(cArr != null) {	// 1개 이상 선택되었을 때
			// NullPointException 회피
			for(String c : cArr) {
				// out.println(c);	// 응답 내용이 줄바꿈 됨. 줄바꿈이 되서 브라우저에 나타나지는 않음
				// 네트워크 비용만 늘어날 뿐 print와 println은 차이가 없기 때문에  print 사용 권장
				out.print(c);
				out.print("<br>");
			}
		}
		*/
		// js script도 작성 가능
		// location.href를 통해 layout.html로 이동
		//out.print("<script>alert('로그인성공'); location.href='./jq/layout.html';</script>");
		//out.print(id + "님 로그인 성공!");
		
		String str = "{\"status\":1, \"id\":\""+id+"\"}";	
		// status를 로그인 실패 여부로 설정한다 
		out.print(str);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FirstServlet의 doPost() 호출됨");
		
		
	}

}
