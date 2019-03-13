package common.util;


import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
/**
 * <pre>
 * Gmail의 계정에 따라 권한을 부여를 위함
 * </pre>
 * 
 * @author Jeong-Chan Lee
 * @since 2019.01.04
 * 
 */
public class Gmail extends Authenticator{
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("wjdcks5343@gmail.com", "7342ysYS__");
		
	}
	
}