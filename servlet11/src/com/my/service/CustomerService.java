package com.my.service;

import org.json.simple.JSONObject;
import com.my.dao.CustomerDAO;
import com.my.exception.AddException;
import com.my.exception.NotFoundException;
import com.my.vo.Customer;

public class CustomerService {
	private CustomerDAO dao;

	public CustomerService() {
		dao = new CustomerDAO();
	}
	
	public String login(String id, String pwd) {
		int status = -1;	// 로그인 실패
		try {
			Customer c = dao.selectById(id);
			if(c.getPwd().equals(pwd)) {
				status = 1;	// 로그인 성공
			}
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		// 외부 java - json library를 통해 이 json문을 간단하게 작성할 수 있다
		// String str = "{\"status\":\""+status+"\", \"id\":\""+id+"\"}";
		JSONObject json = new JSONObject();
		json.put("status", status);
		json.put("id", id);
		
		return json.toString();
	}
	
	public String dupchk(String id) {
		int status = -1;	// id 중복 실패
		try {
			dao.selectById(id);
			status = 1;		// id 중복 성공
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		// String str = "{\"status\":\"" + status + "\"}";
		JSONObject json = new JSONObject();
		json.put("status", status);
		
		return json.toString();
	}
	
	public String join(Customer c) {
		int status = -1;	// 가입 실패
		
		try {
			dao.insertCustomer(c);
			status = 1;		// 가입 성공
		} catch(AddException e) {
			e.printStackTrace();
		}
		
		// String str = "{\"status\":\"" + status + "\"}";
		JSONObject json = new JSONObject();
		json.put("status", status);
		
		return json.toString();
	}
}
