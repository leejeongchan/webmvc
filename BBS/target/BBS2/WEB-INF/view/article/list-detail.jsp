<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- articleResult:게시글 상세정보들 -->
<c:set value="${result.articleResult}" var="articleResult" />
<!-- contentResult:게시글 내용 정보   -->
<c:set value="${result.contentResult}" var="contentResult" />
<!-- articleList: 댓글 리스트 정보      -->
<c:set value="${result.articleList}" var="articleList" />

<c:set value="${hBox}" var="hBox" />

<!DOCTYPE html>
<html>
<head>
<title>게시글 읽기</title>
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
<style>
</style>
<body>

	<!-- Page Content -->
	<div class="container pt-0 pl-0 pr-0 align-center"
		style="width: 1000px;">

		<div class="row">

			<!-- Post Content Column -->
			<div class="container">

				<!-- Title -->
				<h1 class="mt-4">
					
					<c:out value='${articleResult.bdTitle}' />
				</h1>

				<!-- Author -->
				<p class="lead">
					by <a href="/common/infolist.do">${articleResult.writerName}</a>
				<div class="text-right">
					<c:set var="pageNo"
						value="${empty hBox.curPage ? '1' : hBox.curPage}" />
					<a class="btn btn-primary" href="list.do?pageNo=${pageNo}">목록</a>
					<c:if test="${hBox.memberId == articleResult.writerId}">
						<a class="btn btn-primary"
							href="modify.do?bdSeq=${articleResult.bdSeq}">게시글수정</a>
						<a class="btn btn-primary"
							href="delete.do?bdSeq=${articleResult.bdSeq}">게시글삭제</a>
					</c:if>
					<a class="btn btn-success" href="recommand.do?bdSeq=${articleResult.bdSeq}">추천</a>
				</div>
				</p>

				<hr>

				<!-- Date/Time -->
				<p>${articleResult.regDate}</p>

				<hr>



				<!-- Post Content -->
				<article class="content-text">
					<br>
					<c:out value="${contentResult.bdContent}" escapeXml="true" />

				</article>


			</div>
		</div>
	</div>

	<!--  <section class="content-container mt-3 clearfix">
		<div class="container">

			<div id="content-body" class="panel-body content-body pull-left">

				<div class="content-tags">
					<span class="list-group-item-text article-id">#${articleResult.bdSeq}</span>

				</div>
				<hr style="border: solid 5px #00BFFF; width: auto;" />
				<h2 class="panel-title">
					제목:
					<c:out value='${articleResult.bdTitle}' />
				</h2>
				<hr style="border: solid 5px #00BFFF; width: auto;" />
				<div class="avatar-info pt-0">
					<a class="avatar-photo"> <img src="../../../web/img/logo.jpg"
						width="40" height="40">
					</a>
					<p style="color: #0000FF" class="nickname">작성자:
						${articleResult.writerName}</p>

					<span style="font-size: 8px; color: #A4A4A4" class="timego">작성일:
						${articleResult.modDate}</span>

				</div>
				<hr style="border: solid 2px #00BFF;" />
				<article class="content-text">
					내용:<br>
					<table class="table table-striped table-bordered table-hover"
						border="1">
						<tr>
							<td style=""><c:out value="${contentResult.bdContent}"
									escapeXml="true" /></td>
						</tr>
					</table>
				</article>
				<c:set var="pageNo"
					value="${empty hBox.curPage ? '1' : hBox.curPage}" />
				<a class="btn btn-primary" href="list.do?pageNo=${pageNo}">목록</a>
				<c:if test="${hBox.memberId == articleResult.writerId}">
					<a class="btn btn-primary"
						href="modify.do?bdSeq=${articleResult.bdSeq}">게시글수정</a>
					<a class="btn btn-primary"
						href="delete.do?bdSeq=${articleResult.bdSeq}">게시글삭제</a>
				</c:if>
			</div>
		</div>
	</section>-->

	<!-- Comments Form -->


	<div class="card border-primary container mt-2 pt-0 pl-0 pr-0 "
		style="width: 1000px;">
		
		<h5 class="card-header bg-dark text-white">Leave a Comment:</h5>
		<div class="card-body">
			<form>
			<input type="hidden" id="bdSeq" name="bdSeq"
				value="<c:out value="${articleResult.bdSeq}"/>">
				<div class="form-group">
					<textarea class="form-control" id="replMemo1" name="replMemo"
						placeholder="댓글을 달아주세요" rows="3"></textarea>
				</div>
				<button type="submit" class="btn btn-primary" onclick="fn_formSubmit()">Submit</button>
			</form>
		</div>
	</div>
			<!--  게시판 댓글리스트 시작 -->
			<div class="container  mt-3 pt-0 pl-0 pr-0 "
		style="width: 1000px;" id="articleList">
				<c:forEach var="articleList" items="${articleList}"
					varStatus="status">

					<div
						class="panel panel-default replyParent<c:out value="${articleList.replPrt}"/>"
						id="replItem<c:out value="${articleList.replSeq}"/>"
						style="margin-left: <c:out value="${20*articleList.replDept}"/>px;">
						<div class="panel-body">
							<div class="card border-primary mt-2 photoTitle">
								<div class="card-header bg-dark text-white">
									<c:out value="${articleList.replWriter}" />
									<c:out value="${articleList.replDate}" />
									<c:if
										test='${articleList.replMemberSeq==sessionScope.memberSeq}'>
										<a
											href="javascript:fn_replyDelete('<c:out value="${articleList.replSeq}"/>')"
											title="삭제"><span class="text-muted">삭제</span></a>
										<a
											href="javascript:fn_replyUpdate('<c:out value="${articleList.replSeq}"/>')"
											title="수정"><span class="text-muted">수정</span></a>
									</c:if>
									<!--  숨겨진 dialog 나오게해준다. -->
									<a
										href="javascript:fn_replyReply('<c:out value="${articleList.replSeq}"/>')"
										title="답글"><span class="text-muted">답글</span></a>
								</div>
								<!--  깊이 1 댓글 출력 -->
								<div id="repl<c:out value="${articleList.replSeq}"/>">
								
									<div class="card-body content mt-3" style="white-space: normal;">
										<c:out value="${articleList.replMemo}" escapeXml="true" />
									</div>
								</div>

							</div>
						</div>
					</div>

				</c:forEach>
			</div>
			<!--  게시판 댓글 쓰기 영역  보이지 않으며 이후에 댓글을 수정 할 때 동적으로 쓰여진다.-->
			<div id="replDiv" style="width: 99%; display: none">
				<input type="hidden" id="replSeq2" name="replSeq">
				<div class="col-lg-6">
					<textarea class="form-control" id="replMemo2" name="replMemo2"
						rows="3" maxlength="500" style="height: 300px"></textarea>
				</div>
				<div class="col-lg-2 pull-left">
					<button class="btn btn-outline btn-primary"
						onclick="fn_replyUpdateSave()">저장</button>
					<button class="btn btn-outline btn-primary"
						onclick="fn_replyUpdateCancel()">취소</button>
				</div>
			</div>
			<!--  숨겨져 있는 게시판 댓글의 댓글 쓰기 영역 -->
			<div id="replDialog" style="width: 99%; display: none">
				<input type="hidden" id="replSeq3" name="replSeq"> <input
					type="hidden" id="replPrt3" name="replPrt">
				<div class="col-lg-6">
					<textarea class="form-control" id="replMemo3" name="replMemo3"
						rows="3" maxlength="500" style="width: 300px; height: 300px"></textarea>
				</div>
				<div class="col-lg-2 pull-left">
					<button class="btn btn-outline btn-primary"
						onclick="fn_replyReplySave()">저장</button>
					<button class="btn btn-outline btn-primary"
						onclick="fn_replyReplyCancel()">취소</button>
				</div>
			</div>
		
	

	<footer class="bg-dark mt-5 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 이정찬 All Rights Reserved. </footer>

	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="../../../web/js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="../../../web/js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="../../../web/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	var updateReplSeq = updateReplMemo = null;

	function fn_formSubmit() {

		$.ajax({
			url : "${HOME}/article/repl-save.do",
			dataType : "html",
			type : "post",
			data : {
				bdSeq : $("#bdSeq").val(),
				replMemo : $("#replMemo1").val()
			},
			success : function(result) {
				if (result !== "") {
					$("#replMemo1").val("");
					$("#articleList").append(result);

				} else {
					alert('error');
				}
			}
		})
	}
	function fn_replyUpdate(replSeq) {
		hideDiv("#replDialog");

		if (updateReplSeq) {
			$("#replDiv").appendTo(document.body);
			$("#repl" + updateReplSeq).find('.content').text(updateReplMemo);
		}
		updateReplSeq = replSeq;

		updateReplMemo = $("#repl" + replSeq).find('.content').text();

		$("#replSeq2").val(replSeq);
		$("#replMemo2").val(updateReplMemo);
		$("#repl" + replSeq).find('.content').text("");
		$("#replDiv").appendTo($("#repl" + replSeq));
		$("#replDiv").show();
		$("#replMemo2").focus();
	}
	function fn_replyUpdateSave() {
		if (!chkInputValue("#replMemo2", "댓글 내용을 채워주세요"))
			return;

		$.ajax({
			url : "/article/repl-save.do",
			type : "post",
			data : {
				bdSeq : $("#bdSeq").val(),
				replSeq : updateReplSeq,
				replMemo : $("#replMemo2").val()
			},
			success : function(result) {
				if (result !== "") {
					$("#replDiv").appendTo(document.body);
					$("#replDiv").hide();
					$("#repl" + updateReplSeq).find('.content').text(
							$("#replMemo2").val());

				} else {
					alert("댓글작성중 예기치 못한 에러발생");
				}
				updateReplSeq = updateReplMemo = null;
			}
		})
	}
	function fn_replyUpdateCancel() {
		hideDiv("#replDiv");

		$("#repl" + updateReplSeq).find('.content').text(updateReplMemo);
		updateReplSeq = updateReplMemo = null;
	}

	function fn_replyDelete(replSeq) {
		if (!confirm("정말로 삭제하시겠습니까?")) {
			return;
		}
		$.ajax({
			url : "/article/repl-delete.do",
			type : "post",
			data : {
				"replSeq" : replSeq
			},
			success : function(result) {
				if (result == "OK") {
					$("#replItem" + reno).remove();
					alert("삭제");
				} else if (result == "Fail") {
					alert("실패");
				}
			}
		})
	}
	function fn_replyReply(replSeq) {
		$("#replDialog").show();
		if (updateReplSeq) {
			fn_replyUpdateCancel();
		}
		$("#replPrt3").val(replSeq);
		$("#replMemo3").val("");
		$("#replDialog").appendTo($("#repl" + replSeq));
		$("#replMemo3").focus();
	}
	function fn_replyReplySave() {
		if (!chkInputValue("#replMemo3", "댓글 내용을 채워주세요"))
			return;

		$.ajax({
			url : "${HOME}/article/repl-save.do",
			type : "post",
			data : {
				bdSeq : $("#bdSeq").val(),
				replSeq : $("#replSeq3").val(),
				replPrt : $("#replPrt3").val(),
				replMemo : $("#replMemo3").val()
			},
			dataType : "html",
			success : function(result) {
				if (result !== "") {
					var parent = $("#replPrt3").val();
					var parentNodes = $(".replPrt" + parent);
					if (parentNodes.length === 0) {
						$("#replItem" + parent).after(result);
					} else {
						parentNodes.last().after(result);
					}
					hideDiv("#replDialog");
					$("#replMemo3").val("");
				} else {
					alert("실패");
				}
			}
		})
	}
	function fn_replyReplyCancel() {
		$("#replDialog").hide();
	}
	function hideDiv(id) {
		$(id).hide();
		$(id).appendTo(document.body);
	}
</script>


</html>