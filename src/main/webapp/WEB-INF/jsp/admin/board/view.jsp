<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>${title} <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>게시판 관리</li>
			<li>${title}</li>
			<li class="active">상세 정보</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title"><i class="fa fa-newspaper-o"></i> 상세 정보</h3></div>
					<!-- 내용 -->
					<div class="box-body">
					<c:choose>
						<c:when test="${boardGroup eq 'notice'}">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:20%;" />
								<col style="width:80%;" />
							</colgroup>
					        <tbody>
					          <tr>
					            <th>작성자</th>
					            <td>${ vo.name }(${vo.id})</td>
					          </tr>
					          <tr>
					          	<th>등록일</th>
					            <td>
					            	<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
									<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
								</td>
					          </tr>
					          <c:if test="${sessionScope.loginType ne 'S'}">
						          <tr>
							          <th>쇼핑몰</th>
							          <td>
								          <c:choose>
									          <c:when test="${vo.mallName ne ''}">
										          ${vo.mallName}
									          </c:when>
									          <c:otherwise>
										          없음
									          </c:otherwise>
								          </c:choose>
							          </td>
						          </tr>
					          </c:if>
					          <tr>
					            <th>공지대상</th>
					            <td>
					            	<c:choose>
										<c:when test="${vo ne null && vo.categoryCode eq 1}">
											고객
										</c:when>
										<c:when test="${vo ne null && vo.categoryCode eq 2}">
											입점업체
										</c:when>
									</c:choose>
					            </td>
					          </tr>
					          <tr>
					            <th>제목</th>
					            <td>${ vo.title }</td>
					          </tr>
					          <tr>
					            <th>내용</th>
					            <td>
					            	<%-- 첨부파일이 존재할 경우 --%>
								<c:if test="${vo.isFile eq 'Y'}">
									<div style="padding:5px 15px 5px 0;">
										<ul class="list-unstyled">
											<c:forEach var="item" items="${file}">
											<li>
												<a href="/admin/board/${boardGroup}/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
													<span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
													${item.filename}
												</a>
											</li>
											</c:forEach>
										</ul>
									</div>
								</c:if>
									<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
					            </td>
					          </tr>
					      </tbody>
					    </table>
						</c:when>
						<c:when test="${boardGroup eq 'one'}">
						<table class="table table-bordered table-striped">
						<colgroup>
							<col style="width:20%;" />
							<col style="width:80%;" />
						</colgroup>
			      		  <tbody>
			      		  	<tr>
			      		  		<th>작성자</th>
			      		  		<td>${ vo.name }(${vo.id})</td>
			      		  	</tr>
			      		  	<tr>
			      		  		<th>등록일</th>
			      		  		<td>
			      		  			<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
									<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
			      		  		</td>
			      		  	</tr>
			      		  	<c:if test="${vo.integrationSeq ne null}">
							  	<tr>
				      		  		<th>주문번호</th>
				      		  		<td>
								        <c:choose>
									        <c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5)}">
										        <a href="/admin/order/view/${vo.orderSeq}?seq=${vo.integrationSeq}">${vo.integrationSeq}</a>
									        </c:when>
									        <c:otherwise>
										        ${vo.integrationSeq}
									        </c:otherwise>
								        </c:choose>
				      		  		</td>
				      		  	</tr>
			      		  	</c:if>
			      		  	<tr>
			      		  		<th>구분</th>
			      		  		<td>
			      		  			<c:forEach var="commonItem" items="${commonList}">
													<c:if test="${vo.categoryCode eq commonItem.value}">${commonItem.name}</c:if>
												</c:forEach>
			      		  		</td>
			      		  	</tr>
					        <tr>
						        <th>쇼핑몰</th>
						        <td>${ vo.mallName }</td>
					        </tr>
			      		  	<tr>
			      		  		<th>제목</th>
			      		  		<td>${ vo.title }</td>
			      		  	</tr>
			      		  	<tr>
			      		  		<th>내용</th>
			      		  		<td>
			      		  			<%-- 첨부파일이 존재할 경우 --%>
							          <c:if test="${vo.isFile eq 'Y'}">
							            <div style="padding:5px 15px 5px 0;">
							                <ul class="list-unstyled">
							                    <c:forEach var="item" items="${file}">
							                        <li>
							                            <a href="/admin/board/${boardGroup}/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
							                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
							                                    ${item.filename}
							                            </a>
							                        </li>
							                    </c:forEach>
							                </ul>
							            </div>
							          </c:if>
			      		  			${fn:replace(vo.content, newLine, "<br/>")}
			      		  		</td>
			      		  	</tr>
			      		  	<tr>
			      		  		<th>답변자</th>
			      		  		<td>
			      		  			<c:choose>
										<c:when test="${ vo.answerSeq ne 0 }">
											${ vo.answerName }
										</c:when>
									</c:choose>
			      		  		</td>
			      		  	</tr>
			      		  	<tr>
			      		  		<th>답변</th>
			      		  		<td>${fn:replace(vo.answer, newLine, "<br/>")}</td>
			      		  	</tr>
			      		  </tbody>
			      		</table>
						</c:when>
						<c:when test="${boardGroup eq 'faq'}">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:20%;" />
								<col style="width:80%;" />
							</colgroup>
					        <tbody>
					          <tr>
					            <th>작성자</th>
					            <td>${ vo.name }(${vo.id})</td>
					          </tr>
					          <tr>
					          	<th>등록일</th>
					            <td>
					            	<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
									<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
								</td>
					          </tr>
					          <tr>
					            <th>구분</th>
					            <td>
					            	<c:choose>
							            <c:when test="${ vo.categoryCode eq 10 }">
								            회원
							            </c:when>
							            <c:when test="${ vo.categoryCode eq 20 }">
								            주문/결제/배송
							            </c:when>
							            <c:when test="${ vo.categoryCode eq 30 }">
								            환불/취소/재고
							            </c:when>
							            <c:when test="${ vo.categoryCode eq 40 }">
								            영수증
							            </c:when>
							            <c:when test="${ vo.categoryCode eq 50 }">
								            이벤트
							            </c:when>
							            <c:when test="${ vo.categoryCode eq 60 }">
								            기타
							            </c:when>
									</c:choose>
					            </td>
					          </tr>
					          <tr>
					            <th>제목</th>
					            <td>${ vo.title }</td>
					          </tr>
					          <tr>
					            <th>내용</th>
					            <td>
								<%-- 첨부파일이 존재할 경우 --%>
								<c:if test="${vo.isFile eq 'Y'}">
									<div style="padding:5px 15px 5px 0;">
										<ul class="list-unstyled">
											<c:forEach var="item" items="${file}">
											<li>
												<a href="/admin/board/${boardGroup}/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
													<span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
													${item.filename}
												</a>
											</li>
											</c:forEach>
										</ul>
									</div>
								</c:if>
									<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
					            </td>
					          </tr>
					      </tbody>
					    </table>
						</c:when>
						<c:when test="${boardGroup eq 'qna'}">
						<table class="table table-bordered table-striped">
						<colgroup>
							<col style="width:20%;" />
							<col style="width:80%;" />
						</colgroup>
				        <tbody>
				          <tr>
				            <th>작성자</th>
				            <td>${ vo.name }(${vo.id})</td>
				          </tr>
				          <tr>
				          	<th>등록일</th>
				            <td>
				            	<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
								<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
							</td>
				          </tr>
				          <tr>
				            <th>상품번호</th>
				            <td>
				                ${ vo.integrationSeq }&nbsp;
	                                     <%--<a href="/shop/detail/${vo.integrationSeq}" target="_blank" class="btn" data-toggle="tooltip" title="미리보기"><i class="icon-search"></i></a>                                    </td>--%>
				          </tr>
				          <tr>
				            <th>상품명</th>
				            <td>
	                                     <div style="float:left;"><img src="/upload${fn:replace(vo.img1, 'origin', 's60')}" style="width:70px;" alt=""/></div><div style="float:left;width:430px;">${vo.itemName}</div>
	                                 </td>
				          </tr>
				          <tr>
					          <th>쇼핑몰</th>
					          <td>${ vo.mallName }</td>
				          </tr>
				          <tr>
				              <th>제목</th>
				              <td>${ vo.title }</td>
				          </tr>
				          <tr>
				            <th>내용</th>
				            <td>
				            	<%-- 첨부파일이 존재할 경우 --%>
						          <c:if test="${vo.isFile eq 'Y'}">
						            <div style="padding:5px 15px 5px 0;">
						                <ul class="list-unstyled">
						                    <c:forEach var="item" items="${file}">
						                        <li>
						                            <a href="/admin/board/${boardGroup}/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
						                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
						                                    ${item.filename}
						                            </a>
						                        </li>
						                    </c:forEach>
						                </ul>
						            </div>
						          </c:if>
				            	${fn:replace(vo.content, newLine, "<br/>")}
				            </td>
				          </tr>
				          <tr>
				            <th>답변자</th>
				            <td>
				            	<c:choose>
									<c:when test="${ vo.answerSeq ne 0 }">
										${ vo.answerName }
									</c:when>
								</c:choose>
				            </td>
				          </tr>
				          <tr>
		      		  		<th>답변</th>
		      		  		<td>${fn:replace(vo.answer, newLine, "<br/>")}</td>
			      		  </tr>
				      </tbody>
				    </table>
						</c:when>
					</c:choose>
					</div>
					<div class="box-footer text-center">
						<%-- 수정 --%>
						<c:choose>
							<c:when test="${ boardGroup eq 'notice'}">
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<%-- 관리자만 수정 가능 --%>
									<button type="button" class="btn btn-warning"  onclick="goEditNotice('${boardGroup}','${vo.seq}','${vo.userSeq}')">수정하기</button>
								</c:if>
							</c:when>
							<c:when test="${boardGroup eq 'faq'}">
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<%-- 관리자만 수정 가능 --%>
									<button type="button" class="btn btn-warning"  onclick="goEditNotice('${boardGroup}','${vo.seq}','${vo.userSeq}')">수정하기</button>
								</c:if>
							</c:when>
							<c:when test="${boardGroup eq 'one'}">
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5)}">
									<%-- 관리자만 수정 가능 --%>
									<button type="button" class="btn btn-warning"  onclick="goEditNotice('${boardGroup}','${vo.seq}','${vo.userSeq}')">답변하기</button>
								</c:if>
							</c:when>
							<c:when test="${boardGroup eq 'qna'}">
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
									<%-- 관리자만 수정 가능 --%>
									<button type="button" class="btn btn-warning"  onclick="goEditNotice('${boardGroup}','${vo.seq}','${vo.userSeq}')">답변하기</button>
								</c:if>
							</c:when>
						</c:choose>
						<input type="hidden" name="seq" value="${vo.seq}" />
						<%-- 삭제 --%>
						<c:choose>
							<c:when test="${ boardGroup eq 'notice' or boardGroup eq 'faq' or boardGroup eq 'one' or boardGroup eq 'qna'}">
								<c:if test="${vo ne null and sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<%-- 관리자만 삭제 가능 --%>
									<span role="button" class="btn btn-danger" onclick="confirmDelete('${vo.userSeq}')">삭제하기</span>
								</c:if>
							</c:when>
						</c:choose>
						<%-- 리스트가기 --%>
						<button type="button" class="btn btn-default" onClick="goCancelNotice('${boardGroup}')">목록보기</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%-- 삭제 모달 --%>
