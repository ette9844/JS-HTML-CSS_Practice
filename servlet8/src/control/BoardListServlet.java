package control;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.exception.NotFoundException;
import com.my.service.BoardService;
import com.my.vo.Board;
import com.my.vo.PageBean;

public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;
	       
    public BoardListServlet() {
        service = new BoardService();
    }

    // GET / POST 방식 가리지 않음
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String currentPage = request.getParameter("currentPage");
		int intCurrentPage = 1;
		if(currentPage != null) {
			// NullPointException 회피
			intCurrentPage = Integer.parseInt(currentPage);
		}
		
		try {
			PageBean<Board> pb = service.boardList(intCurrentPage);
			request.setAttribute("pb", pb);
			request.setAttribute("status", 1);	// 정상 처리
		} catch (NotFoundException e) {
			e.printStackTrace();
			request.setAttribute("status", -1);	// 실패
		}
		// jsp로 데이터를 넘겨주고 forward
		String path = "/boardlistresult.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
