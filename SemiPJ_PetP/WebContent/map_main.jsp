<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  request.setCharacterEncoding("UTF-8"); %>
<%  response.setContentType("text/html; charset=UTF-8"); %>    

<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 




<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>map_main</title>
    
    <style type="text/css">
    .customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:15px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	
	
	.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:15px;font-weight:bold;}
	.map_wrap{margin:100px 0px 30px 0px;}


	#btnme {position:absolute;top:600px;left:30px;width:62px;height:62px;z-index: 1;cursor: pointer; background: url(resources/images/myloc.png) no-repeat; overflow: hidden;}
	#btnme:hover {background-color: #fcfcfc;border: 1px solid #c1c1c1;}  
	
	
	#category {position:absolute;top:140px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
	#category li {float:left;list-style: none;width:100px;px;border-right:1px solid #acacac;padding:10px 0;text-align: center; cursor: pointer;}
	#category li.on {background: #ffe6e6;}
	#category li:hover {background: #eee;border-left:1px solid #acacac;margin-left: -1px;}
	#category li:last-child{margin-right:0;border-right:0;}
	#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
	#category li .all {background-position: 140px 0;}
	#category li .hos {background-position: 140px -45px;}
	#category li .yo {background-position: 140px -90px;}
	#category li .mi {background-position: 140px -135px;}
	#category li .res {background-position: 140px -180px;}
	#category li .park {background-position: 140px -225px;}
	#category li.on .category_bg {background-position-x:-46px;}
	
	
	<!-- 산책로 css -->
	.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
	.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
	.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
	.number {font-weight:bold;color:#ee6152;}
	.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
	.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
	.distanceInfo .label {display:inline-block;width:50px;}
	.distanceInfo:after {content:none;}
	
    </style>
 <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
    
</head>



<body>





	

	<jsp:include page="form/header02.jsp" flush="true" /> 


<div class="map_wrap">
	<div id="map" style="width:100%;height:600px; position:relative;overflow:hidden;"></div>
	<ul id="category">
	        <li id="a1" data-order="0"> 
	            <span class="category_bg all"></span>
	   	 모든정보
	        </li>       
	        <li id="a2" data-order="1"> 
	            <span class="category_bg hos"></span>
	            동물병원
	        </li>  
	        <li id="a3" data-order="2"> 
	            <span class="category_bg yo"></span>
	            애견용품
	        </li>  
	        <li id="a4" data-order="3"> 
	            <span class="category_bg mi"></span>
	            애견미용
	        </li>  
	        <li id="a5" data-order="4"> 
	            <span class="category_bg res"></span>
	  	   애견동반      
	        </li>  
	        <li id="a6" data-order="5"> 
	            <span class="category_bg park"></span>
	            공 원
	        </li>      
	    </ul>
	    
    
        <div id="btnme" onclick="setMyLoc();"></div>
    
</div>

<div id="main">
	
<hr> 
			<div class="panel">
				<div class="panel-heading" style="margin:20px;">
					<h2 class="panel-title" >산책로 게시판</h2>
					
						<button id="focusplz" onclick="drawin();">나만의 산책로 만들기</button>
					  <br><br>
				<form action="MapServlet.do"  method="post">
					 <input type="hidden" name="command" value="insertlist">
					 <input type="hidden" id="ppp" name="path" value="" >
					 <input type="hidden" id="dong" name="dong" value="">
					 
					  <table  id="writetable" style="display:none;" >
					  	<col width="80"><col width="300"><col width="70"><col width="70">
					  	<thead>
					  		<tr>
					  		<th>산책로명 : </th>
					  		<th><input type="text" id="foucsplease" name="name" placeholder="산책로 이름을 입력하세요." style="width:300px;"></th>
					  		<th><input type="submit" id="drawouts" onclick="return drawout();" value="작성"></th>
					  		<th><input type="button" value="취소" onclick="drawhide();" ></th>
					  		</tr>
					  		<tr><th colspan="4"><em>지도를 <span style="color:red;">마우스로 클릭</span>하면 선 그리기가 시작되고<br><span style="color:red;">오른쪽 마우스를 클릭</span>하면 선 그리기가 종료됩니다</em>
					  		</th></tr>
					  	</thead>
					  </table>
				</form>
					
				</div>
				<hr>
				<div class="panel-body">
					<table class="table table-hover">
					<col width="150"><col width="500"><col width="300"><col width="300"><col width="200">
						<thead>
							<tr style="text-align:center">
							<th>#</th>
							<th>산책로(명)</th>
							<th>글쓴이</th>
							<th>위치</th>
							<th>날짜</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
							<c:when test="${empty list }">
								<tr>
									<td colspan="5" style="text-align:center">---- 작성된 산책로가 없습니다. 산책로를 만들어보세요! ----</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="dto" items="${list }"  varStatus="status">
									<tr class="selwalk" style="text-align:center; cursor:Pointer;" onclick="selwalk(); location.href='MapServlet.do?command=selectlist&seq=${dto.walk_no }';" >
										<td>${fn:length(list)-status.index}</td>
										<td>${dto.walk_name }</td>
										<td>${dto.walk_writer }</td>
										<td>${dto.walk_dong }</td>
										<td>${dto.walk_regdate }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</tbody>
					</table>
				</div>
			</div>

</div>













<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=10d92f7c71b75a49429cc13ea5d030f6&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // ########지도의 중심좌표(gps통한 중심좌표를 구할 수 있어야)#####
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 





// global
var clickedOverlay ; // 맵에 이용되는 overlay
var realLoc ; // 동이름과 같이 keywordsearch에 들어가는 변수
var dongname ; // 동이름만 가져오는 변수
var mouseEvent1;
var mouseEvent1_res; // 버튼클릯시 선그리기 제어
var paths;
var path;

var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
var clickLine; // 마우스로 클릭한 좌표로 그려질 선 객체입니다
var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
var distanceOverlay2;
var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

var polyline2;
var pathlatlon = new Array() ;
var latlonArray = new Array();

var chek = false;

$('table>tbody>tr').each(function(i) {
this.title = (i+1) + '번째 최근글';
});
	
	
	
//**************************************/
//**************************************/
//**************************************/
// 			산책로 게시판 관련
//**************************************/
//**************************************/
//**************************************/

//페이지 키자마자 한 번 내위치 실행
selwalk();
//selwalk();  
//selwalk 이게 문제임. 조건걸어서 눌렀을 때만 실행 시킬 수 있게 해야하는데.



//	$('.selwalk').click(function(){
		
function selwalk(){
		console.log("selwalk()실행!");
	
		 <c:forEach var='tlist' items='${latlon}'>
		 	latlonArray.push("${tlist}");
		 </c:forEach>
		 
		 console.log("latlonArray : " + latlonArray);
		var lat = new Array();
 		var lon = new Array();
 		
 		var latlon_res = latlonArray.toString().split(",");
 		
 		console.log("latlon_res : " + latlon_res);
 		
	    for (var i = 0; i < latlon_res.length/2; i++) {
			var lat_res = (latlon_res[2*i]);
			lat.push(lat_res);
			var lon_res = (latlon_res[(2*i)+1]);
			lon.push(lon_res);
		}
		 console.log("lat : " + lat);
		 console.log("lon : " + lon);
		
		 // 받은 lat과 lon값을 뿌려준다. 배열형태로
		 
		 for (var i = 0; i < lat.length; i++) {
			 pathlatlon.push(
				new kakao.maps.LatLng(lat[i], lon[i])
				);
			}
		 console.log("pathlatlon : " + pathlatlon );
		 
		 
		 //polyline2.setMap(null);     // 저장된 산책로(선) 초기화
		 polyline2 = null;
		 
		 
		 if(pathlatlon!=null||pathlatlon!=[]){
			 
		  polyline2 = new kakao.maps.Polyline({
				map: map, // 선을 표시할 지도입니다 
	            path: pathlatlon, // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	            strokeWeight: 3, // 선의 두께입니다 
	            strokeColor: '#db4040', // 선의 색깔입니다
	            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	            strokeStyle: 'solid' // 선의 스타일입니다
			});
		 }else{
			 alert("안됨..");
		 }
		 
	console.log("polyline2.getPath() : " + polyline2.getPath());
	
	
	//polyline2.setMap(map); // 지도에 올린다.
	
	 //그려진 길이 값 distance
	var distance = Math.round(polyline2.getLength());
	console.log("distance : " + distance);
	
	content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
	
	distanceOverlay2 = null;
	
	distanceOverlay2 = new kakao.maps.CustomOverlay({
        map: map, // 커스텀오버레이를 표시할 지도입니다
        content: content,  // 커스텀오버레이에 표시할 내용입니다
        position: pathlatlon[pathlatlon.length-1], // 커스텀오버레이를 표시할 위치입니다.
        xAnchor: 0,
        yAnchor: 1,
        zIndex: 3  
    });  
    
	distanceOverlay2.setMap(map);
	
	//생선된 산책로 마지막지점에 화면이동
	
	//var panTo_res = kakao.maps.LatLng(pathlatlon[pathlatlon.length-1]) ;
	var panTo_res = pathlatlon[pathlatlon.length-1];
	console.log("pathlatlon[pathlatlon.length-1] : " + pathlatlon[pathlatlon.length-1]);
    
    
    var panTo_res2 = panTo_res.toString();
    var panTo_res3 = panTo_res2.substr(1, panTo_res2.length-2);
    var panTo_res_spl = panTo_res3.toString().split(",");
    
    var lat_pan = panTo_res_spl[0];
    var lon_pan = panTo_res_spl[1];
    
    
    console.log("lat_pan : " + lat_pan);
    console.log("lon_pan : " + lon_pan);
    
    var pant = new kakao.maps.LatLng(lat_pan, lon_pan) ;
    map.panTo(pant);
    
    
	}
	
	
//	);
//}


//**************************************/
//**************************************/

/* 밑에 부터 산책로 그리기 btn클릭 시 drawin 실행
 * -> 이후 kakao 선그리기 메소드 실행.
 */
//**************************************/
//**************************************/

function drawin(){
	document.getElementById("writetable").style.display="block";
	//document.getElementById('foucsplease').scrollIntoView();
	document.getElementById('foucsplease').focus();

	document.getElementById("focusplz").style.display="none";
	kakao.maps.event.addListener(map, 'click', 	mouseEvent1);
	 
	polyline2 = null; // 저장된 산책로(선) 초기화
	mouseEvent1_res = mouseEvent1;
	    

	
}



function drawhide(){
	document.getElementById("writetable").style.display="none";
	document.getElementById("focusplz").style.display="block";
	kakao.maps.event.removeListener(map, 'click', mouseEvent1_res);
	//이동해서 지우기 일단..
	
    // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
    deleteClickLine();
    
    // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
    deleteDistnce();

    // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
    deleteCircleDot();
	
}

function drawout(){ //그려진 선과 산책로명 저장
	kakao.maps.event.removeListener(map, 'click', mouseEvent1_res);
	document.getElementById("writetable").style.display="none";
	document.getElementById("focusplz").style.display="block";

	
	document.getElementById("ppp").value= path ; //좌표 받아서 넘기기
	document.getElementById("dong").value= dongname ; //동네임 받아서 넘기기
	console.log("ppp-path : " + path);
	console.log("realpaths : " + paths);
	
}
// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
	
	
	
	//mouseEvent 제거하기 위한 변수선언
	 mouseEvent1 = function(mouseEvent) {
    // 마우스로 클릭한 위치입니다 
    var clickPosition = mouseEvent.latLng;
	console.log("click : " + clickPosition);
	
	
	
	
    // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
    if (!drawingFlag) {

        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
        drawingFlag = true;
        
        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
        deleteClickLine();
        
        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
        deleteDistnce();

        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
        deleteCircleDot();
    
        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
        clickLine = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
        
        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
        moveLine = new kakao.maps.Polyline({
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다    
        });
        
        
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면
    	
        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        path = clickLine.getPath();
    	
        
        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        
        
        console.log("path : " + path);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);
		paths = path;
		console.log("paths : "+ paths);
		
		
		
		
        
        var distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition, distance);
    }

}
	
	
// 지도에 마우스무브 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

    // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag){
        
        // 마우스 커서의 현재 위치를 얻어옵니다 
        var mousePosition = mouseEvent.latLng; 

        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
        
        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
        var movepath = [path[path.length-1], mousePosition];
        moveLine.setPath(movepath);    
        moveLine.setMap(map);
        
        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
        
        // 거리정보를 지도에 표시합니다
        showDistance(content, mousePosition);   
    }             
});                 

// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

    // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag) {
        
        // 마우스무브로 그려진 선은 지도에서 제거합니다
        moveLine.setMap(null);
        moveLine = null;  
        
        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
    
        // 선을 구성하는 좌표의 개수가 2개 이상이면
        if (path.length > 1) {

            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
            if (dots[dots.length-1].distance) {
                dots[dots.length-1].distance.setMap(null);
                dots[dots.length-1].distance = null;    
            }

            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
                
            // 그려진 선의 거리정보를 지도에 표시합니다
            var dongname_res2 = (clickLine.getPath()[clickLine.getPath().length-1]).toString().split(",");
                console.log("dongname_res2 : " + dongname_res2);
            
            var dongname_res3 = dongname_res2.toString();
            var dongname_sub = dongname_res3.substr(1, dongname_res3.length-2);
            var dongname_spl = dongname_sub.toString().split(",");
            
            var lat_dong = dongname_spl[0];
            var lon_dong = dongname_spl[1];
            
            
            console.log("lat_dong : " + lat_dong);
            console.log("lon_dong : " + lon_dong);
            
            teaTimeS(lat_dong, lon_dong); //주소값 받기(해당 ex)역삼동 값)
            
            
            showDistance(content, path[path.length-1]);  
            
            
            
             
        } else {

            // 선을 구성하는 좌표의 개수가 1개 이하이면 
            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
            deleteClickLine();
            deleteCircleDot(); 
            deleteDistnce();

        }
        
        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
        drawingFlag = false;
        
    }  
});    

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
function showDistance(content, position) {
    
    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
        
        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
        
    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
        
        // 커스텀 오버레이를 생성하고 지도에 표시합니다
        distanceOverlay = new kakao.maps.CustomOverlay({
            map: map, // 커스텀오버레이를 표시할 지도입니다
            content: content,  // 커스텀오버레이에 표시할 내용입니다
            position: position, // 커스텀오버레이를 표시할 위치입니다.
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3  
        });      
    }
}

