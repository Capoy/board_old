<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/css/board.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>

$(document).ready(function() {
	
	$("#search_open").click(function() {
		$("#search_open").hide();
		$("#search").show();
	});


	$("#search_close").click(function() {
		$("#search").hide();
		$("#search_open").show(); 
	});
	
});

</script> 

</head>
<body>
	<div id="container">

		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="board" />
		</c:import>

		<div id="content">

			<div id="board">

				<div id="board_top">
					<ul>
						<c:if test="${userVO != null}">
							<li>
								<a href="${pageContext.request.contextPath }/board/write"
								   title="글쓰기" class="glyphicon glyphicon-pencil"></a>
							</li>
						</c:if>
					
						<li>
							<i id="search_open" class="glyphicon glyphicon-search"></i>
						</li>

						<li id="search" style="display:none">
							<form action="${pageContext.request.contextPath }/board/" method="get">
								<input type="search" placeholder="Enter Keyword" name="kwd"
									value="${map.kwd }"></input>
							</form>
							<i id="search_close" class="glyphicon glyphicon-remove"></i>
						</li>

					</ul>
				</div>

				<div id="board_content" class="boxshadow">
					<table id="board_list">
						<tr>
							<th>NO</th>
							<th>TITLE</th>
							<th>ID</th>
							<th>DATE</th>
							<th>HIT</th>
						</tr>

						<c:forEach items="${map.list }" var="vo" varStatus="status">
							<tr>
								<td>${map.totalCount - (map.page - 1)*10 - status.index}</td>
								<td><c:forEach begin="1" end="${vo.depth }">&nbsp; </c:forEach>
									
									<c:if test="${vo.depth > 0 }">
										<b>re:</b>
									</c:if>
									
								    <a href="${pageContext.request.contextPath }/board/view?no=${vo.board_no}&p=${map.page }&kwd=${map.kwd}">
										${vo.title}
									</a>
									
									<c:if test="${vo.comments_total > 0 }">
										<span id="comments_total">&nbsp;[${vo.comments_total }]</span>
									</c:if>
										
								</td>
								<td>${vo.id }</td>
								<td>${vo.reg_date }</td>
								<td>${vo.hit }</td>
							</tr>
						</c:forEach>
					</table>
				</div>

				<div id="board_bottom">

					<ul class="pagination">
						<c:choose>
							<c:when test="${map.startPage > 5 }">
								<li>
									<a href="${pageContext.request.contextPath }/board?p=${map.startPage - 1}&kwd=${map.kwd}">&laquo;</a>
								</li>
							</c:when>
						</c:choose>
						
						<c:forEach begin="${map.startPage }" end="${map.endPage }" var="page">
							<c:choose>
								<c:when test="${page == map.page }">
									<li><a class="active" href="#">${page }</a></li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="${pageContext.request.contextPath }/board?p=${page }&kwd=${map.kwd}">${page }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${map.endPage < map.totalPage }">
								<li>
									<a href="${pageContext.request.contextPath }/board?p=${map.endPage + 1 }&kwd=${map.kwd}">&raquo;</a>
								</li>
							</c:when>
						</c:choose>
					</ul>

				</div>
			</div>
			
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
			
		</div>
	</div>
	
</body>
</html>