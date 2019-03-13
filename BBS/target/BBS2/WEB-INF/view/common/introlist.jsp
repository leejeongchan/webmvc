<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set value="${result.userIntro}" var="userIntro" />
<c:set value="${result.name}" var="name"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자기소개서</title>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
</head>
<body>
<div class="ui-bg-cover ui-bg-overlay-container text-white" style="background-color: #87CEFA;">
    <div class="ui-bg-overlay bg-dark opacity-50"></div>
    <div class="container">
      <div class="text-center py-5">
        <img src="http://bootdey.com/img/Content/avatar/avatar6.png" alt="" class="ui-w-100 rounded-circle">

        <div class="col-md-8 col-lg-6 col-xl-5 p-0 mx-auto">
          <h4 class="font-weight-bold my-4">${name}</h4>

          <div class="opacity-75 mb-4">
           <c:if test="${userIntro eq null}">자기소개서를 등록하지 않았습니다.</c:if>
			${userIntro}
          </div>
        </div>

       
      </div>
    </div>
    <div class="text-center">
	<a class="mt-3 btn btn-primary" href="/common/login.do">메인으로 이동</a>
    </div>
  </div>

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