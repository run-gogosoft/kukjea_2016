<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="popup-zone" class="hidden-md hidden-sm hidden-xs">
	<div>
		<div class="pop-quick-menu">
			<ul>
				<li><a href="/shop/cart"><i class="fa fa-shopping-cart"></i><strong>Cart</strong></a></li>
				<li>
					<div>
						<span class="history-text">History</span>
						<span id="cartLength" class="cart-length"></span>
					</div>
				</li>
			</ul>
		</div>
		<div class="pop-cart">
			<script id="popCartTemplate" type="text/html">
				<div class="va-slice va-slice-<%="${count}"%>">
					<h3 class="va-title"><a href="/shop/detail/<%="${seq}"%>" style="display:inline-block;margin-left:-5px;border: 1px solid #eee;"><img src="<%="${img}"%>" style="width:80px;height:80px;" alt="" /></a></h3>
				</div>
			</script>
			<ul id="cartTarget">
				<li>
					<div id="va-accordion" class="va-container">
						<div class="va-nav">
							<span class="va-nav-prev">prev</span>
							<span class="va-nav-next">next</span>
						</div>
						<div id="vaWrapper" class="va-wrapper">
						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="pop-cscenter">
			<ul>
				<li class="title" style="margin-top:5px;">
					<a href="#" onclick="window.open('http://www.facebook.com/hknuri')"><img src="/front-assets/images/main/facebook.png" alt="facebook"/></a>&nbsp;
					<a href="#" onclick="window.open('http://blog.naver.com/hknurimall')"><img src="/front-assets/images/main/naver.png" alt="naver" /></a>
				</li>
				<li class="title" style="margin-top:12px;">고객센터</li>
				<li class="tel" style="margin-top:2px;"><span>02)</span> 2222-3896</li>
				<!-- <li class="account" style="margin-top:10px;">E-mail</li>
				<li class="account">hknuri@</li>
				<li class="account">happyict.co.kr</li> -->
				<li class="account" style="margin-top:12px;">계좌안내</li>
				<li class="account">신한은행</li>
				<li class="account-num">100-031</li>
				<li class="account-num">304688</li>
				<li class="account">재단법인</li>
				<li class="account">행복한웹앤미디어</li>
				<li class="account">김병두</li>
			</ul>
		</div>
		<a href="#" onclick="EBLB.goTop(this);return false;" class="pop-bottom-wrap">
			<div class="pop-bottom">
				<img src="/front-assets/images/common/top.png" alt=""/>
			</div>
		</a>
	</div>
</div>