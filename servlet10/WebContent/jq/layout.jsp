<%@page contentType="text/html;charset=UTF-8" %>
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
	padding-right: 30px;
	width: 90%;
	height: 500px;
	/*높이는 비율 조절이 불가능하기 때문에 px로 고정된 길이를 줘야한다 */
	/*height: 50%;*/
	/*section이 부모 역할을 할 때, 
	absolute 포지션인 자식은 부모를 상대 기준 삼아서 위치값을 조절*/
	position: relative;
}

.original {
	float: left;
	width: 70%;
	height: 100%;
}

article {
	/*display: inline-block;   	무조건 왼쪽 정렬로 됨 */
	/*float: left;				왼쪽 오른쪽 정렬 선택 가능 */
	border: 1px solid;
	/*width: 300px;				길이를 고정된 px로 설정하는 것 보다는 비율로 표현하는게 반응성이 좋다 */
	
	height: 30%; /*높이를 상위 요소에서 미리 설정해두면 하위 요소에서 비율을 쓸수 있다*/
	/*article의 영역에서 내용이 벗어날 경우에만 스크롤 표시 */
	overflow: auto;
	margin-top: 10px;
}

aside {
	border: 1px solid;
	background-color: teal;
	/*display: inline-block;*/
	float: right; /* 오른쪽 정렬 */
	/*width: 200px;*/
	width: 20%;
	height: 100%;
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