// 그려지고 있는 선의 총거리 정보와 
// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
function displayCircleDot(position, distance) {

    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new kakao.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position: position,
        zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);

    if (distance > 0) {
        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
        var distanceOverlay = new kakao.maps.CustomOverlay({
            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
            position: position,
            yAnchor: 1,
            zIndex: 2
        });

        // 지도에 표시합니다
        distanceOverlay.setMap(map);
    }

    // 배열에 추가합니다
    dots.push({circle:circleOverlay, distance: distanceOverlay});
}

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
function deleteCircleDot() {
    var i;

    for ( i = 0; i < dots.length; i++ ){
        if (dots[i].circle) { 
            dots[i].circle.setMap(null);
        }

        if (dots[i].distance) {
            dots[i].distance.setMap(null);
        }
    }

    dots = [];
}

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
    var walkkTime = distance / 67 | 0;
    var walkHour = '', walkMin = '';

    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
    if (walkkTime > 60) {
        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
    }
    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

    // 거리와 도보 시간 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="dotOverlay distanceInfo">';
    content += '    <li>';
    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">도보</span>' + walkHour + walkMin;
    content += '    </li>';
    content += '</ul>';
    return content;
    
	}
	
	






//////////////////////////////////////////////////////
//////////////////////////////////////////////////////








