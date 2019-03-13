package mvc.controller.bbs;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.article.ArticleService;

public class RecommandArticleController implements CommandHandler{
	private ArticleService articleService = new ArticleService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]:인터셉터를 통해 넘어온 HBox
		HBox hBox = (HBox)req.getAttribute("hBox");
		//HBox result = articleService.getArticlePage(hBox);
		
		//좋아요 테이블에 삽입 서비스 호출
		//좋아요 테이블 조회하여 리턴값 받기하고 recommand인자로 flag 넘기기
		articleService.recommand(hBox);
		//만약 실패시 받은 값을 통해 return recommandFail.jsp로 이동
		
		
		return "/WEB-INF/view/article/recommandSuccess.jsp";
	}

}