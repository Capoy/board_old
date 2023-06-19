<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("newLine", "\n");
%>
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
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"
	type="text/javascript"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	type="text/javascript"></script>
	
<script>

var render = function ( vo, mode ) {
	
	var user_no = "${userVO.user_no}";
	
	var html = "<tr class='comment' id='" + vo.comments_no +"'><th>" + vo.id + "<br><span>(" + vo.reg_date + ")</span></th><td>" + 
				vo.content.replace( /\n/gi, "<br>") + "<td class='delete_comment'>";

	if (user_no == vo.user_no) {
				
		html += "<a href='" + vo.comments_no + "' class='glyphicon glyphicon-remove'></a>";
				
	}

	html += "</td></tr>";
	
	if( mode == true ) {
				
		$("#comments_list").prepend(html);
	
	} else {
		
		$("#comments_list").append(html);
		
	}
}

var fetchList = function() {
	
	var board_no = ${boardVO.board_no};
	
	$.ajax({
		url : "${pageContext.request.contextPath }/comments/api/list",
		type : "GET",
		data : { no : board_no },

	    dataType : "json",
	    success : function(list) {
	    	
					$(list).each(function(index, vo) {
						
						render( vo, false );					

					});
					
				  },

	   error : function(jqXHR, status, e) {
		   
				 console.error(status + ":" + e);
				 
			   }
	 });
	
}

$(document).ready(function() {	 
	
	$("#comments_btn").click(function() {
		
		var content = $("[name=content]").val();
		var user_no = $("[name=user_no]").val();
		var board_no = ${boardVO.board_no};
	
		$.ajax({
				url : "${pageContext.request.contextPath }/comments/api/insert",
				type : "POST",
				data : {
							content : content,
							user_no : user_no,
							board_no : board_no
					   },
	
				dataType : "json",
				success : function(vo) { 
							
							render( vo, true );
							
							$("[name=content]").val("");
	
						},
	
			   error : function(jqXHR, status, e) {
				   
							console.error(status + ":" + e);
					   } 
			  });
	});
	
	$(document).on("click", ".delete_comment a", function(event) {
		
			event.preventDefault();
		
			var comments_no = $(this).attr("href");
		
			$.ajax({
				url : "${pageContext.request.contextPath }/comments/api/delete",
				type : "GET",
				data : { no : comments_no },
				
				dataType : "json",
				success : function(comments_no) {
							$("#" + comments_no).remove();
					  },
				
				error : function(jqXHR, status, e) {
							console.error(status + ":" + e);
					}
			});
		
		});
	
	fetchList();
		 
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
						<c:if test="${userVO.user_no == boardVO.user_no }">
							<li>
								<a href="${pageContext.request.contextPath }/board/delete?no=${boardVO.board_no}&amp;p=${page }&amp;kwd=${kwd }"
							       title="삭제" class="glyphicon glyphicon-trash"></a>
					    	</li>
							<li>
								<a href="${pageContext.request.contextPath }/board/modify?no=${boardVO.board_no }&amp;p=${page }&amp;kwd=${kwd }"
							   	   title="수정" class="glyphicon glyphicon-edit"></a>
					    	</li>
						</c:if>
					
						<c:if test="${userVO != null && userVO.user_no != boardVO.user_no }">
							<li>
								<a href="${pageContext.request.contextPath }/board/reply?no=${boardVO.board_no }&amp;p=${page }&amp;kwd=${kwd }"
							   	   title="답글" class="glyphicon glyphicon-share-alt"></a>
							</li>
						</c:if>
						
							<li>
								<a href="${pageContext.request.contextPath }/board?p=${page }&amp;kwd=${kwd }"
						   	   	   title="목록" class="glyphicon glyphicon-list"></a>
							</li>	
					</ul>
				</div>
				
				<div id="board_content" class="boxshadow">
					<div>
						<h5>
							<span>${boardVO.title}</span> (${boardVO.id }, ${boardVO.reg_date })
						</h5>
						<p>${fn:replace(boardVO.content, newLine, "<br>") }</p>
					</div>
				</div>
				
				<div id="comments" class="boxshadow">
				
					<table>
						<c:if test="${userVO != null }">
							<tr>
								<th>Comment</th>
								<td><textarea class="form-control" name="content" wrap="hard" required></textarea>
									<input type="hidden" name="user_no" value="${userVO.user_no }">
								</td>
								<td>
									<button id="comments_btn" class="btn btn-default btn-sm">Submit</button>
								</td>
							</tr>
						</c:if>
					</table>
					
					<table id="comments_list">
					</table>
					
				</div>
				
			</div>
			
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
			
		</div>
		
	</div>	
	
</body>
</html>