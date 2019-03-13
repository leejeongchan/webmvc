package mvc.controller.common;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import mvc.command.CommandHandler;
import mvc.model.HBox;
import mvc.service.common.QuestionService;
/**
 * <pre>
 * 문의에 대한 컨트롤러
 * 각 필드 값을 받아서 문의메일 보내기 서비스 진행
 * 성공 하면 성공 팝업
 * 실패하면 실패 팝업
 * </pre>
 * 
 * @author Jeong-Chan Lee
 * @since 2019.02.27	 * *            
 * 
 */

public class QuestionEmailController implements CommandHandler {
	private QuestionService questionService=new QuestionService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]: to,from,Name,Message를 HBox의 형태로 바당옴
		HBox hBox = (HBox)req.getAttribute("hBox");	
		
		int flag=questionService.QuestionSendService(hBox);
		if(flag==-1)
			return "/WEB-INF/view/common/questionPopupfail.jsp";
		return "/WEB-INF/view/common/questionPopup.jsp";
	}
}
