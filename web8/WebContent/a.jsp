<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- a.jsp 주석 --%>
<%
// server side에서 실행되는 java 코드
try{
  Thread.sleep(5*1000);	// 5초간 일시중지
%>응답 결과입니다.
<%
}catch(Exception e){
  	
}
%>