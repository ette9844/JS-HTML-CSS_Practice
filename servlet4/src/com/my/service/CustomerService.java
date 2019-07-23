package com.my.service;

import com.my.dao.CustomerDAO;
import com.my.exception.NotFoundException;
import com.my.vo.Customer;
import com.my.vo.Post;

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
		
		String str = "{\"status\":\""+status+"\", \"id\":\""+id+"\"}";
		return str;
	}
	
	public String dupchk(String id) {
		int status = -1;	// id 중복 실패
		try {
			dao.selectById(id);
			status = 1;		// id 중복 성공
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		String str = "{\"status\":\"" + status + "\"}";
		return str;
	}
	
	public String join(String id, String pwd, String name, String addr, String buildingno) {
		int status = -1;	// 가입 실패
		// Customer 객체 생성
		Customer c = new Customer();
		c.setId(id); 
		c.setPwd(pwd); 
		c.setName(name); 
		c.setAddr(addr); 
		
		Post p = new Post();
		p.setBuildingno(buildingno);
		c.setPost(p);
		
		try {
			dao.insertCustomer(c);
			status = 1;		// 가입 성공
		} catch(NotFoundException e) {
			e.printStackTrace();
		}
		
		String str = "{\"status\":\"" + status + "\"}";
		return str;
	}
}
