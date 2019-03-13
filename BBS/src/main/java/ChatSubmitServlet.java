


import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.dao.ChatDao;
import mvc.model.HBox;

/**
 * Servlet implementation class ChatSubmitServlet
 */
@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatDao chatDao = ChatDao.getInstance();
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String chatName=URLDecoder.decode(request.getParameter("chatName"),"UTF-8");
		String chatContent=URLDecoder.decode(request.getParameter("chatContent"),"UTF-8");

		try {
			
			if(chatName == null || chatName.equals("") || chatContent==null || chatContent.equals(""))
			{
				response.getWriter().write("0");
				
			}
			else {
				response.getWriter().write(chatDao.submit(chatName,chatContent)+"");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
