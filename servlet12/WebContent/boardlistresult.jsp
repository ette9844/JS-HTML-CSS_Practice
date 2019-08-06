<%@page import="com.my.vo.PageBean"%>
<%@page import="com.my.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="contextPath.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<style>
.sub_news,.sub_news th,.sub_news td{border:0}
.sub_news a{color:#383838;text-decoration:none}
.sub_news{width:100%;border-bottom:1px solid #999;color:#666;font-size:12px;table-layout:fixed}
.sub_news caption{display:none}
.sub_news th{padding:5px 0 6px;border-top:solid 1px #999;border-bottom:solid 1px #b2b2b2;background-color:#f1f1f4;color:#333;font-weight:bold;line-height:20px;vertical-align:top}
.sub_news td{padding:8px 0 9px;border-bottom:solid 1px #d2d2d2;text-align:center;line-height:18px;}
.sub_news .date,.sub_news .no{padding:0;font-family:Tahoma;font-size:11px;line-height:normal}
.sub_news .title{text-align:left; padding-left:15px; font-size:13px;}
.sub_news .title .pic,.sub_news .title .new{margin:0 0 2px;vertical-align:middle}
.sub_news .title a.comment{padding:0;background:none;color:#f00;font-size:12px;font-weight:bold}
.sub_news > table > tbody > tr > td.title > a{cursor:pointer;}
.page_group {padding:6px 0 6px;margin-top:10px;color:#333;line-height:20px;text-align:center;width:100%;}
.page_group span{border:1px dotted;padding-right:10px;padding-left:10px;cursor:pointer;background-color:#ffffff;}
span.underline{border:1px solid;text-decoration:underline;font-weight:bold;background-color:#e0e0eb}
span.prev{border:1px solid;}
span.next{border:1px solid;}
.board_list_head h2{float:left;}
#btWrite{float:right;margin-block-start:0.83em;margin-block-end:0.83em;margin-inline-start: 0px;margin-inline-end:0px;}
</style>
<script>
$(function(){
	var startPage = $("li.start").val();
	var endPage = $("li.end").val();
	var maxPage = $("li.max").val();
	
	var $spanArr = $("div.page_group > span:not(.prev, .next)");
	// page 버튼 클릭 리스너
	$spanArr.click(function(){
		var pageNum = $(this).html();
		$.ajax({
			url: "${contextPath}/boardlist",
			data: "currentPage=" + pageNum,
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
	});
	
	// prev 버튼 클릭 리스너
	var $prevObj = $("span.prev");
	$prevObj.click(function(){
		var prevPage = startPage - 1;
		$.ajax({
			url: "${contextPath}/boardlist",
			data: "currentPage=" + prevPage,
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
	});
	// next 버튼 클릭 리스너
	var $nextObj = $("span.next");
	$nextObj.click(function(){
		var nextPage = endPage + 1;
		$.ajax({
			url: "${contextPath}/boardlist",
			data: "currentPage=" + nextPage,
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
	});
	
	console.log("startPage="+startPage+", endPage="+endPage +", maxPage="+maxPage);
	// prev, next 버튼 숨김 여부
	if(startPage == 1){
		$prevObj.hide();
	}
	if(endPage == maxPage){
		$nextObj.hide();
	}
	
	
	// 게시글 클릭 리스너
	var $boardArr = $("div.sub_news > table > tbody > tr > td.title");
	$boardArr.on("click", function(){
		var board_no = $(this).prev("td.no").html();
		console.log(board_no + "  클릭됨");
		$.ajax({
			url: "${contextPath}/boarddetail",
			data: "board_no=" + board_no,
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
		return false;
	});
	
	// 글쓰기 버튼 클릭 리스너
	var $btWriteObj = $("#btWrite");
	$btWriteObj.click(function(){
		$.ajax({
			url: "${contextPath}/boardwrite.jsp",
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
	});
});
</script>
</head>
<body>
<div class="sub_news">
<div class="board_list_head">
<h2>자유게시판</h2><button id="btWrite">게시글 작성</button>
</div>
<c:set var="status" value="${requestScope.status}"/>
<c:if test="${status != 1}">
게시물 목록이 없습니다.
</c:if>
<table class="sub_news" border="1" cellspacing="0" summary="게시판의 글제목 리스트">
<caption>게시판 리스트</caption>
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
<c:set var="pb" value="${requestScope.pb}"/>
<c:set var="currentPage" value="${pb.currentPage}"/>
<c:set var="maxPage" value="${pb.maxPage}"/>
<c:set var="startPage" value="${pb.startPage}"/>
<c:set var="endPage" value="${pb.endPage}"/>
<c:set var="list" value="${pb.list}"/>

<c:forEach var="b" items="${list}">
  <tr>
    <td class="no">${b.board_no}</td>
    <td class="title">
      <c:if test="${b.level != 1}">
        <c:forEach begin="1" end="${b.level - 1}">
          <!-- 들여쓰기 -->
	      &nbsp;&nbsp;&nbsp;
        </c:forEach>
        └
      </c:if>
      <a>${b.board_subject}</a>
      <%--<a>${fn:substring(b.board_subject, 0, 6)}</a>--%> <%--글자수 초과시 끊기--%>
    </td>
    <td class="name">${b.board_writer}</td>
    <%--<td class="date">${b.board_time}</td>--%>
    <td class="date"><fmt:formatDate value="${b.board_time}" pattern="MM.dd hh:mm:ss"/></td>
  </tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="page_group">
<ul style="display:none;">
  <li class="start" value="${startPage}"></li>
  <li class="end" value="${endPage}"></li>
  <li class="max" value="${maxPage}"></li>
</ul>
<span class="prev">Prev</span>&nbsp;&nbsp;
<c:forEach var="i" begin="${startPage}" end="${endPage}">
  <c:choose>
    <c:when test="${i == currentPage}">
      <span>${i}</span>&nbsp;&nbsp;
    </c:when>
    <c:otherwise>
      <span class="underline">${i}</span>&nbsp;&nbsp;
    </c:otherwise>
  </c:choose>
</c:forEach>
<span class="next">Next</span>
</div>
</body>