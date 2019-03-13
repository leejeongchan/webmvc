package mvc.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.exception.DuplicateIdException;
import common.util.SHA256;
import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.common.JoinService;
/**
 * <pre>
 * JoinHandler GET 과 POST를 구별하여 각각 핸들링한다.
 * 	
 * </pre> * 
 * @author In-Seong Hwang,Jeong-Chan Lee
 * @since 2018.11.06         
 *  
 */
public class JoinController implements CommandHandler{

	private static final String FORM_VIEW = "/WEB-INF/view/common/joinForm.jsp";
	private JoinService JoinService = new JoinService();
	/**
	 * <pre>
	 * GET: 로그인 폼
	 * POST: 회원가입 정보에 대한 validate 수행후 정상인경우에만 view 전송  
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param request,response	 *         
	 * @return 페이지값이 들어있는 String
	 */
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
		return FORM_VIEW;		
	}
	private String processSubmit(HttpServletRequest req,HttpServletResponse res) {
	
		
		//[1] hBox를 받는다.
		System.out.println("1");
		HBox hBox = (HBox)req.getAttribute("hBox");
		
		
		// [2] errors 객체  
		HBox errors = new HBox();
		req.setAttribute("errors", errors);
		
		JoinService.validate(errors, hBox);
		System.out.println("2");
		if(!errors.isEmpty()) {
			return FORM_VIEW;
		}		
		try {
			System.out.println("3");
			JoinService.join(hBox);
			//[3]:이메일 보내기 서비스
			JoinService.emailSendService(hBox);
			//[4]:이메일 보내고 사용자가 인증 누르면 코드 값이 전달 됨
			
			return "/WEB-INF/view/common/joinWait.jsp";
		}catch(DuplicateIdException e) {
			errors.set("duplicateId", Boolean.TRUE);
			return FORM_VIEW;
		}		
	}

}
