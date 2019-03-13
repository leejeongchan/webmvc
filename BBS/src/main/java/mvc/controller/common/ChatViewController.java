package mvc.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
/**
 * <pre>
 * 익명 채팅방을 보여주기
 * 	
 * </pre> 
 * @author Jeong-Chan Lee
 * @since 2019.02.04       
 *  
 */

public class ChatViewController implements CommandHandler{
	
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//[1]:인터셉터를 통해 넘어온 HBox
		//HBox hBox = (HBox)req.getAttribute("hBox");
		
		return "/WEB-INF/view/chat/chatview.jsp";		
	}
}