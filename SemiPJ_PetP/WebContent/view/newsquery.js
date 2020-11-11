function newsContentin(atagno){
    let newsno = atagno;
    console.log("newsno is "+ newsno);
    $.ajax({
        url:"Newscon.do?command=detail&newsno="+newsno,
        method: "post",
        dataType: "json",
        success: function(cinfo){
            let html = cinfo.ncontent;
            $(".modal-title").html(cinfo.ntitle);
            $(".modal-body").html(html);
            $(".modal-body img").css({"max-width":"100%", "height":"auto", "display": "block", "margin": "0px auto" });
			console.log("ajax통신 성공! ntitle:"+ cinfo.ntitle);

        },
        error: function(){
            alert("통신실패! ajax error!");
        }
        
    });
}

function getCommentInfo(atagno){
	//후순위
	let newsno = atagno;
	$.ajax({
		url:"Newscon.do?command=outcomment&newsno="+newsno,
		method: "post",
		dataType: "json",
		success: function(comment){
            //let html = comment[0];
            //let html2 = comment[0].ncomment;
			let tagc = "";
			let commentno = 0;
            let newsno = 0;
            let groupno = 0;
            let groupsq = 0;
            let writer = "";
            let ncomment = "";
            let commentdate = "";
            //console.log("html is "+html+" "+html2+" "+comment[0].writer+"  ajax success!!");
            console.log("tagc is "+tagc+" "+atagno +"  ajax success!!");
            for (let i = 0; i < comment.length; i++) {
                commentno = comment[i].commentno;
                newsno = comment[i].newsno;
                groupno = comment[i].groupno;
                groupsq = comment[i].groupsq;
                writer = comment[i].writer;
                ncomment = comment[i].ncomment;
                commentdate = comment[i].commentdate;
                tagc += "<p ><span>"+writer+"</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>"+ncomment
				+"</span>&nbsp;&nbsp;<button type='button' class='btn btn-light' name='"+commentno+"' data-no='"+newsno+"'>삭제</button></p>";
                //$("#cobox2").append($("<p>").addClass("floR") );
				//$("#cobox2 > p").last().append($("span").text(writer+"  ") );
				//$("#cobox2 > p").last().append($("span").text(ncomment) );
				//$("#cobox2 > p").last().append($("button").addClass("btn btn-light").text("삭제") );
				//document.querySelector("#cobox2 p").setAttribute("name", commentno);
            }

            $("#cobox2").html(tagc);
			$("#cobox2 p").addClass("floR wid");
			//$("#cobox2 p").attr("floR wid");
			$("#cobox2 p button").addClass("floR");
			$("#cobox2 p span").first().addClass("floL");
            //$(".modal-footer").append;
            //$(".modal-footer").html(html+html2);
			$('p').on('click', '>button', function(event){
					//console.log("testinsert");
					//let commentno = document.querySelector(this).getAttribute("name");
					//let commentno = $("#cobox2 p").attr("name");
					let commentno = $(this).attr("name");
					let newsno = $(this).attr("data-no");
					console.log("deletecomment no is "+commentno);
					deleteComment(commentno, newsno);
			});
			
        },
        error: function(){
            alert("ajax 통신실패!")
        }
	});
	
}

function insertComment(newsno){
	//alert("insertcomment test");
	let ncomment = document.getElementById("commentarea").value;
	console.log("ncomment is "+ncomment);
	let cinfo = {"newsno":newsno,"ncomment":ncomment};
	$.ajax({
		url: "Newscon.do?command=incomment",
		method: "post",
		data:{"jscomment": JSON.stringify(cinfo)},
		success: function(){
			console.log("insert comment success!!");
			getCommentInfo(newsno);
			document.getElementById("commentarea").value = "";
			/*$('#newsmodal').on('shown.bs.modal', function(event){
				newsContentin(newsno);
				
			});*/
		},
		error: function(){
			console.log("insert comment error! ajax!");
		}
	});
	
}

function deleteComment(commentno, newsno){
	$.ajax({
		url: "Newscon.do?command=delcomment&commentno="+commentno,
		method: "post",
		success: function(){
			alert("댓글을 삭제하였습니다.");
			getCommentInfo(newsno);
		},
		error: function(){
			alert("댓글 삭제를 실패하였습니다. 다시 시도해주세요!");
		}
	});
	
}

