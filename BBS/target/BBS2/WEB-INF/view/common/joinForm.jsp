<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>가입</title>
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
		
		<h1 class="h3 mt-2 text-center">Please Join in</h1>
		
		<form method="post" action="join.do">
			<div class="form-group">
				<label>아이디</label> <input type="text" name="memberId" value="${param.id }"
					class="form-control">
				<c:if test="${errors.memberId}">ID를 입력하세요.</c:if>
				<c:if test="${errors.duplicateId}">이미 사용중인 아이디입니다.</c:if>
			</div>
			
			<div class="form-group">
				<label>이름</label> <input type="text" name="name" value="${param.name }"
					class="form-control">
				<c:if test="${errors.name}">이름을 입력하세요.</c:if>
			</div>
			
			<div class="form-group">
				<label>비밀번호</label> <input type="password" name="password"
					class="form-control">
			<c:if test="${errors.password}">암호를 입력하세요.</c:if>
			</div>
			
			<div class="form-group">
				<label>비밀번호 확인</label> <input type="password" name="confirmPassword"
					class="form-control">
			<c:if test="${errors.confirmPassword}">비밀번호 확인을 입력하세요.</c:if>
			<c:if test="${errors.notMatch}">암호와 확인이 일치하지 않습니다.</c:if>
			</div>
			
			<div class="form-group">
				<label>이메일(인증)</label> <input type="email" name="userEmail"
					class="form-control">
			<c:if test="${errors.userEmail}">이메일을 입력하세요.</c:if>
			</div>
			
			<button type="submit" class="btn btn-primary">회원가입</button>
			<a class="btn btn-primary" href="login.do">로그인화면으로</a>
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