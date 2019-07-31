package com.my.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.my.dao.PostDAO;
import com.my.exception.NotFoundException;
import com.my.vo.Post;

public class PostService {
	private PostDAO dao;

	public PostService() {
		dao = new PostDAO();
	}

	public String search(String doro) {
		Map<String, String> postMap = new HashMap<String, String>();
		
		try {
			postMap = dao.selectByDoro(doro);
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		JSONArray jsonArr = new JSONArray();
		Set<String> keys = postMap.keySet();
		for(String key : keys) {
			// 도로명 주소가 존재할 때
			String[] attrs = postMap.get(key).split("/");
			// JSON객체 생성
			JSONObject json= new JSONObject();
			json.put("zipcode", attrs[0]);
			json.put("addr1", attrs[1]);
			json.put("addr2", attrs[2]);
			json.put("buildingno", key);			
	
			// 배열에 추가
			jsonArr.add(json);
		}
		return jsonArr.toString();
	}
}
