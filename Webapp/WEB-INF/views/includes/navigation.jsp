<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="main_nav" class="boxshadow">
	<ul>
		<c:choose>
			<c:when test="${param.menu == 'main' }">
				<li><a href="${pageContext.request.contextPath }/board" title="게시판">BOARD</a></li>
				<li><a href="${pageContext.request.contextPath }/gallery/api" title="갤러리">GALLERY</a></li>
			<!--  		
				<li><a href="#">MENU</a></li>
				<li><a href="#">MENU</a></li>
				<li><a href="#">MENU</a></li>
			-->
			</c:when>

			<c:when test="${param.menu == 'board' }">
				<li><a href="${pageContext.request.contextPath }/board" title="게시판" class="selected">BOARD</a></li>
				<li><a href="${pageContext.request.contextPath }/gallery/api" title="갤러리">GALLERY</a></li>
			<!--  		
				<li><a href="#">MENU</a></li>
				<li><a href="#">MENU</a></li>
				<li><a href="#">MENU</a></li>
			-->
			</c:when>
			
			<c:when test="${param.menu == 'gallery' }">
				<li><a href="${pageContext.request.contextPath }/board" title="게시판">BOARD</a></li>
				<li><a href="${pageContext.request.contextPath }/gallery/api" title="갤러리" class="selected">GALLERY</a></li>
			<!--  		
				<li><a href="#">MENU</a></li>
				<li><a href="#">MENU</a></li>
				<li><a href="#">MENU</a></li>
			-->
			</c:when>
		</c:choose>
	</ul>
</div>