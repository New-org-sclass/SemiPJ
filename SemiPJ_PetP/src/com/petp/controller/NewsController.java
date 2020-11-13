package com.petp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.safety.Whitelist;

import com.github.cliftonlabs.json_simple.JsonObject;
import com.google.gson.Gson;
import com.petp.biz.NewsBiz;
import com.petp.dto.MemberDto;
import com.petp.dto.NewsCoDto;
import com.petp.dto.NewsDto;

@WebServlet("/Newscon")
public class NewsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NewsBiz newsbiz = new NewsBiz();

	private Document naver = null;
	private Document korea = null;
	private Connection conj = null;

	public NewsController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String command = request.getParameter("command");
		System.out.println("command: " + command);
		newsbiz.tport(request.getLocalPort());
		List<NewsDto> nlist = new ArrayList<NewsDto>();
		
		int scnt = (int)request.getSession().getAttribute("cload1");
		scnt += 1;
		request.getSession().setAttribute("cload1", scnt);
		
		if (command.equals("news")) {	//뉴스 메인 화면 ㄱㄱ
			System.out.println("scnt: "+scnt);
			if(scnt < 2) {				//session test1의 값(페이지 새로고침수)에 따라 크롤링 로드율 감소
				getnewS(nlist);
				getkoreaS(nlist);
				newsbiz.insertData(nlist);
			}

			List<NewsDto> alist = newsbiz.pnewsAll();
			request.setAttribute("alist", alist);
			dp("news.jsp",request, response);
//			response.sendRedirect("news.jsp");
			
		} else if (command.equals("search")) {	//뉴스 검색
			String word = (String)request.getParameter("search");
			System.out.println("word is "+word);
			request.setAttribute("alist",newsbiz.search(word));
			System.out.println("search header~: "+ response.getHeaderNames());
			dp("news.jsp",request, response);
			
		} else if (command.equals("detail")) {	//뉴스본문 출력
			int no = Integer.parseInt(request.getParameter("newsno"));
			NewsDto tmp = newsbiz.pnewsOne(no);
//			request.setAttribute("newsone", newsbiz.pnewsOne(no));
			JsonObject json1 = new JsonObject();
			json1.put("newsno", tmp.getNewsno());
			json1.put("ntitle", tmp.getNtitle());
			json1.put("nurl", tmp.getNurl());
			json1.put("nnsummary", tmp.getNsummary());
			json1.put("ncontent", tmp.getNcontent());
			json1.put("nimg", tmp.getNimg());
//			json1.put("ndate", tmp.getNdate());
			
			PrintWriter rp = response.getWriter();
			rp.print(json1.toJson());
//			dp("newsdetail.jsp", request, response);
			
		} else if(command.equals("test1")) {	//newsdetail session test부문
			//int test1 = (int)request.getSession().getAttribute("test1");
			//System.out.println("test1 is "+scnt);
			request.getSession().setAttribute("tre1", "test1의 값");
			request.getSession().setAttribute("tre2", "test22222222의 값");
			
			dp("newsdetail.jsp", request, response);
			
		} else if(command.equals("incomment")) {	//댓글 입력
			String jscomment = request.getParameter("jscomment");
			Gson inputgs = new Gson();
//			String st1 = inputgs.from
			NewsCoDto tmpcom = inputgs.fromJson(jscomment, NewsCoDto.class); //댓글 ajax에서 newsno, ncomment 2개만 가져온다.
			MemberDto tmpcomwriter = (MemberDto)request.getSession().getAttribute("memberDto");
			tmpcom.setWriter(tmpcomwriter.getMemid());// session에서 mem_id를 받아와서 NewsDto의 write에 담아준다.
			System.out.println("tmpcomwriter: "+ tmpcomwriter );
			System.out.println("tmpcom: "+tmpcom);
			
			if(request.getSession().getAttribute("memberDto") != null) {
				System.out.println("session null 아님");
			} else {
				System.out.println("session null");
			}
			
			int res = newsbiz.insertCo(tmpcom);
			
			if(res>0) {
				System.out.println("comment sucessfully inserted");
			} else {
				System.out.println("comment insert fail~");
			}
			
		} else if(command.equals("outcomment")) {	//댓글 출력
			System.out.println(request.getParameter("newsno"));
			int newsno = Integer.parseInt(request.getParameter("newsno"));
			List<NewsCoDto> clist = newsbiz.selCo(newsno);
			Gson gs1 = new Gson();
			String st1 = gs1.toJson("dfdf:dfdf, aaaa:bbbbbb");
			System.out.println(st1);
			String st2 = gs1.toJson(clist);
			System.out.println(st2);
			PrintWriter out = response.getWriter();
			out.print(st2);
			
		} else if(command.equals("delcomment")) {	//댓글 삭제
			int commentno = Integer.parseInt(request.getParameter("commentno"));
			System.out.println("commentno is" + commentno);
			int res = newsbiz.deleteCo(commentno);
			
			if(res>0) {
				System.out.println(commentno+"번 comment 삭제 성공");
			} else {
				System.out.println(commentno+"번 comment 삭제 실패...");
			}
			
		}
		

	}
	
	private void dp(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dp = request.getRequestDispatcher(url);
		dp.forward(request, response);
	}

	public void getnewS(List<NewsDto> nlist) {	//뉴스 메인의 값을 불러오는 함수. 데이터 수집.
		String naverurl = "https://search.naver.com/search.naver?";
		String naverparams = "&where=news&query=%EB%B0%98%EB%A0%A4%EB%8F%99%EB%AC%BC" 
								+ "&sm=tab_pge&sort=0&photo=0"
								+ "&field=0&pd=0&nso=so:r,p:all,a:all&mynews=0&start=";
		
		try {
			for (int i=1; i<12; i=i+10) { // paging 시작 지점 나누기. 일단은 1페이지 10개
				conj = Jsoup.connect(naverurl + naverparams + i);
				naver = conj.get(); // get(): createnewObject 고로 conj재활용가능

				
				for(int f=0; f<10; f++) {	//데이터를 가져오는 숫자 조절란.
					Element t1 = naver.select(".list_news > li").get(f);
					System.out.println("각 기사의 첫번째!!");
					String titleEl = t1.selectFirst(".news_area > .news_tit").text();
					System.out.println(titleEl);
					
					if(inspectlink(t1)==0 || newsbiz.inspectTitle(titleEl)!=0) { //db에 있어야 true
						continue;
					}
					
					
					String urlEl = t1.select("div>.news_area>.news_info>div>a").eq(1).attr("abs:href");
					System.out.println("urlEl: "+urlEl);
					
					String smryEl = t1.selectFirst("div>.news_area>.news_dsc>div>a").text();
					System.out.println("smryEl: "+smryEl);
					
					String contentEl = urlContent(urlEl)[0];
					String thImgEl = urlContent(urlEl)[1];
					String dateEl1 = urlContent(urlEl)[2].substring(0, 10);
					Date dateEl = StToDate(dateEl1);
					System.out.println("contentEl: "+contentEl);
					System.out.println("thImgEl: "+thImgEl);
					System.out.println("dateEl: "+dateEl1);
					
					NewsDto tmp = new NewsDto(titleEl, urlEl, smryEl, contentEl, thImgEl, dateEl );
					nlist.add(tmp);
					
				}
				
			} 
			
			
		} catch (IOException e) {
			System.out.println("news site가져오기 실패!");
			e.printStackTrace();
		}
		//naver end
		
	}
	
	
	public void getkoreaS(List<NewsDto> nlist) {	//2번째 신문사(백업)의 값을 가져오는 함수.
//		List<NewsDto> klist = new ArrayList<NewsDto>();
		String korearec1 = "http://www.koreadognews.co.kr/news/index.php?code=20140925141441_2377&page_rows=3&page=1#bottom_list";
		conj = Jsoup.connect(korearec1);
		try {
			korea = conj.get();
		} catch (IOException e1) {
			System.out.println("korea site conj fail!");
			e1.printStackTrace();
		}
		String korearec2 = korea.selectFirst("#news_data > div > a").attr("abs:href");
		System.out.println("korearec2: "+ korearec2);
		
		int recentno = Integer.parseInt(korearec2.substring(korearec2.length()-4) );
		
		
		try {
			for(int i=0; i<20; i++) { //가져오는 데이터의 개수를 조절.
				String koreaurl = "http://www.koreadognews.co.kr/news/view.php?no="+(recentno-i);
				conj = Jsoup.connect(koreaurl);
				korea = conj.get(); 
				
				String titleEl = korea.selectFirst(".news_title01 > h2").text();
				System.out.println(titleEl);
				
				if(newsbiz.inspectTitle(titleEl)!=0) {
					continue;
				}
				
//				System.out.println("urlEl prepare: "+t1.select("div>.news_area>.news_info>div>a").eq(1));
				String urlEl = koreaurl;
				System.out.println("urlEl: "+urlEl);
				
				String smryEl = korea.selectFirst("#view_content").text().substring(0, 80)+"...";
				System.out.println("smryEl: "+smryEl);
				
//				String contentEl = korea.selectFirst("#view_content").text();
				String contentEl = urlContent(urlEl)[0];
//				String contentEl = "";
				System.out.println("contentEl: "+contentEl);
				
				String thImgEl = korea.selectFirst("#view_content img").attr("abs:src");
				System.out.println("thImgEl: "+thImgEl);
				
				String dateEl1 = korea.selectFirst(".view01_date").text().substring(5, 15);
				Date dateEl = StToDate(dateEl1);
				System.out.println("dateEl: "+dateEl);
				
				NewsDto tmp = new NewsDto(titleEl, urlEl, smryEl, contentEl, thImgEl, dateEl );
				nlist.add(tmp);
			}
				
			
		} catch (IOException e) {
			System.out.println("korea site variable 가져오기 실패!");
			e.printStackTrace();
		}
		
	}
	
	
	public Date StToDate(String date) {	//sql입력용 날짜 변환
		SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");
		try {
			return sf.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	
	public int inspectlink(Element ele) {
		// ----------------------a tag(네이버뉴스링크 유무검사 부분), cnt가 0이면 a tag가 없는 곳
		Element inspectlink = ele.selectFirst("div>.news_area>.news_info>div"); //link있는곳
//		Elements inspectlink2 = naver.select(".type01>li>dl>dd:eq(2)");
//		System.out.println("11"+inspectlink.nextElementSibling());
//		System.out.println("22" + inspectlink.child(0).nextElementSibling());
//		System.out.println("33" + inspectlink);

		int cnt = 0;
		int index = 0;
		while (inspectlink.child(index).nextElementSibling() != null) {
			if (inspectlink.child(index).nextElementSibling().tagName().equals("a")) {
				cnt++;
			}
			System.out.println("child("+index+"): " + inspectlink.child(index));
			index++;
		}
		System.out.println("cnt: " + cnt);
		return cnt;
	}
	
	
	
	public String[] urlContent(String urlEl) throws IOException { //news본문
		conj = Jsoup.connect(urlEl);
		Document tmpdoc = conj.get();
		String[] ex = new String[3];
		
		
		Whitelist wlist = new Whitelist();
//		wlist.addTags("div");
		wlist.addTags("p","br","span","div","strong","img","a");
		wlist.addAttributes("a", "href");
		wlist.addAttributes("img", "src");
//		wlist.addEnforcedAttribute("img", "max-width", "100%");
//		wlist.addEnforcedAttribute("img", "width", "500px");
//		wlist.addEnforcedAttribute("img", "height", "auto");
//		wlist.addTags("p");
//		Jsoup.clean(res, Whitelist.basicWithImages());
		if(urlEl.substring(11, 23).equals("koreadognews")) {
			ex[0] = Jsoup.clean(tmpdoc.getElementById("view_content").outerHtml(), wlist);
			return ex;
		}
		
		String cot = tmpdoc.getElementById("articleBodyContents").outerHtml();
		ex[0] = Jsoup.clean(cot, wlist);
//		ex[0] = "";
//		System.out.println("ex: "+ex2);
		
		if(tmpdoc.selectFirst(".end_photo_org") != null) {
			System.out.println("Had end_photo_org");
			ex[1] = tmpdoc.selectFirst(".end_photo_org > img").attr("abs:src");
			
		} else {
			System.out.println("No end_photo_org");
			ex[1] = "";
		}
		ex[2] = tmpdoc.selectFirst(".t11").text();
		
		return ex;
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {

		doGet(request, response);
	}

}
