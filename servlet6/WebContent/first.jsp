<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%--page directive, 페이지 지시자 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first.jsp</title>
<script> // 서버에서 실행되는 코드 아님. out.write로 문자열로 변환되어 전송된다. 클라이언트 웹브라우저에서 실행.(응답 후에 실행됨)
var now = new Date();
//alert(now);
</script>
</head>
<body>
첫번째 JSP 입니다.
<div>
  <h3>JSP 구성요소</h3>
  <ul>
    <li>html요소</li>
      <!-- html 주석 : out.write의 인자가 된다-->
    </li>
    <li>JSP 요소
      <%--jsp 주석 : jsp.java파일이 만들어 질때 제외됨. out.write의 인자 x--%>
      <%--보안상 jsp 주석을 사용하는 것을 권장. : 페이지 소스 보기에 jsp 주석이 표기되지 않음--%>
      <ol>
        <li>scripting 요소</li>
          <ul>
            <li>scriptlet: _jspService()내부에 저장될 자바구문: 요청시마다 처리될 구문
            <br>
            <% int num = 1;	// _jspService()내부에 선언되는 지역 변수
               // System.out.println(num);
               out.print(num);
             %><br>
             <% out.print(request.getParameter("opt"));
             %><br>
             <% out.print(new java.util.Date());
             %></li>
            <li>expression: _jspService()내부에 저장될 자바구문, 
            	out.print메서드가 자동 호출 됨
            <%=num %>, <%=request.getParameter("opt") %>, <%=new java.util.Date() %></li>
            <li>declaration: _jspService() 외부에 저장될 자바구문, 멤버 필드나 메서드
            <%!
            void m(){ //out.println("mmm"); 
            }
            int num; // 인스턴스 변수, _jspInit()에서 자동 0으로 초기화(int)
            %>
            num = <%=num %> 	<%--지역 변수값이 우선이기 때문에 15 출력 : _jspService 호출이 종료될 때 소멸--%>
            , <%=this.num %>  	<%--인스턴스 변수 : 객체가 소멸될때 같이 소멸--%>
            </li>
          </ul>
        <li>directive 요소</li>
          <ol>
            <li>page directive(페이지 지시자): .java 파일이 만들어질 때 필요한 정보를 설정
            <%@page contentType="text/html; charset=UTF-8" %><%-- 응답 형식 지정 --%>
            <%@page import="java.util.List"%> <%-- import 하기 --%>
            <%@page import="java.util.Map"%>
            <%@page import="java.util.Calendar"%>
            <%@page buffer="1000kb"%>
            <% List<String> list;
               Map<String, Object> map;
               Calendar calendar; 
            %>
            <%--
               for(int i=1; i<=1000; i++) {
            	   if(i%100 == 0){
            		   out.print("<br>");
            	   }
            	   out.print(i+",");
               }
            --%>
            <%--
               FileInputStream fis = null;
               String fileName = "a.txt";
               try{
  	             fis = new FileInputStream(fileName);
               } catch(FileNotFoundException e){
            	 // out.print(e.getMessage()); // 정상 내용과 예외 내용이 합쳐져서 출력
            	 // 기존 페이지의 내용을 지우고 예외를 출력하는 페이지로 이동
            	 request.setAttribute("exception", e);
            	 String path = "err.jsp";
            	 
            	 // jsp.java파일에 servlet 패키지가 import 되어있기때문에 RequestDispatcher는 import하지않아도 작동
            	 RequestDispatcher rd = request.getRequestDispatcher(path);
            	 rd.forward(request, response);
               }
            --%>
            <%@page errorPage="err.jsp" %>
            <%--
               FileInputStream fis = null;
               String fileName = "a.txt";
  	           fis = new FileInputStream(fileName);
            --%>
            </li>
            <li>include directive: 
         	   <%@include file="jq/menu.html"%>
            </li>
            <li>taglib directive: </li>
          </ol>
        <li>action tag 요소
          <ol>
            <li>standard action tag</li>
                -include tag
                <jsp:include page="jq/menu.html"></jsp:include>
            <li>custom action tag</li>
          </ol>
        </li>
      </ol>
    </li>
  </ul>
</div>
</body>
</html>