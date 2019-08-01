<%@page import="com.my.vo.Post"%>
<%@page import="com.my.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>el.jsp</title>
</head>
<body>
<%--http://localhost:8080/servlet9/el.jsp?foo=hello --%>
<%--http://localhost:8080/servlet9/el.jsp --%>
<h3>요청 전달 데이터</h3>
[Expression] foo : <%=request.getParameter("foo") %> <!-- 두번째 요청시 null이 출력 됨 -->
<%--
String a = request.getParameter("foo");
out.print(a);	// null일 경우 print 메서드의 효과로 'null' 출력
--%><br>
[Expression Language] foo: ${param.foo} <%-- null일 경우 빈 문자열""로 변환해서 출력해 줌 --%>

<hr>
<% // 아래 작업은 Controller[서블릿]에서 해야 할 일
Customer c = new Customer();
c.setId("id1"); c.setPwd("p1");
Post p = new Post();
p.setBuildingno("987654321");
c.setPost(p);

request.setAttribute("c", c);
%>
<h3>요청 속성</h3> 
[Expression] 고객의 아이디 : 
<%=((Customer)request.getAttribute("c")).getId() %><br>
[Expression Language] 고객의 아이디 :
${requestScope.c.id}	<%--코딩 보다 코드량을 절약--%>
<hr>
[Expression Language] 고객의 건물 관리 번호 : 
${requestScope.c.post.buildingno}

<hr>
<%--pageContext는 javaBean형태 --%>
${pageContext.request} <%-- request객체 != requestScope --%><br>
웹 컨텍스트 경로 : <br>
[Expression] :
${pageContext.request.contextPath}<br>
[Expression Language] request객체.contextPath :
${pageContext.request.contextPath}<br>

이미지 파일의 실제 경로 : <br>
[Expression] : 
<%=application.getRealPath("images/movie_image.jpg") %><br>
[Expression language] : 지원안함 
<%--${pageContext.servletContext.리얼 패스 없음} --%>
<%--Expression을 사용해야하는 경우도 있음. --%>
</body>
</html>