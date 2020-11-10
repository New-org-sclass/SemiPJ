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
            let html = comment[0];
            let html2 = comment[0].ncomment;
            console.log("html is "+html+" "+html2+" "+comment[0].writer+"  ajax success!!");
            //$(".modal-footer").append;
            //$(".modal-footer").html(html+html2);
        },
        error: function(){
            alert("ajax 통신실패!")
        }
	});
	
}

