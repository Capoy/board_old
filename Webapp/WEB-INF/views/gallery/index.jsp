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
	href="${pageContext.request.contextPath }/assets/css/gallery.css">
<script>

var page = 0;

var render = function ( vo, mode ) {
	
	var user_no = "${userVO.user_no}";
	
	var htmls = "<div id='g-" + vo.gallery_no + "' class='upload boxshadow'>" + 
				"<div class='upload_bar'>" + "<div class='writer'>" +
		 	    vo.id + "<span>&nbsp;(" + vo.reg_date + ")</span></div>";
		 	    
		 	    if (user_no == vo.user_no) {
					htmls += "<div class='delete_gal'><i data-no='" + vo.gallery_no + "' class='glyphicon glyphicon-remove'></i></div>";
				}
		 	    
			    htmls += "</div><div class='upload_content'><div class='image_comment'>" + vo.content.replace( /\n/gi, "<br>") + 
			    "</div>" + "<div class='upload_img'>" + "<a target='_blank' href='${pageContext.request.contextPath }/files/" + 
			    vo.saveFileName + "'><img src='${pageContext.request.contextPath }/files/" + vo.saveFileName + "'></div></a>" +
			    "<div data-no='" + vo.gallery_no + "' class='comments_btn'><span class='glyphicon'>&#xe111;</span><span id='tc-" + 
			    vo.gallery_no + "'>&nbsp;Comment (" + vo.list.length +  ")</span></div></div>" +
			    "<div class='clear'></div><div id='cl-" + vo.gallery_no + "' class='comments' style='display:none'>";
			    
			    if (user_no != "") {
			    	htmls += "<div><input type='text' data-no='" + vo.gallery_no + "' class='form-control input-sm comments_smt' placeholder='Enter Comment'></div>";
			    }
				 
				htmls += "<table class='comments_list' id='comments-" + vo.gallery_no + "'></table></div></div>";
	
	if( mode == true ) {
		
		$( "#upload_list" ).prepend( htmls );
	} else {
		
		$( "#upload_list" ).append( htmls );
	}		    
}

var comments_render = function ( vo, mode ) {
	
	var user_no = "${userVO.user_no}";
	
	var htmls = "<tr class='comment' id='gc-" + vo.comments_no + "'>" + "<td class='gal_comment'><b>" + vo.id + "</b>&nbsp;" + 
				"<span>(" + vo.reg_date + ")</span>" + "<br>" + vo.content.replace( /\n/gi, "<br>") + "</td>";
				if (user_no == vo.user_no) {
					htmls += "<td class='delete_comments'><i data-no='" + vo.comments_no + "' data-no2='" + vo.gallery_no + 
					"' class='glyphicon glyphicon-remove'></i></td>";	
				}
				
				htmls += "</tr>";
				
	if ( mode == true ) {
		
		$( "#comments-" + vo.gallery_no ).prepend( htmls );
		
	} else {
		
		$( "#comments-" + vo.gallery_no ).append( htmls );
	}
}

var fetchList = function() {
	
	++page;
	
	$.ajax({
		url: "${pageContext.request.contextPath }/gallery/api/list?p=" + page,
		type: "get",
		dataType: "json",
		async: true,
		success: function( list ) {
			
			$( list ).each( function( index, gvo ){
				
				render( gvo, false );
				
				$( gvo.list ).each( function(index, cvo) {
					
					comments_render( cvo, false );
				});
			});
		}, 
		
		error: function( jqXHR, status, e ) {
			
			console.error( status + ":" + e );
		}
	});
		
}

