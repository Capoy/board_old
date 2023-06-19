<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="header">
	<div id="header_bar">
		<div>
			<ul>
				<li><a href="${pageContext.request.contextPath }/main"><span>Y</span>site</a></li>
				<li>FOR THE BEST PROGRAMMER</li>
			</ul>
		</div>
	</div>

	<div id="header_nav" class="boxshadow">
		<ul>
			<c:choose>
				<c:when test="${userVO == null }">
					<li><a href="#" title="회원가입" class="glyphicon glyphicon-plus" id="join"></a></li>
					<li><a href="#" title="로그인" class="glyphicon glyphicon-log-in" id="login"></a></li>
				</c:when>
				
				<c:otherwise>
					<li><a href="#" title="회원정보 수정" class="glyphicon glyphicon-user" id="modify"></a></li>
					<li><a href="${pageContext.request.contextPath }/user/logout" title="로그아웃" class="glyphicon glyphicon-log-out"></a></li>
					<li id="success">Hello! <b>${userVO.id }</b></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>

<c:choose>
	<c:when test="${userVO == null }">
		<c:import url="/WEB-INF/views/user/join.jsp" />
		<c:import url="/WEB-INF/views/user/login.jsp" />
	</c:when>
	
	<c:otherwise>
		<c:import url="/WEB-INF/views/user/modify.jsp" />
	</c:otherwise>
</c:choose>
