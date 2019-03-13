package mvc.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.common.LoginService;

public class MainPageController implements CommandHandler{
	private static final String FORM_VIEW = "/WEB-INF/view/common/loginForm.jsp";
	private LoginService loginService = new LoginService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req,res);		
		}else if(req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res); 
		}else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		}
		return null;
	}
	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		HBox hBox = (HBox)req.getAttribute("hBox");
		HBox parm = (HBox) req.getSession().getAttribute("authUser");	
		hBox.set("memberId",parm.getString("memberId"));
		
		HBox result=loginService.infolist(hBox);
		
		req.setAttribute("result", result);
		return "/WEB-INF/view/common/main.jsp";		
	}
	private String processSubmit(HttpServletRequest req,HttpServletResponse res) {	
		HBox hBox = (HBox)req.getAttribute("hBox");
		HBox parm = (HBox) req.getSession().getAttribute("authUser");	
		hBox.set("memberId",parm.getString("memberId"));
		
		HBox result=loginService.infolist(hBox);
		
		req.setAttribute("result", result);
		return "/WEB-INF/view/common/main.jsp";		
	}
}
