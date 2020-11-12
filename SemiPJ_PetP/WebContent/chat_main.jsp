<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>채팅채팅</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
 var lastSEQ = 0;  
 
function chatListFunction(type){
   	 $.ajax({
  		  method: "post",
  		  url: "./chatListServlet",
  		  data: {
  			  listType: type,
  			  
  		 },
  	     success: function(data){
  	    	 if(data == "") 
  	    		 return;
  	    	var parsed =JSON.parse(data);
  	    	var result = parsed.result;
  	    	for(var i = 0; i < result.length; i++){
  	    		addChat(result[i][0].value, result[i][1].value, result[i][2].value);
  	    	}
  	    	lastSEQ = Number(parsed.last);     
  	     }
  	   });
    }
 
 function submitFunction(){
	 var chatName = $('#chatName').val();
	 var chatContent = $('#chatContent').val();
	 $.ajax({
		  method: "post",
		  url: "./chatSubmitServlet",
		  data: {
			  
			  chatName: encodeURIComponent(chatName),
			  chatContent: encodeURIComponent(chatContent)     //encodeURIComponent 특수문자가능하게
		 },
	     success: function(result){  //전송 성공
	    	 if(result == 1){
	    		 autoClosingAlert('#successMessage', 1500); //1.5초뒤에 지워지게    
	    	 }else if(result == 0){
                 autoClosingAlert('#dangerMessage', 1500);  //글자 0이면 실패 둘다입력하세요
	    	 }else {
                 autoClosingAlert('#warningMesseage', 1500); 
	    	 }
	     }
	 });
	    $('#chatContent').val('');  //전송후 지우기
	 }
         function autoClosingAlert(selector, delay){
        	 var alert = $(selector).alert();
        	 alert.show();
        	 window.setTimeout(function() {alert.hide()},delay);
         }
         
         function addChat(chatName, chatContent, regdate){
        	
          	
        	 $('#chatList').append('<div class="row">' +
        			 '<div class="col-lg-12">' +
                     '<div class="media">' +
                     '<a class="pull-left" href="#">' +           
                     '<img class="media-object img-circle" src="ano.png" alt="">' +  //사진
                     '</a>' +
                     '<div class="media-body">' +
                     '<h4 class="media-heading">' +
                     chatName +
                     '<span class="small pull-right">' +
                     regdate + 
                     '</span>' +
                     '</h4>' +
                     '<p>' +
                     chatContent +
                     '</p>' +
                     '</div>' +
                     '</div>' +
                     '</div>' +
                     '</div>' +
                     '<hr>');
        	 
        	$('#chatList').scrollTop($('#chatList')[0].scrollHeight);    //채팅입력시마다 스크롤 제일밑으로내리기
         }
         
         window.onload = function() { 
        	 var type="ten";
        	 chatListFunction(type);              //새로고침시 불러오기
        	 getInfiniteChat();  
        };
         function getInfiniteChat(){
        	 setInterval(function(){             //1초마다 불러오기
        		 chatListFunction(lastSEQ);
        	 }, 500);
         }   
</script>
 <style type="text/css"> 
 #send{
      background:#fffff9;
      
      
 }
 #chatContent{
     background: #fffff9;
     
 }
 #chatName{
     background: #fffff9;
     
 }
 #room{
     background: #f5f5dc;
     
 }
#chatName{
 max-width: 80%;

}
#w{

padding-left: 30px;  /*왼쪽 30px띄우기*/
}
#i{
padding-right: 30px; /*오른쪽 30px띄우기*/
}
</style>  
</head>
<body>
<jsp:include page="form/header02.jsp" flush="true" />   
<br><br><br><br><br><br><br>
    <div class="container">
      <div class="container bootstrap snippet">
       <div class="row">
           <div class="col-xs-12">
             <div class="portlet portlet-default">
             <div class="portlet-heading" id="room">
               <div class="portlet-title">
                 <h4><i class="fa fa-circle text-yellow">펫톡</i></h4>
               </div>
               <div class="clearfix"></div>
             </div>
                <div id="chat" class="panel-collapse in">
                  <div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 400px;">
                  </div>
                <div>
                    <div class="row">
                     <div class="form-group col-xs-4" id="w">
                               <input  style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름(최대 8글자)" maxlength="8">             
                   </div>
                   </div>
                        <div class="row" style="height: 90px">
                       <div class="form-group col-xs-10" id="w">
                         <textarea  style="height: 80px;" id="chatContent" class="form-control" placeholder="메세지를 입력하세요" maxlength="100"></textarea>
                     </div>
                     <div class="form-group col-xs-2" id="i">
                         <button id="send" style="height: 60px; width: 100px; font-size: 20px;"  type="button" class="btn btn-outline-dark" onclick="submitFunction();">전송</button>
                            <div class="clearfix"></div>                                              
                     </div>
                  </div>
                </div>
             </div>
           </div>
       </div>
      </div>
    </div>
    <div class="alert alert-success" id="successMessage" style="display: none;">
        <strong>메세지 전송에 성공하였습니다.</strong>
    </div>
    <div class="alert alert-danger" id="dangerMessage" style="display: none;">
        <strong>이름과 내용을 모두 입력해 주세요.</strong>
    </div>
        <div class="alert alert-warning" id="warningMessage" style="display: none;">
        <strong>데이터베이스 오류가 발생했습니다.</strong>
    </div>    
    </div>
</body>
</html>