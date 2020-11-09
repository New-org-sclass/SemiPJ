<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  request.setCharacterEncoding("UTF-8"); %>
<%  response.setContentType("text/html; charset=UTF-8"); %>    
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
	
	
	#category {position:absolute;top:110px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
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
    
    
</head>

<body>
<jsp:include page="form/header01.jsp" flush="true" /> 


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
					
					  <p><em>지도를 <span style="color:red;">마우스로 클릭</span>하면 선 그리기가 시작되고<br><span style="color:red;">오른쪽 마우스를 클릭</span>하면 선 그리기가 종료됩니다</em></p>
					  <button onclick="drawin();">나만의 산책로 만들기</button>
					  <button onclick="drawout();">산책로만들기 끄기</button>
					  
					
				</div>
				<hr>
				<div class="panel-body">
					<table class="table table-hover">
						<thead>
							<tr>
							<th>#</th>
							<th>산책로(명)</th>
							<th>글쓴이</th>
							<th>위치</th>
							<th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr><td>1</td><td>Steve</td><td>Jobs</td><td>@steve</td><td>20-11-09</td></tr>
							<tr><td>2</td><td>Simon</td><td>Philips</td><td>@simon</td><td>20-11-09</td></tr>
							<tr><td>3</td><td>Jane</td><td>Doe</td><td>@jane</td><td>20-11-09</td></tr>
							<tr><td>3</td><td>Jane</td><td>Doe</td><td>@jane</td><td>20-11-09</td></tr>
						</tbody>
					</table>
				</div>
			</div>

</div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=10d92f7c71b75a49429cc13ea5d030f6&libraries=services,clusterer,drawing"></script>


<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // ########지도의 중심좌표(gps통한 중심좌표를 구할 수 있어야)#####
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 





// global
var clickedOverlay = null; // 맵에 이용되는 overlay
var realLoc = ""; // 동이름과 같이 keywordsearch에 들어가는 변수
var dongname =""; // 동이름만 가져오는 변수
var drawswitch = "off"; // console 확인용
var mouseEvent1_res; // 버튼클릯시 선그리기 제어





// 산책로 게시판 관련
//////////////////////////////////////////////////////

function drawin(){

	drawswitch = "on";	
	console.log(drawswitch);


// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
if(drawswitch=="on"){
	
	var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
	var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
	var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
	var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
	var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
	
		var mouseEvent1 = function(mouseEvent) {
    // 마우스로 클릭한 위치입니다 
    var clickPosition = mouseEvent.latLng;
	console.log("click : " + clickPosition);
	console.log("click : " + typeof(clickPosition));
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
    
        // 클릭한 지점에 대한 정보를 지도에 표시합니다
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면

        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();

        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);

        var distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition, distance);
    }

};
kakao.maps.event.addListener(map, 'click', 	mouseEvent1);
mouseEvent1_res = mouseEvent1;
}else{
	
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
    content += '    <li>';
    content += '        <button class="label" class="hide" onclick="">저장</button>';
    content += '    </li>';
    content += '</ul>';
    	
    return content;
	}
	
	return drawswitch="off";

}

function drawout(){
	drawswitch="off";
	console.log(drawswitch);
	kakao.maps.event.removeListener(map, 'click', mouseEvent1_res);
}
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////








//지도 메소드 시작
//페이지 키자마자 한 번 내위치 실행
window.onload = function(){
	setMyLoc();
}


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
      console.log(locPosition);
     
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
	};
	geocoder.coord2RegionCode(lon, lat, callback);
	
	
}


</script>



 <jsp:include page="form/footer.jsp" flush="true" /> 
 
</body>
</html>