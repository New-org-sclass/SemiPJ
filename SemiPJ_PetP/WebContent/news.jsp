<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	request.setCharacterEncoding("UTF-8"); %>
<% 	response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petp.dto.NewsDto" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>News ${alist[0].ndate }</title>

	<style type="text/css">
		.card-group{
			padding: 8px 250px;
		}
		.card{
			border: 1px solid rgba(239, 204, 135, 0.5)!important;
		}
		.card-img-top{
			height: 250px;
		}
		.list-unstyled{
			padding: 8px 250px!important;
		}
		.ulresize1{
			width: 150px;
			height: 150px;
			object-fit: fill;
		}
		.media{
			padding-top: 30px;
		}
		.dogdogpaging{
			text-align: center;
		}
		.floR{
			float: right;
		}
		.floL{
			float: Left;
		}
		.wid{
			width: 100%;
		}
		.RA{
			right: 90px;
			position: absolute;
		}
		#commentwrite1{
			float: right;		
		}
		
		#commentarea{
			width: 100%;
			float: right;		
		}

	</style>
	<!-- <script type="text/javascript" src="view/jquery-3.5.1.min.js" ></script> -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="view/newsquery.js"></script>
    <script type="text/javascript">
    
	    function formAction() {
	    	var form = document.getElementById('searchForm');
	    	var command = document.getElementsByName("command");
	    	command[0].setAttribute("value","search");
	    	console.log("formAction command is"+command[0]);
	    	//BoardServlet.do?search=
	    	form.action;	
	    }
    	
    	
		let totalData = 100;    // 총 데이터 수 -- 받은 리스트나 json의 row 수
	    let dataPerPage = 9;    // 한 페이지에 나타낼 데이터 수
	    let pagePerscreen = 5;        // 한 화면에 나타낼 페이지 수 pagePerscreen
	
		let imgl = new Array();
		let titlel = new Array();
		let sumal = new Array();
		let datel = new Array();
		let urll = new Array();
		let newsnol = new Array();

 		window.onload=function(){
			//let tmp = "<c:out value='${alist[0].ntitle}'></c:out>";
			<c:forEach var='tlist' items='${alist}'>
				imgl.push("${tlist.nimg}");
				titlel.push("${tlist.ntitle}");
				sumal.push("${tlist.nsummary}");
				datel.push("${tlist.ndate}");
				urll.push("${tlist.nurl}");
				newsnol.push("${tlist.newsno}");
			</c:forEach>
			
			//console.log("list : " + list);
			totalData = titlel.length;
			console.log("totalData : " + totalData);
			console.log("dataPerPage : " + dataPerPage);
			console.log("pagePerscreen : " + pagePerscreen);
			
			paging1(totalData, dataPerPage, pagePerscreen, 1);
			rend(1, dataPerPage);
			console.log("작동한다.1 ");
			// $('<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">').appendTo('head');
			// $('<style type="text/css"></style>').html('@import url("https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css")').appendTo('head');
		}
	 
	    
	    function paging1(totalData, dataPerPage, pagePerscreen, currentPage){
	        
	        console.log("currentPage : " + currentPage);
	        
	        let totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수  나머지를 표현할 수 있도록 ceil처리
	        console.log("totalPage : " + totalPage);
	
	        let pageGroup = Math.ceil(currentPage/pagePerscreen);    // 페이지 그룹 1~5을 한묶음
	        console.log("pageGroup : " + pageGroup);
	        
	        let last = pageGroup * pagePerscreen;    // 화면에 보여질 마지막 페이지 번호 //각 페이지마다 보여지게!(현재페이지)
	        if(last > totalPage){
	            last = totalPage;                // 마지막 페이지때 보여질 페이지의 끝수를 알 수 있게
	        }
	        let first = last - (pagePerscreen-1);     // 화면에 보여질 첫번째 페이지 번호
	        let next = last+1;
	        let prev = first-1;
	        
	        console.log("last : " + last);
	        console.log("first : " + first);
	        console.log("next : " + next);
	        console.log("prev : " + prev);
	 
	        var html = "";
	        
	        if(prev > 0){
	            html += " <a href='#' id='prev'><</a> ";
			}
	        
	        for(var i=first; i <= last; i++){
	        	if(i < 1){
	        		continue;
	        	}
				html += " <a href='#' id=" + i + ">" + i + "</a> ";
	        }
	
	        console.log(html);
	
			if(last < totalPage){
				html += "<a href='#' id='next'> &gt; </a> ";
			}
        
	        $("#paging1").html(html);    // 페이지 목록 생성
			//document.getElementById("paging1").innerHTML = html;
			//console.log($("#paging1").text());
			console.log(document.getElementById("paging1").innerHTML);
	        $("#paging1 a").css({ "color":"black", "font-size":"25px",});
	        $("#paging1 a#" + currentPage).css({ "color":"black", "font-weight":"bold"});
	                                           
	        $("#paging1 a").click(function(){
	            let atag = $(this);
	            let aid = atag.attr("id");
	            let selectedPage = atag.text();
	            
	            if(aid == "next"){
					selectedPage = next;
				}
	            if(aid == "prev"){
				   selectedPage = prev;
				}
				rend(selectedPage, dataPerPage);
	            
	            paging1(totalData, dataPerPage, pagePerscreen, selectedPage);   
			});
			
			
			/*     현재 페이지에 해당하는 데이터의 index ~ index 
			총데이터 113
			셀렉트페이지 7/ 페이지 카운트5의 몫 1 나머지 2
			7* 데이터펄페이지 10 = 61~70 번대의 인덱스 도출  리스트는 인덱스 0번부터.
			태그 랜더(반복문처리시) i=(selpage*dataperpage)-dataperpage; ᅟi< (selpage*dataperpage); i++    list.get(i)
			div > (img) , (div > h5 p p )  *3
			*/
			
		} //paging1() 함수 끝.
		
		function rend(selectedPage, dataPerPage){ //페이지 내 데이터 만들기.
			$('#commentwrite1').off('click.cwrite1');
			// let cgroup = document.getElementsByClassName("card-group");
			//let megroup = document.getElementsByClassName("list-unstyled");
			let stdata = (selectedPage*dataPerPage)-dataPerPage;
			let endata = (selectedPage*dataPerPage);
			// let v1 ="";
			// let v2 ="";
			for(var i=0; i<6; i++){
				// v1 += '<div class="card"><img src="'+imgl[stdata+i]+'" class="card-img-top" alt="...">' 
				// 	+ '<div class="card-body">' + '<h5 class="card-title">'	+ titlel[stdata+i] +'</h5>'
				// 	+ '<p class="card-text">' + sumal[stdata+i] + '</p>'
				// 	+ '<p class="card-text"><small class="text-muted">' + datel[stdata+i] + '</small></p></div>';
				// v2 += '<div class="card"><img src="'+imgl[stdata+i+3]+'" class="card-img-top" alt="...">' 
				// 	+ '<div class="card-body">' + '<h5 class="card-title">'	+ titlel[stdata+i+3] +'</h5>'
				// 	+ '<p class="card-text">' + sumal[stdata+i+3] + '</p>'
				// 	+ '<p class="card-text"><small class="text-muted">' + datel[stdata+i+3] + '</small></p></div>';
				let t1 = document.getElementsByClassName("card-img-top");
					console.log("t1: "+ t1[i].getAttribute("src"));
				if(t1[i].getAttribute("src") === ""){	//기사의 사진이 없을 경우 이미지 대체.
					t1[i].setAttribute("src", "./resources/images/noimage.jpg");
				}
				if(titlel[stdata+i] == null){	//기사가 없을 경우 그만
					continue;
				}
				// let aurl = "location.href='Newscon.do?command=detail&newsno="+newsnol[stdata+i]+"'";
				let aurl = newsnol[stdata+i];
				let t2 = document.getElementsByClassName("card-title");
				let t3 = document.getElementsByClassName("card-text");
				let t4 = document.getElementsByClassName("text-muted");
				t1[i].setAttribute("src", imgl[stdata+i]);
				t2[i].innerHTML = titlel[stdata+i];
				t3[i*2].innerHTML = sumal[stdata+i];
				t4[i].innerHTML = datel[stdata+i];
				aadd(t1, i, aurl)
				aadd(t2, i, aurl)
				aadd(t3, i*2, aurl)
				aadd(t4, i, aurl)
				//document.getElementsByClassName("card-img-top")[i].setAttribute("src", imgl[stdata+i]);
				//document.getElementsByClassName("card-title")[i].innerHTML = titlel[stdata+i];
				//document.getElementsByClassName("card-text")[6+(i%2)+i].innerHTML = sumal[stdata+i];
				//document.getElementsByClassName("text-muted")[i].innerHTML = datel[stdata+i];
			}
			for(var i=0; i<3; i++){
				let t1 = document.getElementsByClassName("mr-3 ulresize1");
				if(t1[i].getAttribute("src") == ""){
					t1[i].setAttribute("src", "./resources/images/noimage.jpg");
					console.log("t1: "+ t1[i].getAttribute("src"));
				}
				if(titlel[stdata+i+6] == null){
					continue;
				}
				// let aurl = "location.href='Newscon.do?command=detail&newsno="+newsnol[stdata+i+6]+"'";
				let aurl = newsnol[stdata+i+6];
				let t2 = document.getElementsByClassName("mt-0 mb-1");
				let t3 = document.getElementsByClassName("media-body");
				let t4 = document.getElementsByClassName("seols");
				t1[i].setAttribute("src", imgl[stdata+i+6])
				t2[i].innerHTML = titlel[stdata+i+6];
				t3[i].childNodes[2].textContent = sumal[stdata+i+6];
				t4[i].textContent = datel[stdata+i+6];
				aadd(t1, i, aurl)
				aadd(t2, i, aurl)
				aadd(t3, i, aurl)
				aadd(t4, i, aurl)
				//document.getElementsByClassName("seols")[i].wrap
			}

			$('a[name="atag"]').css({"text-decoration":"none", "color":"black"});

			function aadd(classname, i, aurl){ //a tag들을 페이지내의 데이터들에 추가.
				let tag1 = classname[i];
				let link = document.createElement('a');
					if(tag1.parentNode.getAttribute('name') == 'atag'  ){
						console.log("atag확인.")
						$(tag1).unwrap();
					} else{
						console.log("atag미확인.")
					}
				//console.log("tag1.parentNode: "+tag1.parentNode);
				link.innerHTML = tag1.outerHTML;
				link.setAttribute('href', '#');
				//link.setAttribute('onclick', aurl);
				// link.setAttribute('onclick', 'newsContentin(this);');
				link.setAttribute('name', 'atag');
				link.setAttribute('data-toggle', 'modal');
				link.setAttribute('data-target', '#newsmodal');
				link.setAttribute('data-no', aurl);
				tag1.parentNode.insertBefore(link, tag1);
				tag1.remove();
			}
			
			let atagnoInnewsmodal = 0; 
			
			$('#newsmodal').on('show.bs.modal', function(event){ //뉴스 본문을 실행하는 이벤트처리.
				var atag = $(event.relatedTarget);
				atagnoInnewsmodal = atag.data('no');
				newsContentin(atagnoInnewsmodal);
				getCommentInfo(atagnoInnewsmodal);

				//let but1 = "btn btn-light floR";
				//'#cobox2 p .btn btn-light'
				
				
			});
			
			$('#commentwrite1').on('click.cwrite1',  function(event){ //본문 내에서 댓글쓰기 이벤트를 처리.
					//console.log("testinsert");
				insertComment(atagnoInnewsmodal);
			});
			

			// cgroup[0].innerHTML = v1;
			// cgroup[1].innerHTML = v2;
			// $(".card-group:eq(0)").html(v1).trigger("create");
			// $(".card-group:eq(1)").html(v2).trigger("create");
			// document.getElementById("maingroup1").innerHTML += v1;
			// document.getElementById("maingroup1").innerHTML += v2;



		} //rend()함수 끝.
		
		

