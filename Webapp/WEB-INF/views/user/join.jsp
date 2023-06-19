<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- The Join Modal -->
<div id="join_modal" class="modal">

	<!-- Join Modal content -->
	<div class="modal-content2">
		<span class="close" data-dismiss="modal">&times;</span>
		<h2>JOIN</h2>

		<div id="profile_img"></div>

		<div id="join">

			<form id="join_form" method="post" action="${pageContext.request.contextPath }/user/join">

				<label><b>ID</b></label>
				
				<div id="id_msg" class="msg"></div>
				
				<br/>
				
				<input type="text" class="form-control input-sm" placeholder="Enter ID" id="join_id" name="id" required>
				
				<br/>
				
				<input type="hidden" id="id_check" value="n">

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
				
				<input type="email" class="form-control input-sm" placeholder="Enter Email" name="email" required>
				
				<br/>
				
				<input type="hidden" id="email_check" value="n">

				<button type="submit" class="btn btn-default btn-sm" id="join_btn">Join</button>
				
				<div id="join_msg" class="msg"></div>

			</form>

		</div>

	</div>

</div>

<script>

	$("#join").click(function() {
		
		$("#join_modal").modal();
	});

	// Join Check
	$("#join_id").focusout(function() {
		
		var id = $("#join_id").val();
		var id_text = /[a-z0-9]{4,12}/g; 
		
		if (id != "" && id_text.test(id) == false ) {
			
			$("#id_check").val("n");
			$("#id_msg").css("color", "red");
			$("#id_msg").html("&nbsp;(아이디는 4-12자의 영문 소문자, 숫자만 가능합니다.)");
			
			return;
			
		} else  {
			
			$("#id_msg").html("");	
		}

		$.ajax({
			url : "${pageContext.request.contextPath }/user/api/idcheck",
			type : "POST",
			data : {
				id : id
			},

			dataType : "text",
			success : function(result) {
				
				if (result == "false") {
					
					$("#id_check").val("n");
					$("#id_msg").css("color", "red");
					$("#id_msg").html("&nbsp;(이미 사용 중인 아이디입니다.)");
					
				} else if (id != "") {
					
					$("#id_check").val("y");
					$("#id_msg").css("color", "green");
					$("#id_msg").html("&nbsp;(사용 가능한 아이디입니다.)");				
				}
			},

			error : function(jqXHR, status, e) {
				
				console.error(status + ":" + e);
			}
		});
	});
	
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
		var email_text = /[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})/g;
		
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
				
				if (result == "false") {
					
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

	$("#join_btn").click(function() {
		
		var id_check = $("#id_check").val();
		var pw_check = $("#pw_check").val();
		var email_check = $("#email_check").val();

		if (id_check != "y" || pw_check != "y" || email_check != "y") {
			
			$("#join_msg").css("color", "red");
			$("#join_msg").html("&nbsp;Join Failed.");
			
			return false;
			
		} else {
			
			return true;
		}
	});
	
	$(".close").click(function() {
		
		$("#join_form")[0].reset();
		$("#id_msg, #pw_msg, #email_msg, #join_msg").html("");		
	});
	
</script>