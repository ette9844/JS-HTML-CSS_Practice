package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.exception.NotFoundException;
import com.my.service.BoardService;
import com.my.vo.Board;

public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;

    public BoardDetailServlet() {
    	service = new BoardService();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String board_no = request.getParameter("board_no");
		int intBoardNo = 0;
		if(board_no != null) {
			// NullPointException 회피
			intBoardNo = Integer.parseInt(board_no);
		}
		try {
			Board board = service.boardDetail(intBoardNo);
			request.setAttribute("board", board);
			request.setAttribute("status", 1);	// 정상 처리
		} catch (NotFoundException e) {
			e.printStackTrace();
			request.setAttribute("status", -1);	// 실패
		}
		// jsp로 데이터를 넘겨주고 forward
		String path = "/boarddetailresult.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
