<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>암호 변경</title>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
</head>
<body>

<section class="container mt-3" style="max-width: 560px;">
		<div class="text-center">
		<img class="mt-3 center-block" src="../../../web/img/logo.jpg" alt="" width="72" height="72" >
		</div>
		
		<h1 class="h3 mt-2 text-center">Please Change Password</h1>
		<form method="post" action="changePwd.do">
			
			
			<div class="form-group">
				<label>현재 비밀번호</label> <input type="password" name="curPassword"
					value="${param.memberId}" class="form-control">
				<c:if test="${errors.curPassword}">현재 암호를 입력하세요.</c:if>
				<c:if test="${errors.badCurPwd}">현재 암호가 일치하지 않습니다.</c:if>
			</div>
			
			
			<div class="form-group">
				<label>새 비밀번호</label> <input type="password" name="newPassword"
					class="form-control">
				<c:if test="${errors.newPassword}">새 암호를 입력하세요.</c:if>
			</div>
			
			
			<button type="submit" class="btn btn-primary">비밀번호 변경</button>
			<a class="btn btn-primary" href="/common/login.do">메인으로 이동</a>
		</form>
		
	</section>
	<footer class="bg-dark mt-3 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 이정찬 All Rights Reserved. </footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="../../../web/js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="../../../web/js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="../../../web/js/bootstrap.min.js"></script>

</body>
</html>