//지도 메소드 시작



//장소 검색 객체를 생성합니다
var places = new kakao.maps.services.Places(); 


var content;

var customOverlay = new kakao.maps.CustomOverlay({
	map: map,

}), markers = [];

//##########첫 시작#######처음엔 현재주소 받고(gps), 안될 시  ###################
/*
var realPlace = '역삼';
places.keywordSearch(realPlace, placesSearchCB); 
var searchPlace = "";
*/


//###################현재 내 위치추적###################
function setMyLoc(){ // 현재 주소 받기 geolocation
//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
 
 // GeoLocation을 이용해서 접속 위치를 얻어옵니다
 navigator.geolocation.getCurrentPosition(function(position) {
     
     var lat = position.coords.latitude, // 위도
         lon = position.coords.longitude; // 경도
     
     	
     var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
      console.log("locPosition : " + locPosition);
     
    //현재 위도 경도 값을 받아 넘겨주기
    
    teaTime(lat,lon);
    //console.log("넘겨받은 "+dongname);
    
    
     // 마커와 표시
     displayMarker2(locPosition);
         
   });

} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치 설정
 
 var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);    
     
 displayMarker2(locPosition);
}



//지도에 현재 위치를 받아 가운데에 마커 표시 및 이동
function displayMarker2(locPosition) {
	
	var imageSrc = 'resources/images/me.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(45, 45), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(10, 39)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

 // 마커를 생성합니다
 var marker2 = new kakao.maps.Marker({  
     map: map, 
     image: markerImage,
     position: locPosition
 }); 
 
 // 지도 중심좌표를 접속위치로 변경합니다
 map.panTo(locPosition);      
} 


}

//##################//##################





//각 카테고리에 클릭 이벤트를 등록합니다
addCategoryClickEvent();


