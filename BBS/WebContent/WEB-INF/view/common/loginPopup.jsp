<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 팝업창 띄우고 login.do로 이동하여 로그인화면 띄우기 -->
<%
	String url="http://localhost:8080/common/login.do";
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer=response.getWriter();
	out.println( "<script>"
   + "alert('이메일 인증이 완료됐습니다. 로그인하세요.');"
   + "location.href='"+ url +"';"
   + "</script>");

%>
</body>
</html>