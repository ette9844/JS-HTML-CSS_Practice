<%@page contentType="text/html; charset=UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
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

$(function(){
	var $menuArr = $("header>nav>ul>li>a");
	$menuArr.click(function(){
		var url = $(this).attr('href');
		console.log(url);
		switch(url){
		case '../boardlist':
			loadMenu(url, loadBoard);
			break;
		case 'login.html':
			loadMenu(url, loadLogin);
			break;
		case 'join.html':
			loadMenu(url, loadJoin);
			break;
		case 'display.html':
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
  <li><a href="../boardlist">게시판</a></li>
  <li><a href="#">공지사항</a></li>
  <li><a href="login.html">로그인</a></li>
  <li><a href="join.html">가입</a></li>
  <li><a href="display.html">시군구</a></li>
</ul>