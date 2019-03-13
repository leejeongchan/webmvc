package mvc.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.common.LoginService;

/**
 * <pre>
 * 자기소개서를 보여주는 컨트롤러
 * 	
 * </pre> 
 * @author Jeong-Chan Lee
 * @since 2019.02.04       
 *  
 */
public class IntroListController implements CommandHandler{
private LoginService loginService = new LoginService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]:인터셉터를 통해 넘어온 HBox
		HBox hBox = (HBox)req.getAttribute("hBox");
		
		HBox result=loginService.infolist(hBox);
		
		req.setAttribute("result", result);
		
		return "/WEB-INF/view/common/introlist.jsp";		
	}
}
