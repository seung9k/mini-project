<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>

<script src="/resources/jquery/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/bootstrap-theme.min.css">
<script src="/resources/bootstrap/bootstrap.min.js"></script>

<link rel="stylesheet" href="/resources/styles/home_style.css">

<style>
	div.goods div.goodsImg { float:left; width:350px; }
	div.goods div.goodsImg img { width:350px; height:auto; }
	
	div.goods div.goodsInfo { float:right; width:330px; font-size:22px; }
	div.goods div.goodsInfo p { margin:0 0 20px 0; }
	div.goods div.goodsInfo p span { display:inline-block; width:100px; margin-right:15px; } 
	
	div.goods div.goodsInfo p.cartStock input { font-size:22px; width:50px; padding:5px; margin:0; border:1px solid #eee; }
	div.goods div.goodsInfo p.cartStock button { font-size:26px; border:none; background:none; } 
	div.goods div.goodsInfo p.addToCart { text-align:right; }
	div.goods div.goodsInfo p.addToCart button { font-size:22px; padding:5px 10px; border:1px solid #eee; background:#eee;}
	div.goods div.gdsDes { font-size:18px; clear:both; padding-top:30px; }
</style>
<style>
	section.replyForm { padding:30px 0; }
	section.replyForm div.input_area { margin:10px 0; }
	section.replyForm textarea { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:500px;; height:150px; }
	section.replyForm button { font-size:20px; padding:5px 10px; margin:10px 0; background:#fff; border:1px solid #ccc; }
	
	section.replyList { padding:30px 0; }
	section.replyList ol { padding:0; margin:0; }
	section.replyList ol li { padding:10px 0; border-bottom:2px solid #eee; }
	section.replyList div.userInfo { }
	section.replyList div.userInfo .userName { font-size:24px; font-weight:bold; }
	section.replyList div.userInfo .date { color:#999; display:inline-block; margin-left:10px; }
	section.replyList div.replyContent { padding:10px; margin:20px 0; }
</style>

<title>s9shop</title>
</head>
<body>
	<div id="root">
		<header id="header">
			<div id="header_box">
				<%@ include file="../include/header.jsp"%>
			</div>
		</header>

		<nav id="nav">
			<div id="nav_box">
				<%@ include file="../include/nav.jsp"%>
			</div>
		</nav>

		<section id="container">
			<div id="container_box">
				<section id="content">
					<form role="form" method="post">
						<input type="hidden" name="gdsNum" value="${view.gdsNum}" />
					</form>

					<div class="goods">
						<div class="goodsImg">
							<img src="${view.gdsImg}">
						</div>

						<div class="goodsInfo">
							<p class="gdsName">
								<span>상품명 ${view.gdsName}</span>
							</p>

							<p class="cateName">
								<span>카테고리 ${view.cateName}</span>
							</p>

							<p class="gdsPrice">
								<span>가격</span> <fmt:formatNumber pattern="###,###,###"
										value="${view.gdsPrice}" /> 원 
							</p>

							<p class="gdsStock">
								<span>재고</span> <fmt:formatNumber pattern="###,###,###"
										value="${view.gdsStock}" /> EA 
							</p>

							<p class="cartStock">
								<span>구입 수량</span>
									<button type="button" class="plus">+</button>
									<input type="number" class="numBox" min="1" max="${view.gdsStock}"
									value="1" readonly="readonly" />
									<button type="button" class="minus">-</button>
									<script>
										$(".plus").click(function(){
											var num = $(".numBox").val();
											var plusNum = Number(num) + 1;
										 
											if(plusNum >= ${view.gdsStock}) {
												$(".numBox").val(num);
											} else {
												$(".numBox").val(plusNum);            
												}
											});
										
										$(".minus").click(function(){
											var num = $(".numBox").val();
											var minusNum = Number(num) - 1;
										 
											if(minusNum <= 0) {
												$(".numBox").val(num);
											} else {
												$(".numBox").val(minusNum);            
											}
										});
									</script>
							</p>

							<p class="addToCart">
								<button type="button">카트에 담기</button>
							</p>
						</div>

						<div class="gdsDes">${view.gdsDes}</div>
					</div>
					
					<!-- 댓글 폼 -->
					<div id="reply">

						<c:if test="${member == null }">
							<p>
								소감을 남기시려면 <a href="/member/signin">로그인</a>해주세요
							</p>
						</c:if>

						<c:if test="${member != null}">
							<section class="replyForm">
								<form role="form" method="post" autocomplete="off">
									
									<!-- 상품번호를 컨트롤러에 전달 -->
									<input type="hidden" name="gdsNum" value="${view.gdsNum}">
									
									<div class="input_area">
										<textarea name="repCon" id="repCon"></textarea>
									</div>

									<div class="input_area">
										<button type="submit" id="reply_btn">소감 남기기</button>
									</div>

								</form>
							</section>
						</c:if>

						<section class="replyList">
							<ol>
								<c:forEach items="${reply}" var="reply">

									<li>
										<div class="userInfo">
											<span class="userName">${reply.userName}</span>
											 <span class="date"><fmt:formatDate value="${reply.repDate}"
														pattern="yyyy-MM-dd" /></span>
										</div>
										<div class="replyContent">${reply.repCon}</div>
									</li>
								</c:forEach>
							</ol>
						</section>

					</div>
				</section>
				
				<aside id="aside">
				   <%@ include file="../include/aside.jsp"%>
				</aside>
			</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="../include/footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>