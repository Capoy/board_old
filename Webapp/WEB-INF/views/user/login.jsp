<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- The Login Modal -->
<div id="login_modal" class="modal">

	<!-- Login Modal content -->
	<div class="modal-content">
		<span class="close" data-dismiss="modal">&times;</span>
		<h2>LOGIN</h2>

		<div>
			<form id="login_form">
				<label><b>ID</b></label>
				
				<br/>
				
				<input type="text"class="form-control input-sm" placeholder="Enter ID" id="login_id" name="id" required>
				
				<br/> 
				
				<label><b>Password</b></label>
				
				<br/> 
				
				<input type="password" class="form-control input-sm" placeholder="Enter Password" id="login_pw" name="password" required>
				
				<br/>
				
				<button type="submit" class="btn btn-default btn-sm" id="login_btn">Login</button>
				
				<div id="login_msg" class="msg"></div>
			</form>
		</div>
		
	</div>

</div>

<script>
	$("#login").click(function() {
		
		$("#login_modal").modal();
	});

	//Login Check
	$("#login_btn").on("click", function(event) {
		
		event.preventDefault();

		var id = $("#login_id").val();
		var password = $("#login_pw").val();

		$.ajax({
			url : "${pageContext.request.contextPath }/user/login",
			type : "POST",
			data : {
				id : id,
				password : password
			},

			dataType : "text",
			success : function(result) {
				
				location.href = "${pageContext.request.contextPath }/main";
				
			},
			error : function(jqXHR, status, e) {
				
				if(jqXHR.status == 401) {
					
					$("#login_msg").css("color", "red");
					$("#login_msg").html("&nbsp;Login Failed.");
					console.error(status + ":Login Failed.");
					return;
				}
				
				console.error(status + ":" + e);
			}
		});
	});
	
	$(".close").click(function() {
		
		$("#login_form")[0].reset();
		$("#login_msg").html("");
	});
	
</script>