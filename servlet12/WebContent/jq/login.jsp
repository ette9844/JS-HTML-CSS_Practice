<%@page contentType="text/html; charset=UTF-8" %>
<%@include file="../contextPath.jsp"%>
<style>
span {
  width: 200px;
  margin-right: 30px;
}
form, h2 {
  margin-left: 30px;
}
input{
  margin-right: 30px;
  margin-bottom: 10px;
}
</style>
<script>
$(function(){
	$("button[type=button]").click(function(){
		// menu중 가입 메뉴 객체 찾기
		// 페이지 검사 > 우클 > copy > copy selector
		var $menuArr = $("header > nav > ul > li > a");
		for(var i=0; i<$menuArr.length; i++){
			var aObj = $menuArr[i];	// js 객체
			if($(aObj).attr('href') =='join.html'){
				$(aObj).trigger('click');
				break;
			}
		}
	});
	
	$("form").submit(function(){
		// ajax 요청
		$.ajax({
			url: '../login',
			method: 'POST',
			// ajax에서는 form내부의 input data가 자동 전송되지 않음
			data: $("form").serialize(),
			success: function(data){
				// client와 server의 스펙을 맞춰줘야한다
				// data에 script태그가 응답되면 script태그 안에 script가 들어가 제대로 작동하지 않음
				// server에서는 단순한 결과를 응답하게 하고 js에서 처리해주는 것이 권장
				var jsonObj = JSON.parse(data);
				var msg = jsonObj.id + "님 로그인";
				if(jsonObj.status == '1') {
					msg += "성공";
					alert(msg);
					location.href = "layout.jsp";
				} else {
					msg += "실패";
					alert(msg);
				}
				// 이러한 규약을 사전에 잘 정해둬야한다
			}
		});
		
		return false;
	});
});
</script>
<h2>로그인</h2>
<form>
  <span>ID</span><input type="text" name="id" required placeholder="ID를 입력해주세요"><br>
  <span>비밀번호</span><input type="password" name="pwd" required placeholder="비밀번호를 입력해주세요"><br>
  <input type="checkbox" name="c" value="1">ONE&nbsp;&nbsp;
  <input type="checkbox" name="c" value="2">TWO&nbsp;&nbsp;
  <input type="checkbox" name="c" value="3">THREE<br>
  <button type="submit">로그인</button>	<!-- form tag내부 type을 설정하지 않은 버튼: submit -->
  <button type="button">회원가입</button>
</form>
