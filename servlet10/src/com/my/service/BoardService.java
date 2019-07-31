package com.my.service;

import java.util.List;

import com.my.dao.BoardDAO;
import com.my.exception.NotFoundException;
import com.my.vo.Board;
import com.my.vo.PageBean;

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

	public Board boardDetail(int no) throws NotFoundException {
	
		Board board = dao.selectByBoardNo(no);
		return board;
	}
}
