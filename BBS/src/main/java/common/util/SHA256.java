package common.util;

import java.security.MessageDigest;
/**
 * <pre>
 * 이메일을 해시값과 salt로 변환 시켜줌 (보안 유지)
 * 추후 이메일 해시값으로 이메일 인증을 진행
 * 해시값과의 일치 여부로 이메일 인증 성공 여부 파악
 * </pre>
 * 
 * @author Jeong-Chan Lee
 * @since 2019.01.04
 * 
 */
public class SHA256 {
	//[1]:input은 이메일을 받아 해시값을 반환
	public static String getSHA256(String input)
	{
		StringBuffer result=new StringBuffer();
		try {
			MessageDigest digest=MessageDigest.getInstance("SHA-256");
			byte[] salt="Hello! This is Salt.".getBytes();
			digest.reset();
			digest.update(salt);
			byte[] chars=digest.digest(input.getBytes("UTF-8"));
			for(int i=0; i<chars.length; i++)
			{
				String hex=Integer.toHexString(0xff & chars[i]);
				if(hex.length()==1) result.append("0");
				result.append(hex);
				
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return result.toString();
	}
	
}