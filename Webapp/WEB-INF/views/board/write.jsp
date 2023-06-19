<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/css/board.css">

</head>
<body>
	<div id="container">

		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="board" />
		</c:import>

		<div id="content">

			<div id="board">

				<form method="post" action="${pageContext.request.contextPath }/board/write">
					
					<div id="board_top">
						
						<ul>
							<li>
								<a href="${pageContext.request.contextPath }/board" class="glyphicon glyphicon-remove"></a>
							</li>
							<li>
								<button type="submit" class="btnIcon">
									<span class="glyphicon glyphicon-ok"></span>
								</button>
							</li>
						</ul>

					</div>

					<div id="board_content" class="boxshadow">
						<div>
							
							<table>
								<tr>
									<th>TITLE</th>
									<td><input type="text" name="title" class="form-control"
										required></input></td>
								</tr>
								<tr>
									<th>CONTENT</th>
									<td><textarea name="content" class="form-control" wrap="hard" required></textarea></td>
								</tr>
							</table>
						</div>
					</div>
				</form>

			</div>

			<c:import url="/WEB-INF/views/includes/footer.jsp" />

		</div>

	</div>

</body>
</html>