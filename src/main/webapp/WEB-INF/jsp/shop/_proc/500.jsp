<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
</head>
<body>
<style type="text/css">
	html, body { width:100%; height: 100%; }
	#error-table { display:table;width:100%;height:100%; }
	.table-cell { display:table-cell; text-align:center; vertical-align:middle; width:100%; height:100%; }
</style>

<div id="error-table">
	<div class="table-cell" style="">
		<div style="width: 740px;height: 370px;border: 1px solid #DBDBDB;margin: auto;padding: 20px;border-radius: 10px;box-shadow: 0 0 5px #889977;">
			<div style="background-color: #F7F7F7;width: 700px;height: 330px;border: 1px solid #DBDBDB;margin: auto;border-radius: 10px;">
				<i class="fa fa-exclamation-circle fa-5x" style="color: red;margin-top: 40px;"></i>
				<div style="font-weight: bold;margin-top: 30px;">
					시스템 오류가 발생하였습니다<br/>
					잠시후 다시 시도해 주시기 바랍니다.</div>
				<div style="margin-top: 10px;">서비스 이용에 불편을 드려 대단히 죄송합니다.</div>
				<div>
					<hr style="width: 600px;border-color: #868686;margin: 30px auto;"/>
					<button type="button" onclick="history.back(-1);" class="btn btn-primary">뒤로가기</button>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>