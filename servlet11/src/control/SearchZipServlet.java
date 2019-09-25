package control;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.service.PostService;

public class SearchZipServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PostService service;
	
	public SearchZipServlet() {
		service = new PostService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청 데이터 수신
		String doro = request.getParameter("doro");
		String str = service.search(doro);
	
		request.setAttribute("result", str);

		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
