package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 요청 방식에 구애 받지 않고 처리하겠다 -> service method override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 응답 송신
		// 1. 응답 형식 지정하기. MIME 값 활용
		response.setContentType("text/html;charset=utf-8");
		// 2. 응답출력스트림 얻기
		PrintWriter out = response.getWriter();
		// 3. 응답하기
		String str = (String) request.getAttribute("result");
		// 기존 페이지의 request와 forwarding된 페이지의 request는 같다
		// request는 servlet간의 공유 객체라고 볼 수 있다
		out.print(str);
	}

}
