<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자기소개서 확인알림</title>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
</head>
<body>
<%
	String url="http://localhost:8080/common/login.do";
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer=response.getWriter();
	out.println( "<script>"
   + "alert('자기소개서 등록이 완료되었습니다. 메인페이지로 이동합니다.');"
   + "location.href='"+ url +"';"
   + "</script>");

%>
</body>
</html>