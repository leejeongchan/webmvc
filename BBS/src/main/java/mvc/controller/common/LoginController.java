package mvc.controller.common;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.exception.LoginFailException;
import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.common.JoinService;
import mvc.service.common.LoginService;
/**
 * <pre>
 * LoginController 로그인 요청을 받아서 서비스를 처리한다.
 * GET : loginform 을 보여준다.
 * POST : 조건에 따라 로그인 성공 또는 다시 loginform을 보여준다.
 * 성공 시 : authUser 세션과 비밀번호를 제외한 모든 것을 세션을 잡아준다.
 * </pre>
 * 
 * @author In-Seong Hwang
 * @since 2018.11.06	 * *            
 * 
 */
public class LoginController implements CommandHandler{
	
	private static final String FORM_VIEW = "/WEB-INF/view/common/loginForm.jsp";
	//private static final String FORM_VIEW = "/common/loginForm.jsp";
	private LoginService loginService = new LoginService();
	//[1]:JoinService는 메일 재전송을 판단하기 위해서
	private JoinService JoinService = new JoinService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req,res);
		}else if(req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		}else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}		
	}
	private String processForm(HttpServletRequest req , HttpServletResponse res) {
		System.out.println("login page move");
		return FORM_VIEW;
	}
	private String processSubmit(HttpServletRequest req , HttpServletResponse res) throws Exception {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out=res.getWriter();
		
		HBox hBox = (HBox)req.getAttribute("hBox");		
		Boolean emChk=JoinService.getemailcheck(hBox.getString("memberId"));
		System.out.println(emChk);
		//[2]: 이메일 체크 안돼있을 때 메일 재전송
		//Jeong-Chan Lee
		if(emChk==false)
		{
			JoinService.emailSendService(hBox);
			JoinService.setemailcheck(hBox.getString("memberId"));
		
			out.println("<script>");
			out.println("alert('이메일 인증이 제대로 이루어지지 않았습니다. 이메일 재전송 합니다.');");
			out.println("location.href='http://localhost:8080/common/login.do';");
			out.println("</script>");
			out.close();
		}
		else {
		HBox errors = new HBox();
		req.setAttribute("errors", errors);
		
		if(hBox.isEmpty("memberId")) {
			errors.set("memberId", Boolean.TRUE);
		}
		if(hBox.isEmpty("password")) {
			errors.set("password",Boolean.TRUE);
		}
		if(!errors.isEmpty()) {
			return FORM_VIEW; 
		}	
		try {
			HBox result = loginService.login(hBox);
			req.getSession().setAttribute("authUser", result);
			req.getSession().setAttribute("memberSeq", result.getString("memberSeq"));			
			req.getSession().setAttribute("memberId", result.getString("memberId"));
			req.getSession().setAttribute("name", result.getString("name"));
			req.getSession().setAttribute("regDate", result.getString("regDate"));
			
		
			
			return "/WEB-INF/view/common/main.jsp";
		} catch (LoginFailException e) {
			errors.set("idOrPwNotMatch",Boolean.TRUE);
			return FORM_VIEW;
		}
		
		}
		return FORM_VIEW;
	}
}
