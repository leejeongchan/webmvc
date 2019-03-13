<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set value="${result.articleList }" var="articleList"/>
<c:set value="${result.totalCnt}" var="totalCnt"/>
<c:set value="${result.curPage}" var="curPage"/>
<c:set value="${hBox}" var="hBox"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 게시글</title>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
<%-- 적용 CSS --%>
<!--<link type="text/css" rel="stylesheet" href="${CSS}/common/reset.css">-->
<%-- 적용 JS --%>
<script type="text/javascript" src="${JS}/common/common.js"></script>
<script type="text/javascript" src="${JS}/jquery/jquery-1.12.3.js"></script>
<script type="text/javascript" src="${JS}/jquery/jquery.form.js"></script>
</head>
<body>
<c:if test="${sessionScope.authUser ne null}">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="/common/login.do">소통의 공간</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
			
				<li class="nav-item active">
					<a class="nav-link" href="/common/login.do">메인</a>
				</li>
				
				<li class="nav-item active">
					<a class="nav-link" href="/article/list.do">게시글</a>
				</li>
				
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원 관리
					</a>
					
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<c:if test="${empty authUser}">
						<a class="dropdown-item" href="login.do">로그인</a>
						<a class="dropdown-item" href="join.do">회원가입</a>
						</c:if>
						
						<a class="dropdown-item" href="/common/logout.do">로그아웃</a>
						<a class="dropdown-item" href="/common/changePwd.do">비밀번호 변경</a>
						<a class="dropdown-item" href="/common/infolist.do">회원정보 조회</a>
					</div>
				</li>
			
			</ul>
			<a class="btn btn-primary" href="list.do">목록으로 이동</a>
		</div>
	</nav>
</c:if>


<section class="container mt-5" style="max-width:1400px;">
<form name="articleForm" autocomplete="off">
<%-- INPUT HIDDEN 영역 시작 --%>
	<%-- 페이징을 위해서는 아래 형식의 curPage, action 필수(id값을 통해 페이징 시킴) --%>
	<input type="hidden" name="curPage" id="curPage" value="${hBox.curPage}" />
	<input type="hidden" name="action" id="action" value="${HOME}/article/list.do" />
<%-- INPUT HIDDEN 영역 종료 --%>
<c:if test="${empty articleList }">
	<tr>
		<td colspan="4">검색된 게시글이 없습니다.</td>
	</tr>
</c:if>
<c:forEach var="articleList" items="${articleList}" varStatus="status">
<div class="card border-primary bg-light mt-3">
			<div class="card-header bg-dark text-white">
				<div class="row">
					<div class="col-8 text-left"><a href="list-detail.do?bdSeq=${articleList.bdSeq}&curPage=${articleList.curPage}">
					<c:out value="${articleList.bdTitle}"/></a>&nbsp;<small>by ${articleList.writerName}</small></div>
					<div class="col-4 text-rigth">
						번호<span style="color:red;"><small>${(totalCnt-status.index)-((curPage-1)*5)}</small>&nbsp;</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<a href="list-detail.do?bdSeq=${articleList.bdSeq}&curPage=${articleList.curPage}">
					<c:out value="${articleList.bdTitle}"/></a>
				</h5>
				<p class="card-text"><c:out value="${articleList.bdContent}"/></p>
				<div class="row">
					<div class="col-9 text-left">
						조회수<span style="color:red;">${articleList.readCnt}</span>&nbsp;
						댓글수<span style="color:red;">${articleList.replyCnt}</span>&nbsp;
						추천수<span style="color:red;">${articleList.hitCnt}</span>
						
					</div>
					<div class="col-3 text-right">
						
					</div>
				</div>
			</div>
</div>
		
</c:forEach>
<hr>
  <%-- 페이징 영역 시작 --%>
 
	
	${result.paging}
	

<%-- 페이징 영역 종료 --%>
</form>
</section>
<footer class="bg-dark mt-5 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 이정찬 All Rights Reserved. </footer>

	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="../../../web/js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="../../../web/js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="../../../web/js/bootstrap.min.js"></script>
</body>
</html>