package common.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import common.util.*;
import common.jdbc.JdbcUtil;
import mvc.model.HBox;
/**
 * <pre> 
 * User에 대한 CRUD를 구현한 DAO
 * </pre>
 * 
 * @author In-Seong Hwang
 * @since 2018.11.06 
 * @return CommonDao 인스턴스
 */
public class CommonDao {
	
	/**
	 * <pre>
	 * 쓰레드 세이프한 싱글톤 패턴
	 * 클래스안에 클래스(Holder)를 두어 JVM의 Class loader 매커니즘과 Class가 로드되는 시점을 이용하는 방법
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06 
	 * @return CommonDao 인스턴스
	 */
	private CommonDao() {}
	private static class CommonDaoHolder{
		public static final CommonDao instance = new CommonDao();
	}
	public static CommonDao getInstance() {
		return CommonDaoHolder.instance;
	}

	/**
	 * <pre>
	 * MEMBERID를 검색하여 HBox 형태로 리턴
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06        
	 * @return HBox
	 */
	
	public HBox selectById(Connection conn, HBox hBox) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {			
			pstmt = conn.prepareStatement(
					"select * from TB_MEMBER where MEMBER_ID = ?");
			pstmt.setString(1, hBox.getString("memberId"));
			rs = pstmt.executeQuery();
			HBox result= null;
			if (rs.next()) {
				result = new HBox();
				result.set("memberSeq", rs.getString("MEMBER_SEQ"));
				result.set("memberId", rs.getString("MEMBER_ID"));
				result.set("name",rs.getString("MEMBER_NAME"));
				result.set("password",rs.getString("MEMBER_PWD"));
				result.set("regDate",toDate(rs.getDate("REG_DATE")));
				result.set("userEmail",rs.getString("USER_EMAIL"));
				result.set("userIntro",rs.getString("USER_INTRO"));
				
			}
			
			return result;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	private Date toDate(Date date) {
		return date == null ? null : new Date(date.getTime());
	}
	/**
	 * <pre>
	 * HBox를 받아 DB에 넣어주는 로직
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06	          
	 * @return 
	 */	
	public void insert(Connection conn, HBox hBox) throws SQLException {
		try (PreparedStatement pstmt = 
				conn.prepareStatement("INSERT INTO TB_MEMBER VALUES(NULL,?,?,?,now(),?,?,false,NULL)")) {
			pstmt.setString(1, hBox.getString("password"));	
			pstmt.setString(2, hBox.getString("memberId"));
			pstmt.setString(3, hBox.getString("name"));
			pstmt.setString(4,hBox.getString("userEmail"));
			pstmt.setString(5,SHA256.getSHA256(hBox.getString("userEmail")));
	
			pstmt.executeUpdate();
			System.out.println("join(insert)실행");
		}
	}
	/**
	 * <pre>
	 * HBox를 받아 DB를 update 해주는 로직 
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06	          
	 * @return 
	 */
	public void update(Connection conn,HBox hBox) throws SQLException{
		try (PreparedStatement pstmt = conn.prepareStatement(
				"UPDATE TB_MEMBER SET MEMBER_PWD=? WHERE MEMBER_ID=?")){
			pstmt.setString(1, hBox.getString("password"));
			pstmt.setString(2, hBox.getString("memberId"));	
			pstmt.executeUpdate();
		}
	}
	/**
	 * <pre>
	 * HBox를 받아 DB를 update 해주는 로직(회원 자기소개서 정보USER_INTRO)
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.29          
	 * @return 
	 */
	public void updateIntro(Connection conn,HBox hBox) throws SQLException{
		try (PreparedStatement pstmt = conn.prepareStatement(
				"UPDATE TB_MEMBER SET USER_INTRO=? WHERE MEMBER_ID=?")){
			pstmt.setString(1, hBox.getString("userIntro"));
			pstmt.setString(2, hBox.getString("memberId"));	
			pstmt.executeUpdate();
		}
	}
	/**
	 * <pre>
	 * 이메일 조회해줌
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.07	          
	 * @return String(해당 이메일)
	 */
	public String getUserEmail(Connection conn,HBox hBox) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {			
			pstmt = conn.prepareStatement(
					"select USER_EMAIL from TB_MEMBER where MEMBER_ID=?");
			pstmt.setString(1, hBox.getString("memberId"));
			rs = pstmt.executeQuery();
			HBox result= null;
			if (rs.next()) {
				result = new HBox();
				
				result.set("userEmail",rs.getString("USER_EMAIL"));
				System.out.println("email:"+result.getString("userEmail"));
			}
			
			return result.getString("userEmail");
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	/**
	 * <pre>
	 * 이메일 가입 했을때 체크
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.07	          
	 * @return boolean
	 */
	public boolean setUserEmailChecked(Connection conn,String hBoxmemberId) throws SQLException{
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement("UPDATE tb_member SET USER_EMCHECKED=true WHERE MEMBER_ID=?");
			pstmt.setString(1, hBoxmemberId);
			pstmt.executeUpdate();
			return true;
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			JdbcUtil.close(pstmt);
		}
		return false;
	}
	/**
	 * <pre>
	 * 이메일 체크를 얻는 용도
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.07	          
	 * @return boolean
	 */
	public boolean getUserEmailChecked(Connection conn,String hBoxmemberId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {			
			pstmt = conn.prepareStatement(
					"select USER_EMCHECKED from TB_MEMBER where MEMBER_ID = ?");
			pstmt.setString(1, hBoxmemberId);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
			
				
				return rs.getBoolean(1);
				
			}
			
			
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return false;
	}
	/*
	 * 위에서 이메일 관련 컬럼 추가된것 추가하게 수정
	 */

}
