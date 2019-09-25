package com.my.vo;

public class Customer {
	private String id;
	private String pwd;
	private String name;
	// private String buildingno;	// POST 테이블의 자료를 참조해야함
	// 테이블 간의 관계를 클래스로 나타내줄 필요가 있다.
	private Post post;	// 다 대 1 관계: post 객체 하나
	private String addr;
	
	// 생성자
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Customer(String id, String pwd, String name, Post post, String addr) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.post = post;
		this.addr = addr;
	}
	
	// getter / setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
}
