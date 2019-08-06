package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.service.BoardService;
import com.my.vo.Board;

public class BoardReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;

    public BoardReplyServlet() {
        this.service = new BoardService();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String str_parent_no = request.getParameter("parent_no");
		int parent_no = Integer.parseInt(str_parent_no);
		String board_subject = request.getParameter("board_subject");
		String board_writer = request.getParameter("board_writer");
		String board_content = request.getParameter("board_content");
		String board_pwd = request.getParameter("board_pwd");
		
		Board board = new Board();
		board.setParent_no(parent_no);
		board.setBoard_subject(board_subject);
		board.setBoard_writer(board_writer);
		board.setBoard_content(board_content);
		board.setBoard_pwd(board_pwd);
		String result = service.boardReply(board);
		request.setAttribute("result", result);
		
		String path = "/result.jsp"; // /servlet10/result.jsp
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
