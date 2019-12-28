<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loading...</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Serif+KR&display=swap"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<style>
#loader {
	position: absolute;
	top: calc(50% - 20px);
	left: calc(50% - 20px);
}

@keyframes loader {
            0% { left: -100px }
            100% { left: 110%; }
        }
#box {
	width: 50px;
	height: 50px;
	background: #fff;
	animation: animate .5s linear infinite;
	position: absolute;
	top: 0;
	left: 0;
	border-radius: 3px;
}

@keyframes animate {
            17% { border-bottom-right-radius: 3px; }
            25% { transform: translateY(9px) rotate(22.5deg); }
            50% {
                transform: translateY(18px) scale(1,.9) rotate(45deg) ;
                border-bottom-right-radius: 40px;
            }
            75% { transform: translateY(9px) rotate(67.5deg); }
            100% { transform: translateY(0) rotate(90deg); }
        } 
#shadow {
	width: 50px;
	height: 5px;
	background: #000;
	opacity: 0.1;
	position: absolute;
	top: 59px;
	left: 0;
	border-radius: 50%;
	animation: shadow .5s linear infinite;
}

@
keyframes shadow { 50% {
	transform: scale(1.2, 1);
}
}
body {
	background: #6997DB;
	overflow: hidden;
}

h4 {
	position: absolute;
	bottom: 20px;
	left: 20px;
	margin: 0;
	font-weight: 200;
	opacity: .5;
	font-family: sans-serif;
	color: #fff;
}

#title {
	font-family: 'Noto Serif KR', serif;
	font-weight: bold;
	font-size: 1.5rem;
	text-align: center;
	margin-top: 250px;
}

#nickInput {
	width: 100%;
}

#nickname {
	margin:auto;
	width: 90%;
}

#nickModal {
	font-family: 'Noto Sans KR', sans-serif;
}

#chatIn {
	background-color: #4678ab;
	color: #faf7f0;
}

#result {
	font-weight: bold;
	margin-top: 10px;
}
</style>
<body>
	<div id="loader" class="col-12 col-md-4">
		<div id="shadow"></div>
		<div id="box"></div>
	</div>
	<div id="title">
		<p>번역채팅에 오신 걸 환영합니다.</p>
	</div>
	
	<form id="frmModal" action="chat.chat" method="post" >
		<div class="modal" id="nickModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
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
		window.onload = function () {
			// 모달 창 이벤트
			setTimeout("$('#nickModal').modal('show')", 3000);
			$('#nickModal').modal({
				backdrop : 'static',
				keyboard : false
			});
// 			$("#nickInput").focus(function() {
// 				$("#result").attr('hidden', true);
// 			});
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
			// 모달 창 이벤트 끝
		}
	</script>
</body>
</html>