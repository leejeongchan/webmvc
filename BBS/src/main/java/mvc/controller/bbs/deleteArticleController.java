package mvc.controller.bbs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.article.ArticleService;
/**
 * <pre>
 * 게시글 삭제 구현 컨트롤러
 * 	
 * </pre> 
 * @author Jeong-Chan Lee
 * @since 2019.01.04      
 *  
 */
public class deleteArticleController implements CommandHandler  {
	ArticleService articleService = new ArticleService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {		
		HBox hBox = (HBox)req.getAttribute("hBox");
		
		Boolean result=articleService.delete(hBox);
		System.out.println(result);
		if(result)
		{
			return "/WEB-INF/view/article/deleteArticleSuccess.jsp";
		}
		else
		{
			return "/WEB-INF/view/article/deleteArticleFail.jsp";
		}
		
	
	}
}
