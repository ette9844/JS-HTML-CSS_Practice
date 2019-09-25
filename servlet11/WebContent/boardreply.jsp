<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<style>
.board,.board th,.board td{border:0}
.board a{color:#383838;text-decoration:none}
.board{width:100%;border-bottom:1px solid #999;color:#666;font-size:12px;table-layout:fixed}
.board caption{display:none}
.board th{padding:5px 0 6px;border-top:solid 1px #999;border-bottom:solid 1px #b2b2b2;background-color:#f1f1f4;color:#333;font-weight:bold;line-height:20px;vertical-align:top}
.board td{padding:8px 0 9px;border-bottom:solid 1px #d2d2d2;text-align:center;line-height:18px;}
.board .date,.board .no{padding:0;font-family:Tahoma;font-size:11px;line-height:normal}
.board .title{text-align:left; padding-left:15px; font-size:13px;}
.board .title .pic,.board .title .new{margin:0 0 2px;vertical-align:middle}
.board .title a.comment{padding:0;background:none;color:#f00;font-size:12px;font-weight:bold}
.board > table > tbody > tr > td.title > a{cursor:pointer;}
.board td input{width: 90%;border:none;}
.page_group {padding:6px 0 6px;margin-top:10px;color:#333;line-height:20px;text-align:center;width:100%;}
.page_group span{border:1px dotted;padding-right:10px;padding-left:10px;cursor:pointer;background-color:#ffffff;}
span.underline{border:1px solid;text-decoration:underline;font-weight:bold;background-color:#e0e0eb}
span.prev{border:1px solid;}
span.next{border:1px solid;}
textarea{
	width:90%;
	min-height:200px;
	border:0;
	background:clear
	overflow-x:hidden; 
	overflow-y:auto;
	resize: none;
}
</style>
<script>
$(function(){
	// 작성 버튼 클릭 리스너
	$("form").submit(function(){
		$.ajax({
			url: "${contextPath}/boardreply",
			method: "post",
			data: $(this).serialize(),
			success: function(data){
				var jsonObj = JSON.parse(data);
				if(jsonObj.status == 1){
					alert("답글이 등록되었습니다.");
					var $boardObj = $("header>nav>ul>li>a[href='${contextPath}/boardlist']");
					$boardObj.trigger('click');
				} else {
					alert("답글 작성에 실패하였습니다.");
				}
			}
		});
		return false;
	});
});
</script>
<form class="board">
<h2>${param.board_no}번 글의 답글 쓰기</h2>
<input type="hidden" name="parent_no" value="${param.board_no}">
<table class="board" border="1" cellspacing="0" summary="게시판의 글제목 리스트">
  <caption>게시글 상세</caption>
  <colgroup>
    <col width="100" style="padding-left:30">
	<col>
  </colgroup>
  <tbody>
    <tr>
	  <th scope="col">제목</th>
	  <td><input type="text" name="board_subject" placeholder="글 제목"></td>
	</tr>
	<tr>
	  <th scope="col">작성자</th>
	  <td><input type="text" name="board_writer" placeholder="작성자"></td>
	</tr>
	<tr>
	  <th scope="col">비밀번호</th>
	  <td><input type="password" name="board_pwd" placeholder="글 비밀번호"></td>
	</tr>
	<tr>
	  <th scope="col">내용</th>
	  <td><textarea rows="5" cols="20" name="board_content"></textarea></td>
	</tr>
  </tbody>
</table>
  <button type="submit">작성</button>
  <button type="reset">클리어</button>
</form>