<div id="myModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding:1px 15px; background-color:#D73925; color:#fff">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel" style="margin-top:15px;">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제 하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" aria-hidden="true">닫기</button>
				<a href="#myModal2" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">삭제하기</a>
			</div>
		</div>
	</div>
</div>

<div id="myModal2" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding:1px 15px; background-color:#D73925; color:#fff">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel" style="margin-top:15px;">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제하시면 다시는 복구할수 없습니다, 정말 삭제하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" aria-hidden="true">닫기</button>
				<button class="btn btn-danger" onClick="goDeleteNotice('${boardGroup}','${vo.seq}','${vo.userSeq}')">삭제하기</button>
			</div>
		</div>
	</div>
</div>

<div id="iframe_content" style="display:none">${vo.content}</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	<c:if test="${boardGroup eq 'notice' or boardGroup eq 'faq'}">
	$(window).load(function() {
		$("#content_view").contents().find("body").html($("#iframe_content").html());
		$("#content_view").height($("#content_view").contents().find("body")[0].scrollHeight + 30);
	});
	</c:if>
	var goEditNotice = function(arg1,arg2,arg3){
		location.href = "/admin/board/edit/"+arg1+"/"+arg2+"?userSeq="+arg3;
	};
	var goCancelNotice = function(arg1){
		location.href = "/admin/board/list/"+arg1;
	};
	var confirmDelete = function(userSeq){
		$("#myModal").modal("show");
	};
	var goDeleteNotice = function(arg1,arg2,arg3){
		location.href = "/admin/board/del/proc/"+arg1+"/"+arg2+"?userSeq="+arg3;
	};
</script>
</body>
</html>
