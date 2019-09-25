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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String board_no = request.getParameter("board_no");
		String board_pwd = request.getParameter("board_pwd");
		int intBoardNo = 0;
		if(board_no != null) {
			// NullPointException 회피
			intBoardNo = Integer.parseInt(board_no);
		}
		
		String str = service.boardPwdChk(intBoardNo, board_pwd);
		request.setAttribute("result", str);
			
		// jsp로 데이터를 넘겨주고 forward
		String path = "result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
