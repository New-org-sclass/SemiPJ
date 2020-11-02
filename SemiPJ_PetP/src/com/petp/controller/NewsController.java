package com.petp.controller;

import java.io.IOException;
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

import com.petp.biz.NewsBiz;
import com.petp.dto.NewsDto;

@WebServlet("/Newscon")
public class NewsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NewsBiz newsbiz = new NewsBiz();

	private int newsno = 0;
	private int bno = 0;	//보드넘
	private String title = "";
	private String nurl = "";
	private String summary = "";
	private String content = "";
	private String img = "";
	private String date = ""; 

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
		
		List<NewsDto> nlist = new ArrayList<NewsDto>();
		
		getnewS(nlist);
		getkoreaS(nlist);
		newsbiz.insertData(nlist);
		
		
		if (command.equals("news")) {
			List<NewsDto> alist = newsbiz.pnewsAll();
			request.setAttribute("alist", alist);
			dp("news.jsp",request, response);
//			response.sendRedirect("news.jsp");
			
		} else if (command.equals("search")) {
			String word = (String)request.getParameter("word");
			request.setAttribute("searchres",newsbiz.search(word));
			dp("newsdetail.jsp",request, response);
		}

	}
	
	private void dp(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dp = request.getRequestDispatcher(url);
		dp.forward(request, response);
	}

	public void getnewS(List<NewsDto> nlist) {
		String naverurl = "https://search.naver.com/search.naver?";
		String naverparams = "&where=news&query=%EB%B0%98%EB%A0%A4%EB%8F%99%EB%AC%BC" 
								+ "&sm=tab_pge&sort=0&photo=0"
								+ "&field=0&pd=0&nso=so:r,p:all,a:all&mynews=0&start=";
		
		try {
			for (int i=1; i<2; i=i+10) { // paging 시작 지점 나누기. 일단은 1페이지 10개
				conj = Jsoup.connect(naverurl + naverparams + i);
				naver = conj.get(); // get(): createnewObject 고로 conj재활용가능

				
				for(int f=0; f<10; f++) {
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
	
	
	public void getkoreaS(List<NewsDto> nlist) {
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
			for(int i=0; i<10; i++) { //50ea
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
				
				String contentEl = korea.selectFirst("#view_content").text();
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
	
	
	public Date StToDate(String date) {
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
//		wlist.addTags("p");
//		Jsoup.clean(res, Whitelist.basicWithImages());
		
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
