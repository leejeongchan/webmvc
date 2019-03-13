package mvc.controller.bbs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.article.ArticleService;
//검색기능 컨트롤러
/**
 * <pre>
 * 게시글 검색 기능 컨트롤러
 * 	
 * </pre> 
 * @author Jeong-Chan Lee
 * @since 2019.02.01       
 *  
 */
public class SearchListController implements CommandHandler{
	private ArticleService articleService = new ArticleService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]:넘겨온 옵션과 단어
		HBox hBox = (HBox)req.getAttribute("hBox");

		HBox result = articleService.getSearchArticlePage(hBox);
		
		//각 게시글의 댓글 수를 읽어서 
		req.setAttribute("result", result);
		
		return "/WEB-INF/view/article/searchlistArticle.jsp";		
	}

}