<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 주문 리스트 -->
<script id="tmpl-order-list" type="text/html">
<tr>
	<td class="text-center">
		<a href="/admin/order/view/<%="${orderSeq}"%>?seq=<%="${seq}"%>"><%="${seq}"%></a>
	</td>
	<td class="text-center"><%="${orderSeq}"%></td>
	<td class="text-center">
		<strong><%="${statusText}"%></strong>
		<p>
			{{if payMethod == ""}}
				제휴사 결제
			{{else}}
				<strong style="color:#6495ed"><%="${payMethodName}"%></strong>
			{{/if}}
		</p>
	</td>
	<td class="text-center">
		<%="${memberName}"%>
		<p><%="${receiverName}"%></p>
	</td>
	<td>
		상품번호 : <a href="/admin/item/view/<%="${itemSeq}"%>" target="_blank"><strong><%="${itemSeq}"%></strong></a><br/>
		<p><%="${itemName}"%></p>
	</td>
	<td><%="${optionValue}"%></td>
	<td class="text-right"><%="${sellPrice}"%></td>
	<td class="text-right">
		<%="${orderCnt}"%> 개
	</td>
	<td>
		<%="${deliName}"%>
		<p><%="${deliNo}"%></p>
	</td>
	<td class="text-center">
		<a href="#" onclick="return false;" data-index="<%="${index}"%>" style="cursor:pointer"><%="${sellerName}"%></a>
		<div id="ToolTipInfo<%="${index}"%>" style="display: none">
			<p>담당자명 : <%="${salesName}"%></p>
			<p>담당자 전화번호 : <%="${salesTel}"%></p>
			<p>담당자 휴대폰번호 : <%="${salesCell}"%></p>
			<p>담당자 이메일 : <%="${salesEmail}"%></p>
		</div>
	</td>
	<td class="text-center"><%="${regDate}"%></td>
</tr>
</script>

<!-- 포인트 리스트 -->
<script id="tmpl-point-list" type="text/html">
<tr>
	<td class="text-center"><%="${seq}"%></td>
	<td class="text-center"><%="${regDate}"%></td>
	<td class="text-center"><%="${point}"%> P</td>
	<td class="text-center"><%="${name}"%></td>
	<%-- <td class="text-center"><%="${mallName}"%></td> --%>
	<td class="text-center"><%="${statusName}"%></td>
	<td class="text-center">
		<a href="/admin/order/list?search=order_seq&findword=<%="${orderSeq}"%>"><%="${orderSeq}"%></a>
	</td>
	<%--<td class="text-center">--%>
		<%--<a href="/admin/order/view/<%="${orderSeq}"%>?seq=<%="${orderDetailSeq}"%>"><%="${orderDetailSeq}"%></a>--%>
	<%--</td>--%>
	<td class="text-center"><%="${note}"%></td>
</tr>
</script>

<!-- 1:1문의 리스트 -->
<script id="tmpl-one-list" type="text/html">
<tr>
	<td class="text-center"><%="${seq}"%></td>
	<td class="text-center">
	{{if categoryCode == 200}}
		주문배송
	{{else categoryCode == 201}}
		주문취소
	{{else categoryCode == 202}}
		주문반품
	{{else categoryCode == 203}}
		주문교환
	{{else}}
		기타
	{{/if}}
	</td>
	<%-- <td class="text-center">
	{{if integrationSeq == null}}
		일반
	{{else}}
		<a href="/admin/order/view/<%="${orderSeq}"%>?seq=<%="${integrationSeq}"%>"><%="${integrationSeq}"%></a>
	{{/if}}
	</td> --%>
	<!--<td class="text-center"><%="${mallName}"%></td>-->
	<td><a href="/admin/board/view/one/<%="${seq}"%>"><%="${title}"%></a></td>
	<td class="text-center">
	{{if answerFlag == 2}}
		미답변
	{{else answerFlag == 1}}
		답변완료
	{{/if}}
	</td>
	<td class="text-center"><%="${name}"%></td>
	<td class="text-center"><%="${regDate}"%></td>
</tr>
</script>

<!-- 구매평 -->
<script id="tmpl-review-list" type="text/html">
<tr>
	<td class="text-center"><%="${seq}"%></td>
	<td class="text-center"><%="${itemSeq}"%></td>
	<td class="text-center">
		<img src="<%="${img1}"%>" style="width:70px;" alt=""/>
	</td>
	<td class="text-center"><%="${itemName}"%></td>
	<!-- <td class="text-center"><%="${mallName}"%></td> -->
	<td><%="${review}"%></td>
	<td class="text-center"><%="${goodGrade}"%></td>
	<td class="text-center"><%="${name}"%></td>
	<td class="text-center"><%="${regDate}"%></td>
</tr>
</script>

<!-- 배송지 정보 -->
<script id="tmpl-delivery-list" type="text/html">
<tr>
	<td class="text-center"><%="${seq}"%></td>
	<td><%="${title}"%></td>
	<td class="text-center"><%="${name}"%></td>
	<td>
		<%="${tel}"%><p><%="${cell}"%></p>
	</td>
	<td class="text-center"><%="${postcode}"%> <%="${addr1}"%> <%="${addr2}"%></td>
	<td class="text-center"><%="${regDate}"%></td>
</tr>
</script>

<%--<!-- CS 처리내역 리스트 -->--%>
<%--<script id="tmpl-delivery-list" type="text/html">--%>
<%--<tr>--%>
	<%--<td class="text-center">--%>
		<%--<a href="/admin/order/view/<%="${orderSeq}"%>?seq=<%="${seq}"%>"><%="${seq}"%></a>--%>
	<%--</td>--%>
	<%--<td class="text-center"><%="${orderSeq}"%></td>--%>
	<%--&lt;%&ndash; <td class="text-center"><%="${mallName}"%></td> &ndash;%&gt;--%>
	<%--<td class="text-center"><strong><%="${statusText}"%></strong></td>--%>
	<%--<td class="text-left"><%="${contents}"%></td>--%>
	<%--<td class="text-center"><%="${loginName}"%></td>--%>
	<%--<td class="text-center"><%="${sellerName}"%></td>--%>
	<%--<td class="text-center"><%="${regDate}"%></td>--%>
<%--</tr>--%>
<%--</script>--%>