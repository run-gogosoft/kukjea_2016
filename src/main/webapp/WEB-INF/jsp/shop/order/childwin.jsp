<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>loading...</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style>
		body, tr, td {
			font-size: 9pt;
			color: #433F37;
			line-height: 19px;
		}
		table, img {
			border: none
		}
		.pl_01 {
			padding: 1 10 0 10;
			line-height: 19px;
		}
		.a:link {
			font-size: 9pt;
			color: #333333;
			text-decoration: none
		}
		.a:visited {
			font-size: 9pt;
			color: #333333;
			text-decoration: none
		}
		.a:hover {
			font-size: 9pt;
			color: #0174CD;
			text-decoration: underline
		}
		.txt_03a:link {
			font-size: 8pt;
			line-height: 18px;
			color: #333333;
			text-decoration: none
		}
		.txt_03a:visited {
			font-size: 8pt;
			line-height: 18px;
			color: #333333;
			text-decoration: none
		}
		.txt_03a:hover {
			font-size: 8pt;
			line-height: 18px;
			color: #EC5900;
			text-decoration: underline
		}
	</style>
	<script type="text/javascript">
		<!--
		function MM_reloadPage(init) {  //reloads the window if Nav4 resized
			if (init == true) with (navigator) {
				if ((appName == "Netscape") && (parseInt(appVersion) == 4)) {
					document.MM_pgW = innerWidth;
					document.MM_pgH = innerHeight;
					onresize = MM_reloadPage;
				}
			}
			else if (innerWidth != document.MM_pgW || innerHeight != document.MM_pgH) location.reload();
		}
		MM_reloadPage(true);

		function MM_jumpMenu(targ, selObj, restore) { //v3.0
			eval(targ + ".location='" + selObj.options[selObj.selectedIndex].value + "'");
			if (restore) selObj.selectedIndex = 0;
		}
		//-->
	</script>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">
			<table width="300" height="150" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="143" align="center" valign="top" background="/front-assets/images/order/loading_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="33" align="center" style="padding:0 0 0 0">
								</td>
							</tr>
							<tr>
								<td height="45" align="center" valign="bottom">now loading...</td>
							</tr>
							<tr>
								<td height="35" align="center"><img src="/front-assets/images/order/loading.gif" width="269" height="14" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