//##################################################################
//######## 검색!!
function searchPlaces(){
	
	//현재 위치 확인 + 현재 위치 주소 값 넘기기
	setMyLoc();
	
	realLoc = dongname;
	
	
	if(currCategory=="a1"){
		searchPlace= realLoc+' 애견';
		
		
	}else if(currCategory=="a2"){
		searchPlace=realLoc+' 동물병원';	
		
		
	}else if(currCategory=="a3"){
		searchPlace=realLoc+' 애견용품';	
		
		
	}else if(currCategory=="a4"){
		searchPlace=realLoc+' 애견미용';
		
		
	}else if(currCategory=="a5"){
		searchPlace=realLoc+' 애견동반';
		
		
	}else if(currCategory=="a6"){
		searchPlace=realLoc+' 공원';
	}	
	
	realPlace = searchPlace;
	
	 // 커스텀 오버레이를 숨깁니다 
    customOverlay.setMap(null);
	
	removeMarker();
	
	places.keywordSearch(realPlace, placesSearchCB); 
	//alert(realPlace);
} 


// 키워드로 장소를 검색합니다 (##########검색기능 입력 버튼식으로 다르게)


//##################################################################
	
	
	
	
	
	
// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.panTo(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
	
	//if()  카테고리명에 따른 이미지 다르게############################
	
	var imageSrc = 'resources/images/mapmarker.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(32, 39), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(10, 39)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	
    markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // ###################마커가 표시될 위치입니다
	
    
    // 마커를 생성하고 지도에 표시합니다
    marker = new kakao.maps.Marker({
        map: map,
        image: markerImage,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });
    
    marker.setMap(map); 
    
    //마커들을 지우기 위해 배열로 넣어둠
    markers.push(marker); 
    
    
    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        	if (clickedOverlay) {
        		clickedOverlay.setMap(null);
   			 }
        
          // #########버튼 입력종류에 따라 다른 html이 나오게 함
			if(true){
        	
        	// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
        	content = '<div class="customoverlay">' +
        	    '  <a href="'+place.place_url+'" target="_blank">' +
        	    '    <span class="title">'+place.place_name+'</span>' +
        	    '  </a>' +
        	    '</div>';
        	    
        	
        	 customOverlay = new kakao.maps.CustomOverlay({
        	    map: map,
        	    position: new kakao.maps.LatLng(place.y, place.x) ,
        	    content: content,
        	    yAnchor: 1,
        	    
        	}), 
        		contentNode = document.createElement('div'),
        		currCategory = ''; 			// 현재 선택된 카테고리를 가지고 있을 변수입니다
        	
        	customOverlay.setMap(map);
        	clickedOverlay = customOverlay;
        }
        
        
      
        
        
        
    });
}


// 일단
//addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
//addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

//엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
function addEventHandle(target, type, callback) {
    if (target.addEventListener) {
        target.addEventListener(type, callback);
    } else {
        target.attachEvent('on' + type, callback);
    }
}

//각 카테고리에 클릭 이벤트를 등록합니다
function addCategoryClickEvent() {
    var category = document.getElementById('category'),
        children = category.children;

    for (var i=0; i<children.length; i++) {
        children[i].onclick = onClickCategory;
    }
}

//카테고리를 클릭했을 때 호출되는 함수입니다
function onClickCategory() {
    var id = this.id,
    className = this.className;

    customOverlay.setMap(null);

    if (className === 'on') {
        currCategory = '';
        changeCategoryClass();
        removeMarker();
    } else {
        currCategory = id;
        changeCategoryClass(this);
        searchPlaces();
    }
}

//클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
function changeCategoryClass(el) {
    var category = document.getElementById('category'),
        children = category.children,
        i;

    for ( i=0; i<children.length; i++ ) {
        children[i].className = '';
    }

    if (el) {
        el.className = 'on';
    } 
} 

//지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

//위도값과 경도값을 받아 주소(동) 넘기기
function teaTime(lat,lon){
	
	var geocoder = new kakao.maps.services.Geocoder();
	
	var callback = function(result, status) {
		var dongname_res = result[0].region_3depth_name;
		dongname = dongname_res;
		console.log("teatime- dongname : " + dongname);
	};
	geocoder.coord2RegionCode(lon, lat, callback);
	
}

function teaTimeS(lat,lon){
	
	var geocoder2 = new kakao.maps.services.Geocoder();
	
	var callback2 = function(result, status) {
		var dongname_res = result[0].region_3depth_name;
		dongname = dongname_res;
		console.log("teatimeSSS - dongname : " + dongname);
	};
	geocoder2.coord2RegionCode(lon, lat, callback2);
	
}


</script>



 <jsp:include page="form/footer.jsp" flush="true" /> 
 
</body>
</html>