package com.my.service;

import java.util.List;

import com.my.dao.BoardDAO;
import com.my.exception.NotFoundException;
import com.my.vo.Board;
import com.my.vo.PageBean;

// 각 자바 파일에 main 함수 작성을 통해 각 단위 테스팅을 할 수 있다
// 테스팅이 끝나면 꼭 main 메서드를 지우거나 comment 처리해야 함
public class BoardService {
	private BoardDAO dao;
	public BoardService() {
		dao = new BoardDAO();
	}
	
	// boardList() overload: 기능이 비슷하나 매개변수에 따라 내용만 다른 두 함수
	public com.my.vo.PageBean<Board> boardList() throws NotFoundException{
		// return dao.select(1, 10);
		return boardList(1);
	}
	
	public com.my.vo.PageBean<Board> boardList(int currentPage) throws NotFoundException{
		int cntPerPage = 3;			// 한 페이지 별 보여줄 목록 수 
		int cntPerPageGroup = 4;	// 페이지 그룹에서 보여줄 페이지 수
		int startRow = (currentPage - 1) * cntPerPage + 1;
		int endRow = currentPage * cntPerPage;
		List<Board> list = dao.select(startRow, endRow);
		
		int totalCnt = dao.count();
		int maxPage = (int)(Math.ceil((float)totalCnt/cntPerPage));
		int startPage = ((currentPage-1) / cntPerPageGroup) * cntPerPageGroup + 1;
		int endPage = startPage + cntPerPageGroup - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageBean<Board> pb = new PageBean<>();
		pb.setCurrentPage(currentPage);	// 현재 페이지
		pb.setCntPerPage(cntPerPage);	// 페이지 별 목록수
		pb.setList(list);				// 페이지 목록
		pb.setTotalCnt(totalCnt);		// 총 건수
		pb.setMaxPage(maxPage);			// 최대 페이지 수
		pb.setStartPage(startPage);
		pb.setEndPage(endPage);
		
		return pb;
	}
	
	
//	public int maxPage() throws NotFoundException {
//		int cntPerPage = 3;
//		int totalCnt = dao.count();
//		return (int)Math.ceil((float)totalCnt / cntPerPage); // 3.1 -> 4
//	}
	
//	public List<Board> boardList(int currentPage) throws NotFoundException{
//		
//		// currentPage	startRow	endRow
//		//	1			1			10
//		//	2			11			20
//		//	3			21			30
//		int cntPerPage = 3;	// 한 페이지당 보여줄 목록수
//		int startRow = (currentPage - 1) * cntPerPage + 1;
//		int endRow = currentPage * cntPerPage;
//		
//		return dao.select(startRow, endRow);
//	}
}