/* 	    $("document").ready(function(){        
	        paging1(totalData, dataPerPage, pagePerscreen, 1);
			console.log("작동한다.2");
	    });
	 */
	 

	</script>
	
	
</head>

<body>
<jsp:include page="/form/header_test.jsp" flush="false" />

	<main role="main" style="margin-top: 80px; background-color: #fffff9; ">
        <div class="container">
		<h1>News List</h1>
      	
		
        </div>
		
		<br>	
      
		<div id="maingroup1" >	
			<div class="card-group" >
				<div class="card">
					<img src="" class="card-img-top" alt="...">
					<div class="card-body">
					<h5 class="card-title"></h5>
					<p class="card-text"> </p>
					<p class="card-text"><small class="text-muted"> </small></p>
					</div>
				</div>
				<div class="card">
					<img src="" class="card-img-top" alt="...">
					<div class="card-body">
					<h5 class="card-title"></h5>
					<p class="card-text">  </p>
					<p class="card-text"><small class="text-muted"> </small></p>
					</div>
				</div>
				<div class="card">
					<img src="" class="card-img-top" alt="...">
					<div class="card-body">
					<h5 class="card-title"></h5>
					<p class="card-text"> </p>
					<p class="card-text"><small class="text-muted"></small></p>
					</div>
				</div>
			</div>
			
			<div class="card-group" >
				<div class="card">
					<img src="" class="card-img-top" alt="...">
					<div class="card-body">
					<h5 class="card-title"></h5>
					<p class="card-text"> </p>
					<p class="card-text"><small class="text-muted"> </small></p>
					</div>
				</div>
				<div class="card">
					<img src="" class="card-img-top" alt="...">
					<div class="card-body">
					<h5 class="card-title"></h5>
					<p class="card-text">  </p>
					<p class="card-text"><small class="text-muted"> </small></p>
					</div>
				</div>
				<div class="card">
					<img src="" class="card-img-top" alt="...">
					<div class="card-body">
					<h5 class="card-title"></h5>
					<p class="card-text"> </p>
					<p class="card-text"><small class="text-muted"></small></p>
					</div>
				</div>
			</div> 
		</div>
		
	    
	    <br>
	  
	  	<div id="maingroup2">
		    <ul class="list-unstyled" >
				<li class="media">
					<img src="" class="mr-3 ulresize1" alt="...">
					<div class="media-body">
						<h5 class="mt-0 mb-1"></h5>
						<p><small class="seols text-muted"></small></p>
					</div>
				</li>
				<li class="media">
					<img src="" class="mr-3 ulresize1" alt="...">
					<div class="media-body">
						<h5 class="mt-0 mb-1"></h5>
						<p><small class="seols text-muted"></small></p>
					</div>
				</li>
				<li class="media">
					<img src="" class="mr-3 ulresize1" alt="...">
					<div class="media-body">
						<h5 class="mt-0 mb-1"></h5>
						<p><small class="seols text-muted"></small></p>
					</div>
				</li>
			</ul>
		</div>
	
	<br>
    <br>
    </main>

	<div class="modal" id="newsmodal" tabindex="-1" aria-labelledby="newsmodalLabel">
		<div class="modal-dialog modal-lg">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title">Modal title</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <p>Modal body text goes here.</p>
			</div>
			<div class="modal-footer">
			  <div id="cobox1">
				  <div id="cobox2">
				

				  </div>
				  <div id="cobox3">
				  	<textarea id="commentarea" cols="550" rows="3" placeholder="댓글을 입력해주세요."></textarea>
					<button type="button" class="btn btn-light" id="commentwrite1" >댓글쓰기</button>
				  </div>
			  </div>
			</div>
		  </div>
		</div>
	  </div>
	
	<div id="paging1" class="dogdogpaging"></div>



<jsp:include page="/form/footer.jsp" flush="false"></jsp:include>
</body>
</html>