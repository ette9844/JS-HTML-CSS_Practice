<%@page import="com.my.vo.Customer"%>
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
         	   <%@include file="jq/menu.jsp"%>
            </li>
            <li>taglib directive: </li>
          </ol>
        <li>action tag 요소: html 사이에서 scriptlet 열고 닫고 하면 유지보수가 힘들다.
        <br>scriptlet expression 대신 html과 동일하게 tag를 사용하자는 의도에서 만들어짐.
        <br>*: 의도는 좋았으나, useBean, set/getProperty tag는 확장성이 떨어진다.
          <ol>
            <li>standard action tag</li>
                -include tag: RequestDispatcher의 include()호출과 같은 효과, 다른 페이지 포함
                <jsp:include page="jq/menu.jsp"></jsp:include>
                <hr>
                -forward tag: RequestDispatcher의 forward()호출과 같은 효과, 다른 페이지로 이동
                <%--jsp:forward page="jq/menu.jsp"/--%>
                <br>이 페이지는 MVC 구조를 사용하고있기 때문에, jsp는 forward함수(controller 역할)를 사용하지 않는다.
                <br>jsp는 뷰어의 역할에 충실. jsp가 controller인 경우가 거의 없기 때문에 사용할 일이 별로 없다.
                <hr>
                -*useBean tag: 주석처리 된 태그의 역할을 하는 태그
                <jsp:useBean class="com.my.vo.Customer" id="c" scope="request"/>
                <%--com.my.vo.Customer c = (Customer)request.getAttribute("c");
                  if(c == null){
                  	c = new Customer();
                  	request.setAttribute("c", c);
                  }
                --%>
                <hr>
                -*setProperty / getProperty tag: 주석처리 된 태그의 역할을 하는 태그
                <jsp:setProperty name="c" property="pwd" value="p3"/>
                <%--c.setPwd("p3");--%>
                <jsp:getProperty name="c" property="pwd"/>
                <%--=c.getPwd()--%>
                
                <%--*: 확장성이 떨어짐 => EL, JSTL로 보완 
                <jsp:getProperty name="c" property="post"/><%--아래 코드와 동일한 기능의 tag를 만들 수 없다--%>
                <%--=c.getPost().getZipcode() --%>
            <li>custom action tag</li>
          </ol>
        </li>
      </ol>
    </li>
  </ul>
</div>
</body>
</html>