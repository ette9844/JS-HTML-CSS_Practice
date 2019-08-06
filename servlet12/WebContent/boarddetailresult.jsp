<%@page import="com.my.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<style>
.board_content,.board_content th,.board_content td{border:0}
.board_content a{color:#383838;text-decoration:none}
.board_content{position:relative;width:100%;border-bottom:1px solid #999;color:#666;font-size:12px;table-layout:fixed}
.board_content caption{display:none}
.board_content th{padding:5px 0 6px;border-top:solid 1px #999;border-bottom:solid 1px #b2b2b2;background-color:#f1f1f4;color:#333;font-weight:bold;line-height:20px;vertical-align:top}
.board_content td{padding:8px 0 9px;border-bottom:solid 1px #d2d2d2;text-align:center;line-height:18px;}
.board_content .date,.board_content .no{padding:0;font-family:Tahoma;font-size:11px;line-height:normal}
.board_content .title{text-align:left; padding-left:15px; font-size:13px;}
.board_content .title .pic,.board_content .title .new{margin:0 0 2px;vertical-align:middle}
.board_content .title a.reply{padding:0;background:none;color:#f00;font-size:12px;font-weight:bold}
.board_content > table > tbody > tr > td.title > a{cursor:pointer;}
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
.pwdChkBox{
	display:none;
	border:1px solid;
	position:absolute;
    left:50%;
    top:50%;
    margin-left:-115px;
    padding: 30 30 30 30;
	background-color:#f1f1f4;
}
.pwdChkBox form{margin-bottom:0;}
.pwdChkBox input{width: 100px;}
.pwdChkBox span.hide{color:red;}
.hide{display:none;}
</style>
<script>
$(function() {
	var $pwdBoxObj = $(".pwdChkBox");
	var $inputObj = $(".pwdChkBox input");
	
	// 수정 버튼 클릭 리스너
	var $editObj = $("button.editBtn");
	$editObj.click(function(){
		// 비번 확인 창 show
		$pwdBoxObj.show(100);
	});
	
	// 답글 버튼 클릭 리스너
	var $replyObj = $("button.replyBtn");
	$replyObj.click(function(){
		$.ajax({
			url: "${contextPath}/boardreply.jsp",
			method: "post",
			data: "board_no=" + $(".board_content tbody tr td.no").html(),
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
	});
	
	/*****비번 확인 창 클릭 리스너*****/
	// 취소 버튼 클릭 리스너
	var $resetObj = $(".pwdChkBox button[type='reset']");
	$resetObj.click(function(){
		// input clear & hide
		$inputObj.val("");
		$pwdBoxObj.hide(100);
		$(".pwdChkBox span.hide").hide();
	});
	
	// 확인 버튼 클릭 리스너
	var $submitObj = $(".pwdChkBox button[type='submit']");
	$submitObj.click(function(){
		$.ajax({
			url: "${contextPath}/boardpwdchk",
			method: "post",
			data: $(".pwdChkBox form").serialize(),
			success: function(data){
				var jsonObj = JSON.parse(data);
				if(jsonObj.status == 1){
					// 수정 페이지로 이동
					msg = "수정 페이지로 이동";
					alert(msg);
				} else {
					// 비밀번호 불일치 구문 show
					$(".pwdChkBox span.hide").show();
				}
			}
		});
		return false;
	});
	/************************/
});
</script>
</head>
<body>
<div class="board_content">
<h2>자유게시판</h2>
<c:set var="status" value="${requestScope.status}"/>
<c:choose>
  <c:when test="${status != 1}">
	게시물 불러오기에 실패하였습니다.
  </c:when>
  <c:otherwise>
    <table class="board_content" border="1" cellspacing="0" summary="게시판의 글제목 리스트">
	  <caption>게시글 상세</caption>
	  <colgroup>
	    <col width="80" style="padding-left:30">
		<col>
		<col width="110">
		<col width="100">
	  </colgroup>
	  <thead>
		<tr>
		<th scope="col">글번호</th>
		<th scope="col">제목</th>
		<th scope="col">글쓴이</th>
		<th scope="col">날짜</th>
		</tr>
	  </thead>
	  <tbody>
	  <tr>
		<c:set var="b" value="${requestScope.board}"/>
	    <td class="no">${b.board_no}</td>
	    <td class="title">${b.board_subject}</td>
	    <td class="name">${b.board_writer}</td>
	    <td class="date"><fmt:formatDate value="${b.board_time}" pattern="MM.dd hh:mm:ss"/></td>
	  </tr>
	  <c:if test="${b.parent_no != 0}"><!-- 답글일 경우 -->
	    <tr>
	      <td>원글 번호: ${b.parent_no}</td>
	      <td colspan="3"></td>
	    </tr>
	  </c:if>
	  <tr>
	    <td colspan="4">
  		  <textarea readonly>${board.board_content}</textarea><br><br>
		</td>
	  </tr>
	  </tbody>
    </table>
    <button class="editBtn">수정</button>&nbsp;
    <button class="deleteBtn" >삭제</button>&nbsp;
    <button class="replyBtn">답글쓰기</button>
    <div class="pwdChkBox">
      <form>
        <input class="hide" type="text" name="board_no" value="${b.board_no}">
        <span>글 비밀번호: </span>
        <input type="password" name="board_pwd" placeholder="비밀번호를 입력해주세요."><br>
        <span class="hide">비밀번호가 일치하지 않습니다.</span><br>
        <button type="submit">확인</button>&nbsp;
        <button type="reset">취소</button>
      </form>
    </div>
  </c:otherwise>
</c:choose>
</div>
</body>