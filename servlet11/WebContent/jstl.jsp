<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl.jsp</title>
</head>
<body>
<!-- 변수 선언 -->
<c:set var="num" value="1"/>
c:set으로 선언한 num 변수: ${num}
<hr>
<c:set var="foo" value="${param.foo}"/>
c:set으로 선언한 foo 변수: ${foo}<br><!-- 빈문자열 -->
<%--c:set으로 선언한 foo 변수 + 1: ${foo + 1}<br><!-- 빈문자열 foo가 자동으로 숫자 타입으로 바뀌어서 연산 참여 --%>
<!-- url?foo=9 로 요청했을 경우, 10이 출력 됨 -->
<hr>

<!-- if -->
<c:if test="${param.foo == 'hello'}">환영합니다</c:if> <!-- test속성값에는 조건문을 EL표기법으로 써줘야함 -->
<%--c:if test="${param.foo == null || param.foo == ''}"--%>
<c:if test="${empty param.foo}">
  <%--요청 전달 데이터가 없는 경우 empty로 간결하게 표현 가능--%>
  <span style="color:red">요청 전달 데이터 foo가 없습니다.</span>
</c:if>

<!-- choose -->
<c:choose>
  <c:when test="${param.foo == 'hello'}">환영합니다</c:when>
  <c:when test="${param.foo == 'bye'}">안녕히가세요</c:when>
  <c:otherwise>${param.foo}</c:otherwise>
</c:choose>
<hr>

<!-- forEach -->
<c:forEach var="i" begin="1" end="5" step="2">
${i}<br>
</c:forEach>
<hr>
<c:forEach var="i" begin="1" end="5"> <%--step생략 은 step="1"과 동일 --%>
${i}<br>
</c:forEach>
<hr>
1~10까지의 합:
<c:set var="sum" value="0"/>
<c:forEach var="i" begin="1" end="10">
  <%--값 누적 = 변수 새로 선언 --%>
  <%--변수 중복이 아닌 이미 선언되어있는 변수의 값을 바꾸는 것임 --%>
  <c:set var="sum" value="${sum + i}"/>
</c:forEach>
${sum}
<hr>
<c:forEach var="i" begin="1" end="20" step="3" varStatus="status"> 
<%--varStatus 객체타입을 참조할 변수 이름을 적는다 --%>
${status.count} : ${i}<br> <%--.count: 반복 횟수를 알수 있다. --%>
</c:forEach>
<hr>
<%
List<String> list = new ArrayList<>();
list.add("one"); list.add("two"); list.add("three");
request.setAttribute("list", list);
%>
<c:forEach var="s" items="${requestScope.list}">
${s}<br>
</c:forEach>
<hr>
<%
Map<String, Integer> map = new HashMap<>();
map.put("one", 1); map.put("two", 2); map.put("three", 3);
request.setAttribute("map", map);
%>
<c:forEach var="obj" items="${requestScope.map}">
  ${obj.key} : ${obj.value}<br>
</c:forEach>
</body>
</html>