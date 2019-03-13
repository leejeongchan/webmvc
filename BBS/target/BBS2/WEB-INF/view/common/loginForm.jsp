<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.authUser ne null}">
	<c:redirect url="/common/main.do" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<META http-equiv="Expires" content="-1">
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Cache-Control" content="No-Cache">
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

</head>


<body>


	<section class="container mt-3" style="max-width: 560px;">
		<div class="text-center">
			<img class="mt-3 center-block" src="../../../web/img/logo.jpg" alt=""
				width="72" height="72">
		</div>

		<h1 class="h3 mt-2 text-center">Please Log in</h1>
		<form method="post" action="/common/login.do">
			<c:if test="${errors.idOrPwNotMatch}">
			아이디와 암호가 일치하지 않습니다.
			</c:if>
			<div class="form-group">
				<label>아이디</label> <input type="text" name="memberId"
					value="${param.memberId}" placeHolder="아이디를 입력해주세요."
					class="form-control">
				<c:if test="${errors.id}">ID를 입력하세요.</c:if>
			</div>


			<div class="form-group">
				<label>비밀번호</label> <input type="password"
					placeHolder="비밀번호를 입력해주세요." name="password" class="form-control">
				<c:if test="${errors.password}">암호를 입력하세요.</c:if>
			</div>


			<button type="submit" class="btn btn-primary">
				로그인<i class="fa fa-fw fa-unlock-alt"></i>
			</button>
			<a class="btn btn-primary" href="/common/join.do">회원가입</a> <input
				type="checkbox" id="idSaveCheck">아이디 기억하기
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
	<script type="text/javascript">
		$(document).ready(function() {
			//저장된 쿠키값 가져와서 ID칸에 넣어주기. 없으면 공백으로 들어감
			var userInputId = getCookie("userInputId");
			$("input[name='memberId']").val(userInputId);
			//그전 ID 저장하여 처음 페이지 로딩할 때 입력칸 저장 ID가 표시된 경우
			if ($("input[name='memberId']").val() != "") {
				$("#idSaveCheck").attr("checked", true);//체크 상태로 두기
			}
			//체크박스에 변화가 있으면
			$("#idSaveCheck").change(function() {
				if ($("#idSaveCheck").is(":checked")) {
					var userInputId = $("input[name='memberId']").val();
					setCookie("userInputId", userInputId, 7); //7일 쿠키 저장

				} else {
					deleteCookie("userInputId");

				}
			});

			//ID 저장하기를 체크한 상태에서 ID를 입력한 경우 이럴 때도 쿠키 저장하기
			$("input[name='memberId']").keyup(function() {
				if ($("#idSaveCheck").is(":checked")) {
					var userInputId = $("input[name='memberId']").val();
					setCookie("userInputId", userInputId, 7);
				}
			});
		});

		function setCookie(cookieName, value, exdays) {
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);
			var cookieValue = escape(value)
					+ ((exdays == null) ? "" : "; expires="
							+ exdate.toGMTString());
			document.cookie = cookieName + "=" + cookieValue;
		}

		function deleteCookie(cookieName) {
			var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);
			document.cookie = cookieName + "= " + "; expires="
					+ expireDate.toGMTString();
		}

		function getCookie(cookieName) {
			cookieName = cookieName + '=';
			var cookieData = document.cookie;
			var start = cookieData.indexOf(cookieName);
			var cookieValue = '';
			if (start != -1) {
				start += cookieName.length;
				var end = cookieData.indexOf(';', start);
				if (end == -1)
					end = cookieData.length;
				cookieValue = cookieData.substring(start, end);
			}
			return unescape(cookieValue);
		}
	</script>
</body>
</html>