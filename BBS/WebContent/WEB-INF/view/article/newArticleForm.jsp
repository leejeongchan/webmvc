<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>게시글 쓰기</title>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
</head>
<body>
<section class="container mt-3" style="max-width: 560px;">
		
		<form method="post" action="write.do">
			
			<div class="form-group">
				<label>제목</label> <input type="text" name="bdTitle"
					value="${param.bdTitle}" class="form-control">
				<c:if test="${errors.bdTitle}">제목을 입력하세요.</c:if>
			</div>
			
			
			<div class="form-group">
				<label>내용</label> <textarea  name="bdContent" rows="5" cols="30"
					class="form-control">${param.bdContent}</textarea>
			
			</div>
			
			
			<button type="submit" class="btn btn-primary">새 글 등록</button>
			<a class="btn btn-primary" href="/article/list.do">게시글로 이동</a> 
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