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
                     '<img class="media-object img-circle" src="images/icon.png" alt="">' +
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
        	 
        	$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
         }
         
         window.onload = function() { 
        	 var type="ten";
        	 chatListFunction(type);
        	 getInfiniteChat();  
        };
         function getInfiniteChat(){
        	 setInterval(function(){
        		 chatListFunction(lastSEQ);
        	 }, 1000);
         }   
         
          
            
     	
     
     
</script>
</head>
<body>
    <div class="container">
      <div class="container bootstrap snippet">
       <div class="row">
           <div class="col-xs-12">
             <div class="portlet portlet-default">
             <div class="portlet-heading">
               <div class="portlet-title">
                 <h4><i class="fa fa-circle text-green">채팅방</i></h4>
               </div>
               <div class="clearfix"></div>
             </div>
                <div id="chat" class="panel-collapse in">
                  <div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 300px;">
                  </div>
                <div class="portlet-footer">
                    <div class="row">
                     <div class="form-group col-xs-4">
                               <input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8">             
                   </div>
                   </div>
                        <div class="row" style="height: 90px">
                       <div class="form-group col-xs-10">
                         <textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메세지를 입력하세요" maxlength="100"></textarea>
                     </div>
                     <div class="form-group col-xs-2">
                         <button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
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
     <button type="button" class="btn btn-default pull-right" onclick="chatListFuntion('ten'); ">이전내용불러오기</button> 
</body>
</html>