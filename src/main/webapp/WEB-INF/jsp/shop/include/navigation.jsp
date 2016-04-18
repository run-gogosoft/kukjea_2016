<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="gnb">
	<div class="layout_inner">
		<div class="total_menu">
			<a href="#" id="btnTotal">전체메뉴보기</a>
			<div class="total_menu_list cols">
				<div data-name="totalmenu"></div>
				<button type="button" id="btnCloseTotal" class="btn_totalmenu_close"><span class="blind">전체메뉴 닫기</span></button>
			</div>
		</div>
		<ul class="mn" data-name="mn1"></ul>
		<ul class="mn special" data-name="mn2"></ul>
	</div>
</div>

<script id="TotalMenuTemplate" type="text/html">
<dl class="mn1 col_lt">
	<dt><%="${categoryName}"%></dt>
	<dd>
		<ul class="col_lt col<%="${seq}"%>">
			{{each lv2List}}
			<li><a href="/shop/lv2/<%="${seq}"%>"><%="${categoryName}"%></a></li>
			{{/each}}
		</ul>
	</dd>
</dl>
</script>
<script id="MenuTemplate" type="text/html">
	<li class="<%="${className}"%>"><a href="<%="${href}"%>"><%="${categoryName}"%></a></li>
</script>