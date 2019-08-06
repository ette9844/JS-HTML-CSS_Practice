<%@page contentType="text/html; charset=UTF-8" %>
<%@include file="../contextPath.jsp"%>
<script>
// 메뉴가 클릭 될때마다 내용을 표시할 영역이 현업에서는 다를 수 있다. 코드는 같지만 함수를 나눈 이유.
var loadLogin = function(data){
	$("section").empty();
	$("section").html(data);
	// $("section>div>article:nth-child(1)").html(data);
};
	
var loadJoin = function(data){
	$("section").empty();
	$("section").html(data);
	// $("section>div>article:nth-child(2)").html(data);
};

var loadBoard = function(data){
	$("section").empty();
	$("section").html(data);
};

var loadMenu = function(u, callback){
	$.ajax({
		url: u,
		method: 'GET',
		success: function(data){
			callback(data);
		}
	});
};

// 현업에서는 상대 경로보다 절대 경로를 사용한다
// 상대 경로는 상위 경로가 변경되었을 때 오류를  일으킬 가능성이 있기 때문
$(function(){
	var $menuArr = $("header>nav>ul>li>a");
	$menuArr.click(function(){
		var url = $(this).attr('href');
		console.log(url);
		switch(url){
		case '${contextPath}/boardlist':
			loadMenu(url, loadBoard);
			break;
		case '${contextPath}/jq/login.jsp':
			loadMenu(url, loadLogin);
			break;
		case '${contextPath}/jq/join.html':
			loadMenu(url, loadJoin);
			break;
		case '${contextPath}/jq/display.html':
			loadMenu(url, function(data){
				$("section").empty();
				$("section").html(data);
			});
			break;
		}
		return false; // 기본 이벤트 핸들러 막기 + 이벤트 전달 중지
	});
});
</script>
<ul>
  <li><a href="${pageContext.request.contextPath}/boardlist">게시판</a></li>
  <li><a href="#">공지사항</a></li>
  <li><a href="${pageContext.request.contextPath}/jq/login.jsp">로그인</a></li>
  <li><a href="${pageContext.request.contextPath}/jq/join.html">가입</a></li>
  <li><a href="${pageContext.request.contextPath}/jq/display.html">시군구</a></li>
</ul>