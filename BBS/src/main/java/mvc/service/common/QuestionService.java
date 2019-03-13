package mvc.service.common;

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
/**
 * <pre>
 * 문의 메일 보내기 서비스
 * 각ㄱ SMTP를 통해 메일을 보낸다.
 * </pre>
 * 
 * @author Jeong-Chan Lee
 * @since 2019.02.27	 * *            
 * 
 */

public class QuestionService {
	
	public int QuestionSendService(HBox hBox) {
		
		try {
			System.out.println("문의 보내기.");
			String from=hBox.getString("from");
			String to=hBox.getString("to");
			System.out.println(to);
			String subject=hBox.getString("Name")+"님의 문의입니다.";
			String content=hBox.getString("Message");
			System.out.println(subject);
			System.out.println(content);
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
				return -1;
				
			}
			
		}catch (Exception e) {	
			return -1;
		}
		return 1;
	}
}
