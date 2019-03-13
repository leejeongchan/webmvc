<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set value="${result.userIntro}" var="userIntro" />
<!DOCTYPE html>
<html>
<head>
<title>회원제 게시판</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	font-family: "Lato", sans-serif
}

.mySlides {
	display: none
}
</style>
</head>
<style>
.fa-1x {
	font-size: 0.8em;
}

.fa-2x {
	font-size: 1em;
}

.fa-3x {
	font-size: 1.2em;
}

.fa-4x {
	font-size: 1.4em;
}

.fa-5x {
	font-size: 350px;
}

hr.star-light {
	border-color: #fff;
}
</style>
<body>


	<!-- 네비게이션 바 출력 화면 -->

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="#">소통의 공간</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">

				<li class="nav-item active"><a class="nav-link" href="#">메인</a>
				</li>

				<li class="nav-item active"><a class="nav-link"
					href="/article/list.do">게시글</a></li>

				<li><a class="nav-link" id="intro" data-toggle="modal"
					href="#reportModal">소개서 작성/수정</a></li>

				<li><a class="nav-link" href="/common/introlist.do">소개서 보기</a>
				</li>

				<li><a class="nav-link" href="/common/chatview.do">익명 채팅방</a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdown"
					data-toggle="dropdown"> 회원 관리 </a>

					<div class="dropdown-menu" aria-labelledby="dropdown">
						<c:if test="${empty authUser}">
							<a class="dropdown-item" href="login.do">로그인</a>
							<a class="dropdown-item" href="join.do">회원가입</a>
						</c:if>

						<a class="dropdown-item" href="/common/logout.do">로그아웃</a> <a
							class="dropdown-item" href="/common/changePwd.do">비밀번호 변경</a> <a
							class="dropdown-item" href="/common/infolist.do">회원정보 조회</a>
					</div></li>

			</ul>


		</div>
	</nav>

	<!-- 소개서 다이얼로그 창 -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">자기소개서</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-labe="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- action에 소개서 처리하는 컨트롤러로 이동하게 함. 컨트롤러에서 해당 소개서 저장하는 update구문 메소드 실행하여 저장하고 메인으로 이동 소개서 보기는 소개서 list 컨트롤러 따로 만들 예정-->
					<form action="/common/intro.do" method="post">
						<!-- 반반씩 들어가기 하기 위함 -->


						<div class="form-group">
							<label>소개서 내용</label>
							<!-- DB에서 Meber테이블에 INTRO_CONTENT 컬럼 추가하기 -->
							<textarea name="userIntro" class="form-control" maxlength="2048"
								style="height: 180px;">${userIntro }</textarea>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-success">등록하기</button>
						</div>


					</form>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${sessionScope.authUser ne null}">
		<!-- Page content -->
		
		<div class="w3-content" style="max-width: 2000px; margin-top: 0px">

			<!-- Automatic Slideshow Images -->
			<div class="mySlides w3-display-container w3-center">
				<img src="../../web/img/la.jpg" style="width: 100%">
				<div
					class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
					<h3>Los Angeles</h3>
					<p>
						<b>We had the best time playing at Venice Beach!</b>
					</p>
				</div>
			</div>
			<div class="mySlides w3-display-container w3-center">
				<img src="../../web/img/ny.jpg" style="width: 100%">
				<div
					class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
					<h3>New York</h3>
					<p>
						<b>The atmosphere in New York is lorem ipsum.</b>
					</p>
				</div>
			</div>
			<div class="mySlides w3-display-container w3-center">
				<img src="../../web/img/chicago.jpg" style="width: 100%">
				<div
					class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
					<h3>Chicago</h3>
					<p>
						<b>Thank you, Chicago - A night we won't forget.</b>
					</p>
				</div>
			</div>

			<!-- The Band Section -->
			<div class="w3-container w3-content w3-center w3-padding-64"
				style="max-width: 800px" id="band">
				<h2 class="w3-wide"><a href="/common/infolist.do">${authUser.name}님,안녕하세요.</a></h2>
				<p class="w3-opacity">
					<i>Korea Polytechnic University</i>
				</p>
				<p class="w3-justify">이 곳은 소통의 공간입니다. 자유로운 글을 써서 서로 간의 소통을 나누어보세요.
				또한 익명 채팅방을 이용하여 서로간의 비밀스러운 또는 그 동안 속상했던 일들을 적어서 대화를 나누어보세요.
				자기를 소개하는 글들을 등록할 수 있습니다. 아래는 이 사이트를 만든 사람들입니다.</p>
				<div class="w3-row w3-padding-32">
					<div class="w3-third">
						<p>이정찬</p>
						<img src="../../web/img/me.jpg"
							class="w3-round w3-margin-bottom" alt="Random Name"
							style="width: 60%">
					</div>
					<div class="w3-third">
						<p>Name</p>
						<img src="../../web/img/bandmember.jpg"
							class="w3-round w3-margin-bottom" alt="Random Name"
							style="width: 60%">
					</div>
					<div class="w3-third">
						<p>Name</p>
						<img src="../../web/img/bandmember.jpg" class="w3-round"
							alt="Random Name" style="width: 60%">
					</div>
				</div>
			</div>

			<!-- The Tour Section -->
			<div class="w3-black" id="tour">
				<div class="w3-container w3-content w3-padding-64"
					style="max-width: 800px">
					<h2 class="w3-wide w3-center">TOUR DATES</h2>
					<p class="w3-opacity w3-center">
						<i>Remember to book your tickets!</i>
					</p>
					<br>

					<ul class="w3-ul w3-border w3-white w3-text-grey">
						<li class="w3-padding">September <span
							class="w3-tag w3-red w3-margin-left">Sold out</span></li>
						<li class="w3-padding">October <span
							class="w3-tag w3-red w3-margin-left">Sold out</span></li>
						<li class="w3-padding">November <span
							class="w3-badge w3-right w3-margin-right">3</span></li>
					</ul>

					<div class="w3-row-padding w3-padding-32" style="margin: 0 -16px">
						<div class="w3-third w3-margin-bottom">
							<img src="/w3images/newyork.jpg" alt="New York"
								style="width: 100%" class="w3-hover-opacity">
							<div class="w3-container w3-white">
								<p>
									<b>New York</b>
								</p>
								<p class="w3-opacity">Fri 27 Nov 2016</p>
								<p>Praesent tincidunt sed tellus ut rutrum sed vitae justo.</p>
								<button class="w3-button w3-black w3-margin-bottom"
									onclick="document.getElementById('ticketModal').style.display='block'">Buy
									Tickets</button>
							</div>
						</div>
						<div class="w3-third w3-margin-bottom">
							<img src="/w3images/paris.jpg" alt="Paris" style="width: 100%"
								class="w3-hover-opacity">
							<div class="w3-container w3-white">
								<p>
									<b>Paris</b>
								</p>
								<p class="w3-opacity">Sat 28 Nov 2016</p>
								<p>Praesent tincidunt sed tellus ut rutrum sed vitae justo.</p>
								<button class="w3-button w3-black w3-margin-bottom"
									onclick="document.getElementById('ticketModal').style.display='block'">Buy
									Tickets</button>
							</div>
						</div>
						<div class="w3-third w3-margin-bottom">
							<img src="/w3images/sanfran.jpg" alt="San Francisco"
								style="width: 100%" class="w3-hover-opacity">
							<div class="w3-container w3-white">
								<p>
									<b>San Francisco</b>
								</p>
								<p class="w3-opacity">Sun 29 Nov 2016</p>
								<p>Praesent tincidunt sed tellus ut rutrum sed vitae justo.</p>
								<button class="w3-button w3-black w3-margin-bottom"
									onclick="document.getElementById('ticketModal').style.display='block'">Buy
									Tickets</button>
							</div>
						</div>
					</div>
				</div>
			</div>



			<!-- The Contact Section -->
			<div class="w3-container w3-content w3-padding-64"
				style="max-width: 800px" id="contact">
				<h2 class="w3-wide w3-center">CONTACT</h2>
				<p class="w3-opacity w3-center">
					<i>Contact Me!!</i>
				</p>
				<div class="w3-row w3-padding-32">
					<div class="w3-col m6 w3-large w3-margin-bottom">
						<i class="fa fa-map-marker" style="width: 30px"></i> 경기도 부천시<br>
						<i class="fa fa-phone" style="width: 30px"></i> Phone: 010-2000-5343<br>
						<i class="fa fa-envelope" style="width: 30px"> </i> Email:
						dlwjdcks5343@naver.com<br>
					</div>
					<div class="w3-col m6">
						<form action="/common/questionemail.do" target="_blank">
							<input type="hidden" name="to" value="wjdcks5343@gmail.com">
							<input type="hidden" name="from" value="wjdcks5343@gmail.com">
							<div class="w3-row-padding" style="margin: 0 -16px 8px -16px">
								<div class="w3-half">
									<input class="w3-input w3-border" type="text"
										placeholder="Name" required name="Name">
								</div>
							</div>
							<input class="w3-input w3-border" type="text"
								placeholder="Message" required name="Message">
							<button class="w3-button w3-black w3-section w3-right"
								type="submit">SEND</button>
							
						</form>
					</div>
				</div>
			</div>

			<!-- End Page Content -->
		</div>
		<img src="../../web/img/map.jpg" class="w3-image w3-greyscale-min" style="width:100%">
		<!--  카드 부분 등록하기 완료시 뜨는 메인면  -->
		<!--  <header class="masthead bg-info text-white text-center">
			<h1 class="h3  text-center">${authUser.name}님,안녕하세요.</h1>
			<a class="btn btn-success" href="/common/infolist.do">회원정보 조회</a>

			<div class="container">
				<i class="fa fa-comments fa-5x"></i>
				<h1 class="text-uppercase mb-0">Start Communication</h1>
				<br>
				<h1 class="text-lowercase mb-0">korea polytechnic university</h1>
				<br>
				<h1 class="text-lowercase mb-0">Computer Engineering</h1>
				<br>
				<hr class="star-light">

				<h2 class="font-weight-light mb-0">
					Communication Space<br>by Lee Jeong Chan
				</h2>

			</div>
		</header>
		<section class="masthead bg-secondary text-white text-center">

			<div class="container">
				<img class="img-fluid p-5 mb-5 d-block mx-auto"
					src="../../../web/img/logo.jpg" alt="">
				<h1 class="text-uppercase mb-0">Start Communication</h1>
				<hr class="star-light">

				<h2 class="font-weight-light mb-0">
					Communication Space<br>By Lee Jeong Chan
				</h2>

			</div>
		</section>
		<section class="bg-primary text-white">

			<div class="container">

				<h2 class="p-5 text-center text-uppercase text-white">About</h2>
				<hr class="star-light">
				<div class="row">
					<div class="col-lg-4 ml-auto">
						<p class="lead">Freelancer is a free bootstrap theme created
							by Start Bootstrap. The download includes the complete source
							files including HTML, CSS, and JavaScript as well as optional
							LESS stylesheets for easy customization.</p>

					</div>
					<div class="col-lg-4 mr-auto">
						<p class="lead">Whether you're a student looking to showcase
							your work, a professional looking to attract clients, or a
							graphic artist looking to share your projects this template is
							the perfect starting point!</p>

					</div>
				</div>
				<h2 class="text-center font-weight-light mb-0">My Email:
					dlwjdcks5343@naver.com</h2>

			</div>
		</section>-->

	</c:if>
	<footer class="bg-dark  p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 이정찬 All Rights Reserved. </footer>

	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="../../../web/js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="../../../web/js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="../../../web/js/bootstrap.min.js"></script>
	<script>
	// Automatic Slideshow - change image every 4 seconds
	var myIndex = 0;
	carousel();

	function carousel() {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  myIndex++;
	  if (myIndex > x.length) {myIndex = 1}    
	  x[myIndex-1].style.display = "block";  
	  setTimeout(carousel, 4000);    
	}
	</script>
</body>
</html>