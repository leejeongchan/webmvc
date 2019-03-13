<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String url="http://localhost:8080/common/login.do";
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer=response.getWriter();
	out.println( "<script>"
   + "alert('암호가 변경 되었습니다. ');"
   + "location.href='"+ url +"';"
   + "</script>");

%>
</body>
</html>