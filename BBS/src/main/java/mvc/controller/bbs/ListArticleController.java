package mvc.controller.bbs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.article.ArticleService;

public class ListArticleController implements CommandHandler{
	private ArticleService articleService = new ArticleService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]:인터셉터를 통해 넘어온 HBox
		HBox hBox = (HBox)req.getAttribute("hBox");
		//int bdSeq=(int)req.getAttribute("bdSeq");
		HBox result = articleService.getArticlePage(hBox);
		
		
		//각 게시글의 댓글 수를 읽어서 
		req.setAttribute("result", result);
		
		return "/WEB-INF/view/article/listArticle.jsp";		
	}

}
