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
	href="${pageContext.request.contextPath }/assets/css/main.css">

</head>

<c:choose>
	<c:when test="${insertResult == true}">
		<script>
			alert( "Join Success!" );	
		</script>
	</c:when>
	<c:when test="${modifyResult == true}">
		<script>
			alert( "Modify Success!" );	
		</script>
	</c:when>
</c:choose>

<body>
	<div id="container">

		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="main" />
		</c:import>
		
		<div id="content">

			<div id="main">
				
				<div id="notice" class="boxshadow">
				
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
					    <!-- Indicators -->
					    <ol class="carousel-indicators">
						      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						      <li data-target="#myCarousel" data-slide-to="1"></li>
					    </ol>
					
					    <!-- Wrapper for slides -->
					    <div class="carousel-inner">
					      <div class="item active">
						        <img src="${pageContext.request.contextPath }/assets/images/IMG_0001.jpg" style="width:100%;">
					      </div>
					
					      <div class="item">
						        <img src="${pageContext.request.contextPath }/assets/images/IMG_0002.png" style="width:100%;">
					      </div>
					    </div>
					
					  </div>
				
				</div>
				
				<div id="introduction">
					<h1>
						<span>Y</span>site
					</h1>
					<p>The site for learning the basics</p>
				</div>
				
			</div>
			
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
			
		</div>
	</div>
	
</body>
</html>