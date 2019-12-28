<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
  <title>Talk English</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="resources/style.css">
</head>
<body>

<div class="messaging">
  <div class="inbox_msg">
	<div class="mesgs">
	  <div class="msg_history" id="msg_history">
	  </div>
	  <div class="type_msg">
		<div class="input_msg_write">
		  <textarea class="write_msg" id="new_msg" placeholder="Type a message"></textarea>
		  <button class="msg_send_btn" type="button"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
		</div>
	  </div>
	</div>
  </div>
</div>

<script>
	window.onload = function(e){
	};

    var webSocket = new WebSocket("ws://121.130.75.35/AndroidChat/websocket");
    function disconnect(){
        webSocket.close();
    }           
    webSocket.onopen = function(e){
    	onOpen(e); 
    }
    webSocket.onclose = function(e){}
    
    webSocket.onmessage = function(e){ 
        var currentTime = formatAMPM(new Date());
        console.log("현재 시각 : " + currentTime);
        console.log("서버로부터 온 값 : " + e.data);
        var data = JSON.parse(e.data);
        console.log("클라이언트 파싱값 : " + data);
        console.log("클라이언트 파싱값 : " + data.nickname);
        var translatedMsg = data.translatedMsg
        
            if(data.nickname == "me"){
                console.log("내가 보낸 메세지");
                $("#msg_history").append("<div class='outgoing_msg'>" +
                                   "<div class='sent_msg'>" +
                                   "<p>"+translatedMsg+"</p>" +
                                   "<span class='time_date'>"+currentTime+"</span>" +
                                   "</div></div>");
            }else{
                console.log("받은 메세지");
                $("#msg_history").append("<div class='incoming_msg'>" +
                                   "<div class='incoming_msg_nick'>"+data.nickname+"</div>" +
                                   "<div class='received_msg'>" + 
                                   "<div class='received_withd_msg'>" +
                                   "<p>"+translatedMsg+"</p>" +
                                   "<span class='time_date'>"+currentTime+"</span>" +
                                   "</div></div></div>");
            }
            $("#msg_history").scrollTop($(document).height());
            $("#new_msg").scrollTop($(document).height());
        }
    
    $('.write_msg').keydown(function(key){ //엔터 터치 시
        if(key.keyCode == 13){
            var new_msg = $("#new_msg").val();
            new_msg = new_msg.replace(/\n/g, "");
            console.log(new_msg);
            var writer = "${nickname}"; //현재 사용자 닉네임 셋팅
            webSocket.send(JSON.stringify({msg: new_msg, writer: writer})); //서버에 메세지 보내기
            $("#new_msg").val(""); //인풋창 비워주기
            console.log(new_msg.length) ;
            return false;
        }
    });
    
    $('.msg_send_btn').on("click", function(){ //전송버튼 터치 시
    	 var new_msg = $("#new_msg").val();
         new_msg = new_msg.replace(/\n/g, "");
         console.log(new_msg);
         var writer = "${nickname}"; //현재 사용자 닉네임 셋팅
         webSocket.send(JSON.stringify({msg: new_msg, writer: writer})); //서버에 메세지 보내기
         $("#new_msg").val(""); //인풋창 비워주기
    });    
    
    function onOpen(event) {
    	$("#msg_history").append(
        		"<div class='newUser'>"+
        		"<div class='notice_newUser'>"+
        	    "<span class='newUser_nickname'>${nickname}</span>"+
        	    "<span class='notice'>님이 입장하였습니다.</span>"+
        	    "</div>"+
        	    "</div>"
    )};
    
    function formatAMPM(date) {
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0'+minutes : minutes;
        var strTime = hours + ':' + minutes + ' ' + ampm;
        return strTime;
    };
</script>
</body>
</html>