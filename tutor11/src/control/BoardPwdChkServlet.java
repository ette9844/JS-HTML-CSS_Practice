package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.service.BoardService;

public class BoardPwdChkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;
	public BoardPwdChkServlet() {
		service = new BoardService();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String str_board_no = request.getParameter("board_no");
		int board_no = Integer.parseInt(str_board_no);
		String board_pwd = request.getParameter("board_pwd");
		String result = service.boardPwdChk(board_no, board_pwd);
		request.setAttribute("result", result);
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
