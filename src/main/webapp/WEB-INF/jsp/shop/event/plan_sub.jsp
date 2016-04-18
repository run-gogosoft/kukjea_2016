<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/plan/plan.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
    #popup-zone {
          margin-top:-303px;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="breadcrumb">
	<i class="fa fa-home fa-2x"></i> 홈 <span class="arrow-sub">&gt;</span> 기획전 <span class="arrow-sub">&gt;</span> <strong>${vo.title}</strong>
</div>

<div class="main-banner-img-wrap">
	${fn:replace(fn:replace(vo.html,"${const.ASSETS_PATH}",const.ASSETS_PATH), "${mallId}",mallVo.id)}
</div>

<c:forEach var="groupList" items="${groupList}" varStatus="status">
	<div class="main-title">
		<i class="fa fa-angle-right fa-2x"></i> <span style="margin-left:7px;">${groupList.groupName}</span>
	</div>
	<%--sub-item-list뒤의 숫자는 status.count여야 한다.--%>
	<div class="ch-container sub-item-list-wrap sub-item-list${status.count}">
		<ul class="ch-5col">
			<c:forEach var="itemList" items="${itemList}" varStatus="status">
				<c:if test="${groupList.eventGroupSeq == itemList.groupSeq }">
				  <li>
				  	<div class="img">
				  		<a href="/shop/detail/${itemList.itemSeq}">
				  			<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(itemList.img1, 'origin', 's270')}" <c:if test="${itemList.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(itemList.img2, 'origin', 's270')}"</c:if> width="218" height="205" alt="" />
				  		</a>
				  	</div>
				  	<div class="info">
			    		<div class="name"><a href="/shop/detail/${itemList.itemSeq}">${itemList.itemName}</a></div>
			    		<c:choose>
						    <c:when test="${itemList.itemTypeCode eq 'N'}">
						    	<div class="price"><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" /><span>원</span></div>
						    </c:when>
						    <c:when test="${itemList.itemTypeCode eq 'E'}">
						    	<div class="price" style="font-size:20px;">견적요청</div>
						    </c:when>
						  </c:choose>
			    	</div>
				  </li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</c:forEach>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<c:if test="${sessionScope.loginSeq > 0}">
	<div class="ch-container">
	    <div class="content" style="margin-top:20px;">
	        <div class="content-wrapper">
	            <div class="content-box">
	                <div class="content-body" style="position:relative;">
	                  <div class="well">

	                    <!--   <div class="form-group">
	                          <div style="width:250px;display:inline-block;margin-right:50px;">
	                              <label>이름 <i data-code="title" class="fa fa-check-square-o"></i></label>
	                              <input type="text" name="memberName" class="form-control" value="" maxlength="25"/>
	                          </div>
	                          <div style="width:250px;display:inline-block">
	                              <label>비밀번호 <i data-code="title" class="fa fa-check-square-o"></i></label>
	                              <input type="password" name="password" class="form-control" value="" maxlength="25"/>
	                          </div>
	                      </div> -->

	                      <div class="form-group">
	                          <label for="content">댓글 쓰기 <i data-code="content" class="fa fa-check-square-o"></i></label>
	                          <button type="submit" class="pull-right btn btn-xs btn-primary" onclick="CHPlanUtil.submit()">
	                              <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 등록
	                          </button>
	                          <textarea id="content" name="content" class="form-control" rows="3" style="margin-top:10px;resize:none"></textarea>
	                      </div>
	                  </div>
	                </div>
	            </div>
	            <div class="clearfix"></div>
	        </div>
	    </div>
	</div>
</c:if>
<!-- template -->
<script id="trTemplate" type="text/html">
	<div style="padding:10px 20px; border-top:1px solid #CCC; border-bottom:1px solid #CCC; background-color:#FCFCFC;">
	    등록된 댓글 수 '<%="${totalCount}"%>'
	</div>

	{{each list}}
		<div style="padding:20px; border-bottom:1px dashed #EEE; background-color:#fff;">
	    <div style="margin-bottom: 3px;">
	        <div class="pull-left">
	            <small class="text-muted"><%="${name}"%> <%="${regDate}"%></small>
	        </div>
	        ::

	        <div class="pull-right">
	            <button type="button" class="close" style="font-size: 14px;" onclick="CHPlanUtil.showDeleteModal('<%="${seq}"%>', '<%="${userSeq}"%>', '${sessionScope.loginSeq}');">
	                <span aria-hidden="true">&times;</span><span class="sr-only">Delete</span>
	            </button>
	        </div>

	        <div class="clearfix"></div>
	    </div>
	    <div style="width:1040px; height:100%; word-break:break-all"><%="${content}"%></div>
		</div>
	{{/each}}
</script>

<div class="ch-container">
    <div class="content" style="margin:0px auto 50px auto;">
        <div class="content-wrapper">
            <div class="content-box">
                <div class="content-body" style="position:relative;">
										<div id="boardTarget"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<div id="paging" style="text-align:center;"></div>

<div class="modal fade" id="DeleteModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#D2322D">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" style="color:#fff">정말로 삭제하시겠습니까?</h4>
            </div>
            <div class="modal-body">
               이 작업은 복원하실 수 없습니다!!
            </div>
            <form name="deleteForm" action="/shop/event/plan/comment/delete" target="zeroframe" method="POST">
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <button type="button" onclick="CHPlanUtil.deleteCommentProc()" class="btn btn-danger">삭제</button>
                </div>
            </form>
        </div>
    </div>
</div>
<input type="hidden" id="seq" value="${vo.seq}">
<input type="hidden" id="pageNum" value="${pageNum}">
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/plan/plan.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// image flip
		$(".img img[data-src]").mouseover(function(){
			if(typeof $(this).attr("data-swap") === "undefined") {
				$(this).attr("data-swap", $(this).attr("src"));
			}
			$(this).attr("src", $(this).attr("data-src"));
		}).mouseleave(function(){
			$(this).attr("src", $(this).attr("data-swap"));
		});

		for(var i=0; i<$('.sub-item-list-wrap').length; i++) {
			CHPlanUtil.calcLine(i+1);
		}

		CHPlanUtil.getCommentList(0);
		CHPlanUtil.getCommentPaging(0);
	});
</script>
</body>
</html>