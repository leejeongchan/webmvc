package mvc.service.common;

import java.sql.Connection;
import java.sql.SQLException;

import common.dao.CommonDao;
import common.exception.DuplicateIdException;
import common.jdbc.JdbcUtil;
import common.jdbc.connection.ConnectionProvider;
import mvc.model.HBox;

import javax.mail.Transport;
import javax.mail.Address; 
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Session;
import javax.mail.Authenticator;

import java.util.Properties;
import common.util.Gmail;
import common.util.SHA256;
import java.io.PrintWriter;
/**
 * <pre>
 * 회원가입 서비스
 * </pre>
 * 
 * @author In-Seong Hwang
 * @since 2018.11.06            
 *
 */
public class JoinService {
	
	private CommonDao commonDao = CommonDao.getInstance();
	
	/**
	 * <pre>
	 * hBox를  받아 DB에 정보가 있는지 확인하고 이후에 없다면
	 * 넣어준다
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06            
	 * @param HBox
	 * 
	 */	
	public void join(HBox hBox) {
		Connection conn = null;
		HBox result = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			result = commonDao.selectById(conn, hBox);
			if(result!=null) {
				JdbcUtil.rollback(conn);
				throw new DuplicateIdException();
			}
			commonDao.insert(conn, hBox);
			conn.commit();
		}catch (SQLException e) {			
		}
	}	
	/**
	 * <pre>
	 * errors에 각각 key값에 대해 비어있는지 체크유무	 * 
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param errors : HBox가 비어있는지 관한 true false
	 *   hBox : key 대응하는 값을 체크하기위한 객체 
	 * 
	 */	
	public void validate(HBox errors,HBox hBox) {
		checkEmpty(errors, hBox,"memberId");
		checkEmpty(errors, hBox,"name");
		checkEmpty(errors, hBox,"password");
		checkEmpty(errors, hBox,"confirmPassword");
		if(!errors.containsKey("confirmPassword")) {
			if(!isPasswordEqualToConfirm(hBox)) {
				errors.set("notMatch", Boolean.TRUE);
			}
		}		
	}
	/**
	 * <pre>
	 * 이메일 체크 설정 해주기.
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.07
	 * @param 해당 Id
	 * 
	 */	
	public void setemailcheck(String hBoxmemberId)
	{
		Connection conn=null;
		try {
			conn=ConnectionProvider.getConnection();
			//conn.setAutoCommit(false);
			commonDao.setUserEmailChecked(conn, hBoxmemberId);
			
		}catch (SQLException e) {			
		}
	}
	/**
	 * <pre>
	 * 이메일 체크 얻기 서비스
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.12
	 * @param 해당 Id
	 * 
	 */	
	public boolean getemailcheck(String hBoxmemberId)
	{
		Connection conn=null;
		try {
			conn=ConnectionProvider.getConnection();
			Boolean emchk=commonDao.getUserEmailChecked(conn, hBoxmemberId);
			return emchk;
		}catch (SQLException e) {			
		}
		return false;
	}
	/**
	 * <pre>
	 * 이메일 보내기 서비스
	 * </pre>
	 * 
	 * @author Jeong-Chan Lee
	 * @since 2019.01.07
	 * @param HBox
	 * 
	 */	
	public void emailSendService(HBox hBox) {
		Connection conn=null;
		try {
			System.out.println("이메일보내기서비스 에서 hBox의 갑 찍기:"+hBox.getString("userEmail"));
			conn=ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			System.out.println("이메일 인증 보내기.");
			String from="wjdcks5343@gmail.com";
			String to=commonDao.getUserEmail(conn, hBox);
			System.out.println(to);
			String subject="가입을 위한 이메일 인증 메일입니다.";
			String content="다음 버튼을 눌러서 이메일 인증을 진행하세요."
			+"<form method='get' action='http://localhost:8080/common/emailCheck.do'>"
			+ "<input type='hidden' name='code' value="+new SHA256().getSHA256(to)+"></input>"
			+ "<input type='hidden' name='hBoxEmail' value="+hBox.getString("userEmail")+"></input>"
			+ "<input type='hidden' name='hBoxmemberId' value="+hBox.getString("memberId")+"></input>"
			+ "<input type='submit' value='이메일인증하기'></input>"
			+ "</form>";
			//+"<a href='http://localhost:8080/common/emailCheck.do?code="+new SHA256().getSHA256(to)+"&hBox="+hBox+"'>이메일 인증하기</a>";
			Properties p=new Properties();
			p.put("mail.smtp.user",from);
			p.put("mail.smtp.host","smtp.googlemail.com");
			p.put("mail.smtp.port",465);
			p.put("mail.smtp.starttls.enable","true");
			p.put("mail.smtp.auth","true");
			p.put("mail.smtp.debug","true");
			p.put("mail.smtp.socketFactory.port","465");
			p.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			p.put("mail.smtp.socketFactory.fallback","false");
			try {
				Authenticator auth=new Gmail();
				Session ses=Session.getInstance(p,auth);
				ses.setDebug(true);
				MimeMessage msg=new MimeMessage(ses); 
				msg.setSubject(subject);
				msg.setContent(content,"text/html; charset=utf-8");
				Address fromAddr=new InternetAddress(from);
				msg.setFrom(fromAddr);
				Address toAddr=new InternetAddress(to);
				msg.addRecipient(Message.RecipientType.TO,toAddr);
				Transport.send(msg);
			}catch(Exception e)
			{
				e.printStackTrace();
				
				return;
			}
			
		}catch (SQLException e) {			
		}
	}
	/**
	 * <pre>
	 * key에 해당하는 value가 없을 경우 errors객체안에 key에 대한 true를 등록해준다.  
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param hBox : key 에 대응하는 value가 존재한느지 체크
	 * 		errors key에 대응하는 valu가 비어있을 경우 true를 넣어준다.	 
	 * 
	 */
	/*
	 * 
	 */
	private void checkEmpty(HBox errors,HBox hBox,String key) {
		if(hBox.isEmpty(key)) {
			errors.set(key, Boolean.TRUE);
		}		
	}	
	/**
	 * <pre>
	 * 입력한 2개의 패스워드가 동일한지 체크 ( AJAX를 통해 구현 예정)  
	 * </pre>
	 * 
	 * @author In-Seong Hwang
	 * @since 2018.11.06
	 * @param hBox : 패스워드 체크할 객체
	 * @return true : paswword가 null 이아니며 2개의 패스워드가 동일
	 * 
	 */
	public boolean isPasswordEqualToConfirm(HBox hBox) {
		return hBox.getString("password") != null && hBox.getString("confirmPassword").equals(hBox.getString("password"));
	}
	
}
