package com.my.service;

import java.util.ArrayList;

import com.my.dao.PostDAO;
import com.my.exception.NotFoundException;
import com.my.vo.Post;

public class PostService {
	private PostDAO dao;
	
	public PostService() {
		dao = new PostDAO();
	}
	
	public String search(String doro) {
		int cnt = 0;
		String str = "";
		ArrayList<Post> postList = new ArrayList<Post>();
		
		try {
			postList = dao.selectByDoro(doro);
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		for(Post p : postList) {
			// 도로명 주소가 존재할 때
			String zipcode = p.getZipcode();
			String addr1 = p.getAddr1();
			String addr2 = p.getAddr2();
			String buildingno = p.getBuildingno();
			
			if(cnt != 0)
				str += ", ";
			else		// 배열 열림
				str += "[";
			str += "{\"zipcode\":\"" + zipcode
					+ "\", \"addr1\":\"" + addr1 
					+ "\", \"addr2\":\"" + addr2 
					+ "\", \"buildingno\":\"" + buildingno + "\"}";
			cnt++;
		}
		if(cnt != 0)	// 배열 닫힘
			str += "]";
		return str;
	}
}
