<%@page import="com.my.vo.PageBean"%>
<%@page import="com.my.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%String contextPath = request.getContextPath(); %>
<style>
.sub_news,.sub_news th,.sub_news td{border:0}
.sub_news a{color:#383838;text-decoration:none}
.sub_news{width:100%;border-bottom:1px solid #999;color:#666;font-size:12px;table-layout:fixed}
.sub_news caption{display:none}
.sub_news th{padding:5px 0 6px;border-top:solid 1px #999;border-bottom:solid 1px #b2b2b2;background-color:#f1f1f4;color:#333;font-weight:bold;line-height:20px;vertical-align:top}
.sub_news td{padding:8px 0 9px;border-bottom:solid 1px #d2d2d2;text-align:center;line-height:18px;}
.sub_news .date,.sub_news .hit{padding:0;font-family:Tahoma;font-size:11px;line-height:normal}
.sub_news .title{text-align:left; padding-left:15px; font-size:13px;}
.sub_news .title .pic,.sub_news .title .new{margin:0 0 2px;vertical-align:middle}
.sub_news .title a.comment{padding:0;background:none;color:#f00;font-size:12px;font-weight:bold}
.page_group {padding:6px 0 6px;margin-top:10px;color:#333;line-height:20px;text-align:center;width:100%;}
.page_group span{border:1px dotted;padding-right:10px;padding-left:10px;cursor:pointer;background-color:#ffffff;}
span.underline{border:1px solid;text-decoration:underline;font-weight:bold;background-color:#e0e0eb}
span.prev{border:1px solid;}
span.next{border:1px solid;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
			url: "<%=contextPath%>/boardlist",
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
			url: "<%=contextPath%>/boardlist",
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
			url: "<%=contextPath%>/boardlist",
			data: "currentPage=" + nextPage,
			success: function(data){
				$("section").empty();
				$("section").html(data);
			}
		});
	});
	
	// prev, next 버튼 숨김 여부
	if(startPage == 1){
		$prevObj.hide();
	} else if(endPage == maxPage){
		$nextObj.hide();
	}
});
</script>
<div class="sub_news">
<h2>자유게시판</h2>
<%
int status = (Integer)request.getAttribute("status");
if(status != 1){
%>게시물 목록이 없습니다.
<%
	return;	// servlet 종료
}%>
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
<%
PageBean pb = (PageBean)request.getAttribute("pb");
int currentPage = pb.getCurrentPage();
int maxPage = pb.getMaxPage();
int startPage = pb.getStartPage();
int endPage = pb.getEndPage();
List<Board> list = pb.getList();
	
for(Board b : list){
%>
<tr>
  <td class="hit"><%=b.getBoard_no() %></td>
  <td class="title"><%
  if(b.getLevel() != 1) {
	for(int i=1; i<b.getLevel(); i++){
	  // 들여쓰기
	  %>&nbsp;&nbsp;&nbsp;<%
	}
%>└<%
  }
%>
    <a href="#"><%=b.getBoard_subject() %></a>
  </td>
  <td class="name"><%=b.getBoard_writer() %></td>
  <td class="date"><%=b.getBoard_time() %></td>
</tr>
<%
}
%>
</tbody>
</table>
</div>
<div class="page_group">
<ul style="display:none;">
<li class="start" value="<%=startPage%>"></li>
<li class="end" value="<%=endPage%>"></li>
<li class="max" value="<%=maxPage%>"></li>
</ul>
<span class="prev">Prev</span>&nbsp;&nbsp;
<%
for(int i=startPage; i<=endPage; i++){
	if(i == currentPage){
%>
<span><%=i%></span>&nbsp;&nbsp;
<%      
	} else {
%>
<span class="underline"><%=i%></span>&nbsp;&nbsp;
<%
	}	// end if
}  // end for %>
<span class="next">Next</span>
</div>