$(function() {
	
	$("#upload_btn").click(function() {
		
	if ( $("[name=gallery_img]").val() == "" || $("[name=content]").val() == "" ) {
		
		return;
	}
	
	var formData = new FormData();
	var user_no = "${userVO.user_no}";
	
	formData.append( "gallery_img", $("[name=gallery_img]")[0].files[0] );
	formData.append( "content", $("[name=content]").val() );
	formData.append( "user_no", user_no );
	
	$.ajax({
		url : "${pageContext.request.contextPath }/gallery/api/insert",
		data : formData,
		type : "post",
		processData : false,
		contentType : false,

		dataType : "json",
		success : function( vo ) {
				render( vo, true );
				
				$("[name=gallery_img]").val("");
				$("[name=content]").val("");
				$("#img").html("");
				
				var htmls = "<div><label for='gallery_img' class='glyphicon glyphicon-plus'></label></div>";
				
				$("#img").html(htmls);
				
			},
	
		error : function(jqXHR, status, e) {
			
			console.error(status + ":" + e);
		}
			
		 });
	
	});
	
	$( "#upload_list" ).on( "click", ".delete_gal i", function() {
		
		var no = $(this).attr( "data-no" );
		
		$.ajax({
			url : "${pageContext.request.contextPath }/gallery/api/delete",
			type : "GET",
			data : { no : no },
			
			dataType : "json",
			success : function(gallery_no) {
				
						$("#g-" + gallery_no).remove();
				  },
			
			error : function(jqXHR, status, e) {
				
						console.error(status + ":" + e);
				}
			});
	});
	
	$("#upload_list").on( "click", ".comments_btn", function() {
		
		var no = $(this).attr( "data-no" );
	
		$( "#cl-" + no ).toggle();	
	});
	
	$("#upload_list").on( "keypress", ".comments_smt", function(e) {
	
		if(e.which == 13) { 
				        
			if ( $(this).val() == "" ) {
				
				return;
			}
			
			var gallery_no = $(this).attr( "data-no" );
			var user_no = "${userVO.user_no}";
			var content = $(this).val();
			
			$.ajax({
				url : "${pageContext.request.contextPath }/gal/comments/api/insert",
				type : "POST",
				data : {
							gallery_no : gallery_no,
							user_no : user_no,
							content : content
					   },
						
				dataType : "json",
				success : function(map) {
					
							comments_render( map.vo, true );
							$(".comments_smt").val("");
							$("#tc-" + gallery_no ).html("");
							$("#tc-" + gallery_no ).html("&nbsp;Comment (" + map.commentsCount +  ")");
						},
	
			   error : function(jqXHR, status, e) {
				   
						console.error(status + ":" + e);
					   } 
			  });
			
			}
			
		});
	
	$( "#upload_list" ).on( "click", ".delete_comments i", function() {
		
		var no = $(this).attr( "data-no" );
		var gallery_no = $(this).attr( "data-no2" );
		
		$.ajax({
			url : "${pageContext.request.contextPath }/gal/comments/api/delete",
			type : "GET",
			data : { no : no, 
					 gallery_no : gallery_no
				   },
			
			dataType : "json",
			success : function(list) {
				
						$("#gc-" + list[0]).remove();
						$("#tc-" + gallery_no ).html("");
						$("#tc-" + gallery_no ).html("&nbsp;Comment (" + list[1] +  ")");
				  },
			
			error : function(jqXHR, status, e) {
				
						console.error(status + ":" + e);
				}
			});
	});
	
	$(window).scroll( function(){
		
		var $window = $(this);
		var scrollTop = $window.scrollTop();
		var windowHeight = $window.height();
		var documentHeight = $( document ).height();
		
		if( scrollTop + windowHeight + 10 > documentHeight ) {
			
			fetchList();
		}
	});
	
	fetchList();
	
});
	
</script>

</head>
<body>
	<div id="container">

		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="gallery" />
		</c:import>
		<div id="content">

			<div id="gallery">
			
			
				<c:choose>
					<c:when test="${userVO == null }">
						<div class="upload boxshadow">
							<div id="upload_top">
								
							</div>
							<div class="upload_content">
								
								<textarea wrap="hard" placeholder="You need to login." class="form-control" name="content" readonly></textarea>
								
							</div>
						</div>
					</c:when>
				
					<c:when test="${userVO != null }">
				
						<div class="upload boxshadow">
							<div id="upload_top">
								<ul>
									<li><i id="upload_btn" class="glyphicon glyphicon-ok" ></i></li>
									<li><label for="gallery_img" class="glyphicon glyphicon-picture" title="첨부"></label>
										<input type="file" id="gallery_img" name="gallery_img" style="display: none">
									</li>
								</ul>
							</div>
							<div class="upload_content">
								
								<textarea wrap="hard" placeholder="Enter Image Comment" class="form-control" name="content"></textarea>
								
								<div id="img" class="upload_img">
									
									<div>
										<label for="gallery_img" class="glyphicon glyphicon-plus"></label>
									</div>
									
								</div>
								
							</div>
						</div>
					
					</c:when>
				</c:choose>
					<div id="upload_list">
						
					</div>
				
			</div>
			
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
			
		</div>
	</div>
	
<script>	

	var upload = document.getElementsByName('gallery_img')[0],
	    holder = document.getElementById('img');
	    
	upload.onchange = function () {
	  
	 	var file = upload.files[0],
	      reader = new FileReader();
	 
	  	reader.onload = function (event) {
	  		
	    	  var img = new Image();
	    	  img.src = event.target.result;
	 
	    	  holder.innerHTML = '';
	    	  holder.appendChild(img);
	  };
	  
	  reader.readAsDataURL(file);

	};
	
</script>

</body>
</html>