package com.my.service;

import java.util.List;

import com.my.dao.BoardDAO;
import com.my.exception.NotFoundException;
import com.my.vo.Board;

public class BoardService {
	private BoardDAO dao;
	public BoardService() {
		dao = new BoardDAO();
	}
	
	// json 형태로 변환하는 역할과 예외처리를 jsp에 넘기는 구조
	public List<Board> boardList() throws NotFoundException{
		
		return dao.select();
	}
}
