<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/jsp/quality/systeminfo/init.jsp" %>
<jsp:include page="/jsp/quality/roles/checkRoles.jsp">
	<jsp:param name="cd" value="13" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="/static/images/favicon.ico" />
<title>CS系统</title>
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css" />
<script type="text/css">
.mt-10 {
	margin-top: 15px;
}
.container {
	width:92%;
}
</script>

</head>
<body>
	<script src="/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<div class="container">
		<div class="row mt-10">
		<div class="col-md-12" style="height: 20px"></div>
			<div class="col-md-12" style="background-color: #FCFCFC; box-shadow: inset 1px -1px 1px #E8E8E8, inset -1px 1px 1px #E8E8E8; height: 205px">

				<p class="lead">
				重大客诉：客户端进入量产阶段，在客户终端市场发生批量性问题且造成客户品牌损失；造成客户停产且损失金额在50,000元人民币以上,客户要求赔偿、赔款等；客户IQC检验批次性不良，不良率超3%;（包含安全问题，禁用限用物质超标等客诉异常）；
				<br/>
				一般客诉：除重大客诉类型之外；
				</p> 
			</div>
		</div>
	</div>
</body>
</html>