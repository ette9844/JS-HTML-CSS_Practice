<%@page contentType="text/html;charset=UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>layout.html</title>
<style>
header>h1 {
	text-align: center;
}
/*자식 선택자를 이용한 선택*/
header>nav>ul>li {
	display: inline-block;
	margin: 10px;
}

header>nav>ul>li>a {
	text-decoration: none;
}

header>nav>ul>li>a:hover {
	background-color: yellow;
	font-weight: bold;
}

section {
	margin: 30px 30px 30px 30px;
	width: 90%;
	min-height: 500px;
	position: relative;
}

.original {
	float: left;
	width: 70%;
	height: 100%;
}

article {
	border: 1px solid;
	height: 30%;
	overflow: auto;
}

aside {
	border: 1px solid;
	background-color: teal;
	/*display: inline-block;*/
	float: right; /* 오른쪽 정렬 */
	/*width: 200px;*/
	width: 20%;
	min-height: 500px;
	text-align: center;
}

footer {
	background-color: gray;
	color: white;
	text-align: center;
	margin-top: 10px;
	padding: 15px;		/*안쪽 여백: padding*/
	position: absolute;
	bottom: 0;
	left: 0;	/*left=0 , right=0 == width:100%*/
	right: 0;	/*=0픽셀*/
}
</style>
</head>
<body>
  <header style="background-color: #123456; border: 1px solid;">
	<h1 style="color: white">KITRI</h1>
	<!-- 메뉴 생성하기 nav(navigator) -->
	<nav style="background-color: white;">
	  <jsp:include page="menu.jsp"/>
	</nav>
  </header>

  <section>
	<div class="original">
	  <article>
		내용1<br> 내용1<br> 내용1<br> 내용1<br> 내용1<br> 내용1<br>
		내용1<br> 내용1<br> 내용1<br> 내용1<br> 내용1<br> 내용1<br>
		내용1<br> 내용1<br> 내용1<br> 내용1<br> 내용1<br> 내용1<br>
	  </article>
	  <article>내용2</article>
	</div>

	<!-- 사이드바 광고 등에 사용되는 semantic tag -->
	<aside>광고</aside>
  </section>

  <footer>주소: 서울시 구로구 디지털로 34길 연락처: 02-686-8301 </footer>
</body>
</html>