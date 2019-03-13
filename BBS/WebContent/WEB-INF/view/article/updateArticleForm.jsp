<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set value="${result.articleResult}" var="articleResult" />
<c:set value="${result.contentResult}" var="contentResult" />
<c:set value="${result.articleList}" var="articleList" />

<c:set value="${hBox}" var="hBox" />

<!DOCTYPE html>
<html>
<head>
<title>게시글 읽기</title>
<%-- 적용 CSS --%>
<link type="text/css" rel="stylesheet" href="${CSS}/common/reset.css">
<%-- 적용 JS --%>
<script type="text/javascript" src="${JS}/common/common.js"></script>
<script type="text/javascript" src="${JS}/jquery/jquery-1.12.3.js"></script>
<script type="text/javascript" src="${JS}/jquery/jquery.form.js"></script>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
</head>
<body>
	
	<section class="container mt-3" style="max-width: 560px;">

		<form method="post" action="modify.do">
			
		<input type="hidden" name="bdSeq" value="${articleResult.bdSeq}">
			<div class="form-group">
				<label>번호</label><input type="text"
					value="${articleResult.bdSeq}" readonly class="form-control">
			</div>
			<div class="form-group">
				<label>작성자</label><input type="text"
					value="${articleResult.writerName}" readonly class="form-control">
			</div>
			<div class="form-group">
				<label>제목</label> <input type="text" name="bdTitle"
					value="${articleResult.bdTitle}" class="form-control">
				<c:if test="${errors.bdTitle}">제목을 입력하세요.</c:if>
			</div>


			<div class="form-group">
				<label>내용</label>
				<textarea name="bdContent" rows="5" cols="30" class="form-control">${contentResult.bdContent}</textarea>

			</div>


			<button type="submit" class="btn btn-primary">게시글 수정</button>
			<a class="btn btn-primary" href="/article/list.do">게시글로 이동</a>
		</form>

	</section>
	<!-- 
	<form action="modify.do" method="post">
		번호:<input type="hidden" name="bdSeq" value="${articleResult.bdSeq}">

		<table border="1">

			<tr>
				<td>번호</td>
				<td>${articleResult.bdSeq}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${articleResult.writerName}</td>
			</tr>
		</table>
		<p>
			제목:<br />
			<input type="text" name="bdTitle" value="${articleResult.bdTitle}">
			<c:if test="${errors.bdTitle}">제목을 입력하세요.</c:if>
		</p>
		<p>
			내용:<br />
			<textarea name="bdContent" rows="5" cols="30">${contentResult.bdContent}</textarea>
		</p>
		<table border="1">

			<tr>
				<td colspan="2"><c:set var="pageNo"
						value="${empty hBox.curPage ? '1' : hBox.curPage}" /> <a
					href="list.do?pageNo=${pageNo}">[목록]</a>
			</tr>

		</table>
		<input type="submit" value="수정 완료">
	</form>
	-->
	<footer class="bg-dark mt-3 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 이정찬 All Rights Reserved. </footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="../../../web/js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="../../../web/js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="../../../web/js/bootstrap.min.js"></script>