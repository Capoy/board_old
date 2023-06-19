<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- The Modify Modal -->
<div id="modify_modal" class="modal">
	<!-- Modify Modal content -->
	<div class="modal-content3">
		<span class="close" data-dismiss="modal">&times;</span>
		<h2>MODIFY</h2>
		
			<div id="modify">
				<form id="modify_form" method="post" action="${pageContext.request.contextPath }/user/modify">
					<label><b>ID</b></label>
					
					<br/>
					
					<input type="text" class="form-control input-sm" placeholder="Enter ID" name="id" value="${userVO.id }" readonly>
					
					<br/>
						
					<label><b>Password</b></label>
					
					<div id="pw_msg" class="msg"></div>
					
					<br/>
					
					<input type="password" class="form-control input-sm" placeholder="Enter Password" id="password" name="password" required>
					
					<br/>
					
					<input type="hidden" id="pw_check" value="n">
						
					<label><b>Password confirmation</b></label>
					
					<br/>
					
					<input type="password" class="form-control input-sm" placeholder="Re-enter Password" id="re_password" required>
					
					<br/>
						
					<label><b>Email</b></label>
					
					<div id="email_msg" class="msg"></div>
					
					<br/>
					
					<input type="email" class="form-control input-sm" placeholder="Enter Email" name="email" value="${userVO.email }" required>
					
					<br/>
					
					<input type="hidden" id="email_check" value="y">
					
					<button type="submit" class="btn btn-default btn-sm" id="modify_btn">Modify</button>
					
					<div id="modify_msg" class="msg"></div>
					
				</form>
			</div>
	</div>
</div>

<script>

$("#modify").click(function() {
	
	var user_email = $("[name=email]").val();
		
	$("#modify_modal").modal();
	
	$("#password, #re_password").focusout(function() {
		
		var password = $("#password").val();
		var password_text = /[\S]{4,12}/g;
		var re_password = $("#re_password").val();
		
		if(password != "" && password_text.test(password) == false) {
			
			$("#pw_check").val("n");
			$("#pw_msg").css("color", "red");
			$("#pw_msg").html("&nbsp;(패스워드는 4-12자만 가능합니다.)");
			
			return;
			
		} else if (password != re_password && re_password != "") {
			
			$("#pw_check").val("n");
			$("#pw_msg").css("color", "red");
			$("#pw_msg").html("&nbsp;(패스워드를 다시 확인해주세요.)");
			
			return;
			
		} else if (password != "" && password == re_password) {
			
			$("#pw_check").val("y");
			$("#pw_msg").css("color", "green");
			$("#pw_msg").html("&nbsp;(사용 가능한 패스워드입니다.)");
			
			return;
			
		} else {
			
			$("#pw_msg").html("");
			
		}
	});

	$("[name=email]").focusout(function() {
		
		var email = $("[name=email]").val();
		var email_text = /[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})/ig;
		
		if (email != "" && email_text.test(email) == false ) {
			
			$("#email_check").val("n");
			$("#email_msg").css("color", "red");
			$("#email_msg").html("&nbsp;(이메일 형식에 맞지 않습니다.)");
			
			return;		
		}

		$.ajax({
			url : "${pageContext.request.contextPath }/user/api/emailcheck",
			type : "POST",
			data : {
				email : email
			},

			dataType : "text",
			success : function(result) {
				
				if (email != user_email && result == "false") {
					
					$("#email_check").val("n");
					$("#email_msg").css("color", "red");
					$("#email_msg").html("&nbsp;(이미 사용 중인 이메일입니다.)");
					
				} else if (email != "") {
					
					$("#email_check").val("y");
					$("#email_msg").css("color", "green");
					$("#email_msg").html("&nbsp;(사용 가능한 이메일입니다.)");
					
				}
			},

			error : function(jqXHR, status, e) {
				
				console.error(status + ":" + e);
			}
		});
	});

	$("#modify_btn").click(function() {
		
		var pw_check = $("#pw_check").val();
		var email_check = $("#email_check").val();

		if (pw_check != "y" || email_check != "y") {
			
			$("#modify_msg").css("color", "red");
			$("#modify_msg").html("&nbsp;Modify Failed.");
			
			return false;
			
		} else {
			
			return true;
		}
	});
});
	
$(".close").click(function() {
	
	$("#modify_form")[0].reset();
	$("#pw_msg, #email_msg, #modify_msg").html("");	
});

</script>