<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Loading...</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/styleLoader.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

</head>
<body>
	<div id="loader" class="col-12 col-md-4">
		<div id="shadow"></div>
		<div id="box"></div>
	</div>
	<div id="title">
		<p>번역채팅에 오신 걸 환영합니다.</p>
	</div>
	
	<form id="frmModal" action="${pageContext.request.contextPath}/chat.chat" method="post" >
		<div class="modal" id="nickModal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" style="font-weight: bold;">닉네임 등록</h5>
					</div>
					<div class="modal-body" id="nickDiv">
						<input type="text" id="nickname" name="nickname"
							placeholder="채팅에서 사용할 닉네임을 입력해 주세요.">
						<p id="result" hidden></p>
					</div>
					<div class="modal-footer">
						<button type="button" id="chatIn" class="btn">채팅방 입장</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script>
			setTimeout(modalShow, 2000);
			function modalShow(){
				$('#nickModal').modal({
	 				backdrop : 'static',
	 				keyboard : false
	 			});
			}
			$("#chatIn").on("click", function() {
// 				var newNick = $("#nickInput").val();
				$("#result").attr('hidden', false);

// 				if ($("#id").html() != newNick) {
					$("#result").html("사용가능한 닉네임입니다.");
					$("#result").css("color", "green");
// 					$("#nickname").html(newNick);
					$("#chatIn").attr('disabled', true);
					setTimeout(" $('#nickModal').modal('hide')", 1500);
					$("#frmModal").submit();
// 					location.href= "${pageContext.request.contextPath}/chat.chat";
// 				} else {
// 					$("#result").html("중복된 닉네임입니다.");
// 					$("#result").css("color", "red");
// 				}
			});
	</script>
</body>
</html>