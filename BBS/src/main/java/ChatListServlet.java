


import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.dao.ChatDao;
import mvc.model.Chat;
import mvc.model.HBox;

/**
 * Servlet implementation class ChatSubmitServlet
 */
@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatDao chatDao = ChatDao.getInstance();
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String listType=request.getParameter("listType");
		if(listType==null || listType.equals(""))
		{
			response.getWriter().write("");
		}
		else if(listType.equals("today"))
		{
			response.getWriter().write(getToday());
		}
		else if(listType.equals("ten"))
		{
			response.getWriter().write(getTen());
		}
		else {
			try {
				Integer.parseInt(listType);
				response.getWriter().write(getID(listType));
			}catch(Exception e)
			{
				response.getWriter().write("");
			}
		}
		
	}
	
	public String getToday() {
		StringBuffer result=new StringBuffer("");
		try {
			
			result.append("{\"result\":[");
			ArrayList<Chat> chatList = chatDao.getChatList(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			for(int i=0; i<chatList.size(); i++) {
				result.append("[{\"value\": \""+ chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \""+ chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \""+ chatList.get(i).getChatTime() + "\"}]");
				if(i!=chatList.size()-1) {
					result.append(",");
					
				}
			
				
			}
			result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getChatId() + "\"}");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}
	
	public String getTen() {
		StringBuffer result=new StringBuffer("");
		try {
			
			result.append("{\"result\":[");
			ArrayList<Chat> chatList = chatDao.getChatListByRecent(10);
			for(int i=0; i<chatList.size(); i++) {
				result.append("[{\"value\": \""+ chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \""+ chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \""+ chatList.get(i).getChatTime() + "\"}]");
				if(i!=chatList.size()-1) {
					result.append(",");
					
				}
			
				
			}
			result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getChatId() + "\"}");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}
	
	public String getID(String chatID) {
		StringBuffer result=new StringBuffer("");
		try {
			
			result.append("{\"result\":[");
			ArrayList<Chat> chatList = chatDao.getChatListByRecent(chatID);
			for(int i=0; i<chatList.size(); i++) {
				result.append("[{\"value\": \""+ chatList.get(i).getChatName() + "\"},");
				result.append("{\"value\": \""+ chatList.get(i).getChatContent() + "\"},");
				result.append("{\"value\": \""+ chatList.get(i).getChatTime() + "\"}]");
				if(i!=chatList.size()-1) {
					result.append(",");
					
				}
			
				
			}
			result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getChatId() + "\"}");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}

}
