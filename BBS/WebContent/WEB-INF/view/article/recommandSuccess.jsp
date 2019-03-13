<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*" %>
<c:set var="result" value="${result}" scope="request"></c:set>
<!DOCTYPE html>
<html>
<head>
<title>게시글 등록</title>

</head>
<body>

<%
	String url="http://localhost:8080/article/list.do";
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer=response.getWriter();
	out.println( "<script>"
   + "alert('게시글이 추천되었습니다.');"
   + "location.href='"+ url +"';"
   + "</script>");

%>
</body>
</html>