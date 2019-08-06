package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.exception.NotFoundException;
import com.my.service.BoardService;
import com.my.vo.Board;
import com.my.vo.PageBean;

// 서블릿 메서드화 시키기에는 너무 길고 많아짐 -> POJO 클래스화
// Plain Old Java Object: 일반적인 java 클래스
// POJO 클래스는 servlet의 spec을 지키지 않아도 된다
public class BoardController {
	private BoardService service;
	
	public BoardController() {
		service = new BoardService();
	}

	public String boardDetail(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
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
		return path;
	}

	public String boardList(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
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
		return path;
	}
}
