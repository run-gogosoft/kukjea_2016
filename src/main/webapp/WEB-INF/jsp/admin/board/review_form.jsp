<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.score_ul {
			float:left;
			list-style:none;
			margin:0;
			padding:0;
			font-weight:normal;
		}
		.score_li {
			float:left;
			padding-right:10px;
			font-size:12px;
			margin:0;
		}
		.score_li label{
			font-weight:normal;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="main">
	<div class="container">
		<h3 class="pull-left"><c:if test="${title ne null}">${title}</c:if></h3>
		<div class="row">
			<div class="span12">
				<div class="widget widget-form stacked">
					<div class="widget-header">
						<i class="icon-pencil"></i>
						<h3>글 작성</h3>
					</div>
					<div class="widget-content">
						<form id="write" class="form-horizontal" onsubmit="return submitProc(this);" method="post" action="<c:choose><c:when test="${vo eq null}">/admin/board/review/write/proc</c:when><c:otherwise>/admin/board/review/edit/proc/${vo.seq}</c:otherwise></c:choose>" target="zeroframe">
							<input type="hidden" id="item_check_flag" value="N"/>
							<fieldset>
							<c:if test="${ vo ne null }">
								<div class="control-group">
									<label class="control-label">등록일</label>
									<div class="controls" style="margin-top:6px;">
										<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</div>
								</div>
							</c:if>
							<div class="control-group">
								<label class="control-label">회원검색</label>
								<div class="controls" style="margin-top:6px;">
									<c:choose>
									<c:when test="${vo eq null}">
									<input type="text" id="memberSeq" name="memberSeq" class="span1" value="" readonly="readonly" alt="회원 코드" />
									<input type="text" class="span2" id="memberId" name="findword" placeholder="회원 검색" />
									<button type="button" class="btn btn-info" onclick="memberProc(this)">회원검색</button><br/>

									<script id="memberTemplate" type="text/html">
										<tr class="hand" data-seq="<%="${seq}"%>" onclick="memberSelectProc(this)">
											<td class="text-center"><%="${id}"%></td>
											<td class="text-center"><%="${name}"%></td>
											<td class="text-center"><%="${nickname}"%></td>
											<td class="text-center"><%="${statusText}"%></td>
											<td class="text-center"><%="${gradeText}"%></td>
											<td class="text-center"><%="${lastDate}"%></td>
											<td class="text-center"><%="${regDate}"%></td>
										</tr>
									</script>
									<br/>
									<div class="hide">
										<table class="table table-striped table-bordered table-list">
											<thead>
											<tr>
												<th>이메일</th>
												<th>이름</th>
												<th>닉네임</th>
												<th>상태</th>
												<th>등급</th>
												<th>마지막접속일</th>
												<th>등록일자</th>
											</tr>
											</thead>
											<tbody id="member-list">
											<tr><td class="muted text-center" colspan="7">
												검색결과가 이 안에 표시됩니다
											</td></tr>
											</tbody>
										</table>
									</div>
									</c:when>
										<c:otherwise>
											${vo.nickName}
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="itemSeq">상품번호</label>
								<div class="controls">
									<c:choose>
									<c:when test="${vo eq null}">
										<input type="text" style="width:230px;" id="itemSeq" name="itemSeq" value="${ vo.itemSeq }" alt="상품번호" onblur="numberCheck(this);" placeholder="상품번호를 입력해 주세요."  maxlength="100"/>
										<button type="button" id="btn-item-check" class="btn btn-info">중복체크</button><br/>
									</c:when>
										<c:otherwise>
											<div style="float:left;"><img src="${const.UPLOAD_PATH}${fn:replace(vo.img1, 'origin', 's206')}" style="width:70px;" alt=""/></div><div style="float:left;width:430px;padding:12px 0 0 10px;">${vo.itemSeq}<br/>${vo.itemName}</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="review">구매평<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
								<div class="controls">
									<textarea rows="10" id="review" name="review" alt="구매평" class="span8">${ vo.review }</textarea>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">상품평가<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
								<div class="controls">
									<ul class="score_ul">
										<li class="score_li">
											<label style="cursor:pointer;"><input type="radio" name="goodGrade" value="5" alt="상품평가" ${vo ne null && vo.goodGrade eq '5' ? "checked" :  ""}/>매우만족</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="goodGrade" value="4" alt="상품평가" ${vo ne null && vo.goodGrade eq '4' ? "checked" :  ""}/>만족</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="goodGrade" value="3" alt="상품평가" ${vo ne null && vo.goodGrade eq '3' ? "checked" :  ""}/>보통</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="goodGrade" value="2" alt="상품평가" ${vo ne null && vo.goodGrade eq '2' ? "checked" :  ""}/>나쁨</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="goodGrade" value="1" alt="상품평가" ${vo ne null && vo.goodGrade eq '1' ? "checked" :  ""}/>매우나쁨</label>
										</li>
									</ul>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">배송평가<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
								<div class="controls">
									<ul class="score_ul">
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="deliGrade" value="5" alt="배송평가" onfocus="this.blur();" ${vo ne null && vo.deliGrade eq '5' ? "checked" :  ""}/>매우만족</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="deliGrade" value="4" alt="배송평가" onfocus="this.blur();" ${vo ne null && vo.deliGrade eq '4' ? "checked" :  ""}/>만족</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="deliGrade" value="3" alt="배송평가" onfocus="this.blur();" ${vo ne null && vo.deliGrade eq '3' ? "checked" :  ""}/>보통</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="deliGrade" value="2" alt="배송평가" onfocus="this.blur();" ${vo ne null && vo.deliGrade eq '2' ? "checked" :  ""}/>나쁨</label>
										</li>
										<li class="score_li">
											<label style="cursor:pointer"><input type="radio" name="deliGrade" value="1" alt="배송평가" onfocus="this.blur();" ${vo ne null && vo.deliGrade eq '1' ? "checked" :  ""}/>매우나쁨</label>
										</li>
									</ul>
								</div>
							</div>
							</fieldset>
							<div class="form-actions">
								<c:choose>
									<c:when test="${vo eq null}">
										<button type="submit" class="btn btn-primary" >등록하기</button>
									</c:when>
									<c:otherwise>
										<button type="submit" class="btn btn-primary" >수정하기</button>
									</c:otherwise>
								</c:choose>
								<a href="/admin/board/review/list" class="btn">목록보기</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var voFlag = "${vo}";
	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});
		if(flag){
			if(voFlag == ""){
				if($("#item_check_flag").val() != "Y") {
					$.msgbox("상품번호 중복체크를 해주세요.", {type: "info"});
					$("#itemSeq").focus();
					return false;
				}
			}
			if($(":radio[name='goodGrade']:checked").length < 1){
				alert("상품평가를 체크해주세요.");
				return false;
			}
			if($(":radio[name='deliGrade']:checked").length < 1){
				alert("배송평가를 체크해주세요.");
				return false;
			}
		}
		return flag;
	};

	var memberProc = function(obj) {
		if($("#memberId").val()==""){
			$.msgbox("검색할 아이디를 입력주세요.", {type: "info"});
			return;
		}

		$("#member-list").html( "<tr><td colspan='7' class='muted text-center' style='padding:10px'>데이터를 불러오고 있습니다</td></tr>" ).parents(".hide").show();
		$.ajax({
			url:"/admin/board/review/member/json",
			type:"get",
			data:{findword:$("#memberId").val()},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.result === "false") {
					$.msgbox(list.message, {type: "info"});
				}

				if(list.seq === undefined) {
					$("#member-list").html( "<tr><td colspan='7' class='muted text-center' style='padding:10px'>검색된 결과가 없습니다</td></tr>");
				} else if(list.seq > 0){
					$("#member-list").html( $("#memberTemplate").tmpl(list) );
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};
	var memberSelectProc = function(obj) {
		var seq = parseInt($(obj).attr("data-seq"), 10) || 0;
		$("input[name=memberSeq]").val(seq);
		$("#member-list tr[data-seq]").each(function(){
			if(parseInt($(this).attr("data-seq"), 10) !== seq) {
				$(this).remove();
			} else {
				$(this).addClass("info");
			}
		});
	};

	$("#btn-item-check").click(function() {
		var itemSeq = $("#itemSeq").val();
		$("#btn-item-check").popover('destroy');

		//상품번호 입력여부 검사
		if(itemSeq === "") {
			$.msgbox("등록할 상품번호 입력주세요.", {type: "info"});
			return;
		}
		//ajax:아이디중복체크
		$.ajax({
			type: 'POST',
			data: {itemSeq:itemSeq},
			dataType: 'json',
			url: '/admin/board/review/item/check/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message, {type: "info"});
					$("#item_check_flag").val("Y");
				} else {
					$.msgbox(data.message, {type: "info"});
					$("#item_check_flag").val("N");
					$("#itemSeq").focus();
				}
			}
		})
	});
</script>
</body>
</html>
