<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%--
	원래 이 페이지는 결제 완료 페이지가 되어야 하나...
	퍼블리싱 준비가 되어 있지 않아서 경고창 후 주문리스트로 넘어간다
--%>
<script src="/js/lib/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//이니시스 결제 프로세스 창 닫기
		try {
			var openwin = window.open("/pg/inicis/childwin.html", "childwin", "width=299,height=149");
			openwin.close();
		} catch(e) {}

		alert('이용해주셔서 감사합니다\n고객님의 주문/결제가 정상적으로 완료되었습니다\n\n결재금액의 ${grade_point}%를 포인트로 적립해드립니다.\n 무통장입금 결제의 경우 입금 확인 후 포인트가 적립됩니다');
		location.replace('/shop/mypage/order/list');
	});
	
	var showReceipt = function(tid) {
		var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noMethod=1&noTid="+tid;
		window.open(receiptUrl,"receipt","width=430,height=700");
	};
	
</script>
</body>
</html>