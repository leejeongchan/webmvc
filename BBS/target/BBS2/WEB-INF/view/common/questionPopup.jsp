<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의성공</title>
</head>
<body>
<!-- 팝업창 띄우고  -->
<%
	String url="http://localhost:8080/common/main.do";
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer=response.getWriter();
	out.println( "<script>"
   + "alert('문의를 성공적으로 보냈습니다.');"
   + "location.href='"+ url +"';"
   + "</script>");

%>
</body>
</html>