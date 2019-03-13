<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/bootstrap.min.css?after">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="../../../web/css/custom.css?after">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>익명 채팅방</title>
<script type="text/javascript">
	var lastID = 0;
	function submitFunction() {
		console.log("1");

		var chatName = $('#chatName').val();
		var chatContent = $('#chatContent').val();
		console.log(chatName);
		console.log(chatContent);
		$.ajax({
			type : "POST",
			url : "/ChatSubmitServlet",
			data : {
				chatName : encodeURIComponent(chatName),
				chatContent : encodeURIComponent(chatContent)
			},
			success : function(result) {
				if (result == 1) {
					autoClosingAlert('#successMessage', 2000);
				} else if (result == 0) {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}

			}

		});
		$('#chatContent').val('');
	}
	function autoClosingAlert(selector, delay) {

		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {
			alert.hide()
		}, delay);
	}

	function chatListFunction(type) {

		$.ajax({
			type : "POST",
			url : "/ChatListServlet",
			data : {
				listType : type,
			},
			success : function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value,
							result[i][2].value);

				}
				lastID = Number(parsed.last);

			}

		});

	}
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList')
				.append(
						'<div class="row">'
								+ '<div class="col-lg-12">'
								+ '<div class="media">'
								+ '<a class="pull-left" href="#">'
								+ '<img src="http://bootdey.com/img/Content/avatar/avatar6.png" alt="" class="ui-w-100 rounded-circle" width="52" height="52">'
								+ '</a>' + '<div class="media-bdoy">'
								+ '<h4 class="media-heading">' + chatName
								+ '<span class="small pull-right">' + chatTime
								+ '</span>' + '</h4>' + '<p>' + chatContent
								+ '</p>' + '</div>' + '</div>' + '</div>'
								+ '</div>' + '<hr>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	function getInfiniteChat(){
		setInterval(function(){
			chatListFunction(lastID);
		},1000);
	}
</script>
</head>
<body>
	<div class="container">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-md-8">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green"></i>실시간 채팅방
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse in">
							<div id="chatList" class="portlet-body chat-widget"
								style="overflow-y: auto; width: auto; height: 600px;"></div>
							<!-- 입력 하는 부분 -->
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="text" id="chatName"
											class="form-control ml-3" placeholder="이름" maxlength="8">

									</div>

								</div>
								<div class="row" style="height: 90px;">
									<div class="form-group col-xs-10">
										<textarea style="height: 80px; width: 600px" id="chatContent"
											class="form-control ml-3" placeholder="메시지를 입력하세요."
											maxlength="1000"></textarea>
									</div>
									<div class="form-gorup col-xs-2">
										<button type="button" class="btn btn-success pull-rigth ml-2"
											onclick="submitFunction();">전송</button>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="alert alert-success" id="successMessage"
			style="display: none;">
			<strong>메시지 전송에 성공했습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage"
			style="display: none;">
			<strong>이름과 내용을 입력해주세요.</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage"
			style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>



	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="../../../web/js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="../../../web/js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="../../../web/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			console.log("documentready");
			chatListFunction('ten');
			getInfiniteChat();
		});
	</script>
</body>
</html>