package mvc.controller.common;

/**
 * <pre>
 * 회원이 이메일 인증버튼을 메일로 누를 시 이동한다. 여기서 메일 인증 검증을 거친다.
 * 	
 * </pre> * 
 * @author Jeong-Chan Lee
 * @since 2018.11.06         
 *  
 */


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.util.SHA256;
import mvc.command.CommandHandler;
import mvc.model.HBox;

import mvc.service.common.JoinService;

public class emailCheckController implements CommandHandler {
	private static final String FORM_VIEW = "/WEB-INF/view/common/loginPopup.jsp";
	private JoinService JoinService = new JoinService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]: 이메일 보내기 서비스에서 HBox에 있는 이메일과 아이디를 인자로 넘겨줘서 받는 부분
		String userEmail=(String)req.getParameter("hBoxEmail");
		String memberId=(String)req.getParameter("hBoxmemberId");
		String code=null;
		//res.setContentType("text/html; charset=UTF-8");
	
		if(req.getParameter("code")!=null)
		{
			System.out.println("1");
			code=req.getParameter("code");
		}
		
		System.out.println("userEmail:"+userEmail);
		System.out.println("userEmailHash:"+new SHA256().getSHA256(userEmail));
		boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true: false;
		System.out.println("isRight:"+isRight);
		//[2]: 이메일 인증이 완료 될 경우 
		if(isRight==true)
		{
			System.out.println("memberId:"+memberId);
			JoinService.setemailcheck(memberId);
			
			

		}
		//[3]: 팝업창 띄우기 위해 팝업jsp로 이동하여 login.do로 이동
		System.out.println("popup page move");
		return FORM_VIEW;
	}
	
}
