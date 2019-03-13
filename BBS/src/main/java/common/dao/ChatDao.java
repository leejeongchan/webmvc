package common.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.util.*;

import common.jdbc.JdbcUtil;
import common.jdbc.connection.ConnectionProvider;

import mvc.model.Chat;
/**
 * <pre> 
 * 채팅 CRUD DAO
 * </pre>
 * 
 * @author Jeong-Chan Lee
 * @since 2019.02.02
 * @return ChatDao 인스턴스
 */
public class ChatDao {
	/**
	 * <pre>
	 * 쓰레드 세이프한 싱글톤 패턴
	 * 클래스안에 클래스(Holder)를 두어 JVM의 Class loader 매커니즘과 Class가 로드되는 시점을 이용하는 방법
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.02.02
	 * @return ChatDao 인스턴스
	 */
	private ChatDao() {}
	private static class ChatDaoHolder{
		public static final ChatDao instance = new ChatDao();
	}
	public static ChatDao getInstance() {
		return ChatDaoHolder.instance;
	}
	/**
	 * <pre>
	 * 채팅 목록을 불러온다.
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.02.02
	 * @return ArrayList
	 */
	public ArrayList<Chat> getChatList(String nowTime) throws SQLException
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Chat> chatList = null;
		try(Connection conn = ConnectionProvider.getConnection()) {
			chatList=new ArrayList<Chat>();
			pstmt = conn
					.prepareStatement("SELECT * FROM chat WHERE CHAT_TIME > ? ORDER BY CHAT_TIME");
			pstmt.setString(1,nowTime);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Chat chat=new Chat();
				chat.setChatId(rs.getInt("CHAT_ID"));
				chat.setChatName(rs.getString("CHAT_NAME"));
				chat.setChatContent(rs.getString("CHAT_CONTENT").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("CHAT_TIME").substring(11,13));
				String timeType="오전";
				if(Integer.parseInt(rs.getString("CHAT_TIME").substring(11,13))>=12){
					timeType="오후";
					chatTime-=12;
				}
				chat.setChatTime(rs.getString("CHAT_TIME").substring(0,11)+" "+timeType+" "+chatTime+":"+rs.getString("CHAT_TIME").substring(14,16)+"");
				chatList.add(chat);
				
			}
			return chatList;
			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
	}
	/**
	 * <pre>
	 * 채팅 목록을 불러온다.
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.02.02
	 * @return ArrayList
	 */
	public ArrayList<Chat> getChatListByRecent(int number) throws SQLException
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Chat> chatList = null;
		try(Connection conn = ConnectionProvider.getConnection()) {
			chatList=new ArrayList<Chat>();
			pstmt = conn
					.prepareStatement("SELECT * FROM chat WHERE CHAT_ID > (SELECT MAX(CHAT_ID) - ? FROM chat) ORDER By CHAT_TIME");
			pstmt.setInt(1,number);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Chat chat=new Chat();
				chat.setChatId(rs.getInt("CHAT_ID"));
				chat.setChatName(rs.getString("CHAT_NAME"));
				chat.setChatContent(rs.getString("CHAT_CONTENT").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("CHAT_TIME").substring(11,13));
				String timeType="오전";
				if(Integer.parseInt(rs.getString("CHAT_TIME").substring(11,13))>=12){
					timeType="오후";
					chatTime-=12;
				}
				chat.setChatTime(rs.getString("CHAT_TIME").substring(0,11)+" "+timeType+" "+chatTime+":"+rs.getString("CHAT_TIME").substring(14,16)+"");
				chatList.add(chat);
				
			}
			return chatList;
			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
	}
	/**
	 * <pre>
	 * 채팅 목록을 불러온다.
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.02.02
	 * @return ArrayList
	 */
	public ArrayList<Chat> getChatListByRecent(String chatID) throws SQLException
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Chat> chatList = null;
		try(Connection conn = ConnectionProvider.getConnection()) {
			chatList=new ArrayList<Chat>();
			pstmt = conn
					.prepareStatement("SELECT * FROM chat WHERE CHAT_ID > ? ORDER BY CHAT_TIME");
			pstmt.setInt(1,Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Chat chat=new Chat();
				chat.setChatId(rs.getInt("CHAT_ID"));
				chat.setChatName(rs.getString("CHAT_NAME"));
				chat.setChatContent(rs.getString("CHAT_CONTENT").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("CHAT_TIME").substring(11,13));
				String timeType="오전";
				if(Integer.parseInt(rs.getString("CHAT_TIME").substring(11,13))>=12){
					timeType="오후";
					chatTime-=12;
				}
				chat.setChatTime(rs.getString("CHAT_TIME").substring(0,11)+" "+timeType+" "+chatTime+":"+rs.getString("CHAT_TIME").substring(14,16)+"");
				chatList.add(chat);
				
			}
			return chatList;
			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
	}
	/**
	 * <pre>
	 * 채팅 전송 기능 담당 CRUD.
	 * 채팅이름과 채팅 내용으 전송버튼 누를시 담아준다.
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.02.02
	 * @return int
	 */
	public int submit(String chatName,String chatContent) throws SQLException{
		PreparedStatement pstmt = null;

		try(Connection conn = ConnectionProvider.getConnection()) {
		
			pstmt = conn
					.prepareStatement("INSERT INTO chat VALUES (NULL,?,?,now())");
			pstmt.setString(1, chatName);
			pstmt.setString(2, chatContent);
			
			return pstmt.executeUpdate();
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			//JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return -1;
		
	}
	

}
