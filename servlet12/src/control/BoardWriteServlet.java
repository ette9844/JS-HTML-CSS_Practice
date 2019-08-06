package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.service.BoardService;
import com.my.vo.Board;

public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;

	public BoardWriteServlet() {
		service = new BoardService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Board board = new Board();
		board.setBoard_subject(request.getParameter("board_subject"));
		board.setBoard_writer(request.getParameter("board_writer"));
		board.setBoard_pwd(request.getParameter("board_pwd"));
		board.setBoard_content(request.getParameter("board_content"));

		String str = service.boardWrite(board);
		request.setAttribute("result", str);
		
		// jsp로 데이터를 넘겨주고 forward
		String path = "result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
