package mvc.controller.bbs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.article.ArticleService;

/**
 * <pre>
 * 게시글 수정 컨트롤러
 * 	
 * </pre> 
 * @author Jeong-Chan Lee
 * @since 2019.02.04       
 *  
 */
public class UpdateArticleController implements CommandHandler {
	private static final String FORM_VIEW = "/WEB-INF/view/article/updateArticleForm.jsp";
	private ArticleService articleService = new ArticleService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		}else if(req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		}else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}		
	} 
	private String processForm(HttpServletRequest req ,HttpServletResponse res) {
		HBox hBox = (HBox)req.getAttribute("hBox");
		//[1]: 우선 게시글 정보 얻어오기 조회수 늘리지 않기 위해 false
		HBox result =  articleService.getArticle(hBox, false);
		req.setAttribute("result", result);	
		return FORM_VIEW;
	}
	private String processSubmit(HttpServletRequest req , HttpServletResponse res) {
		
		HBox errors = new HBox();
		req.setAttribute("errors", errors);
		HBox hBox = (HBox)req.getAttribute("hBox");
		articleService.validate(errors, hBox);
		if(!errors.isEmpty()) {
			return FORM_VIEW;
		}		
		HBox result = articleService.update(hBox); 
		req.setAttribute("result", result);		
		return "/WEB-INF/view/article/updateArticleSuccess.jsp";		
	}
	

	
}