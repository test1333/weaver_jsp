<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.javen.gvo.quality.util.QualityUtil"%>
<%@ page import="com.javen.Util.Util"%>
<jsp:useBean id="rs" class="com.javen.Util.RecordSet" scope="page" />
<%@ include file="/jsp/quality/systeminfo/init.jsp" %>
<jsp:include page="/jsp/quality/roles/checkRoles.jsp">
	<jsp:param name="cd" value="13" />
</jsp:include>

<%
QualityUtil qu = new QualityUtil();
String kswfid = qu.getWfid("ks");
String kxwfid = qu.getWfid("kx");
String khxxxj = qu.getWfid("khxxxj");
String personname = "";
String workcode1 = Util.null2String((String)session.getAttribute("workcode"));
if("".equals(workcode1)||"sysadmin".equals(workcode1)){
	personname = "系统管理员";
}else{
	String sql = "select lastname from hrmresource where workcode='"+workcode1+"'";
	rs.executeQuery(sql);
	if(rs.next()){
		personname = Util.null2String(rs.getString("lastname"));
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<link rel="shortcut icon" type="image/x-icon" href="/static/images/favicon.ico" />
<title>CS系统</title>
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css" />
<style type="text/css">

.navbar {
	background-color: #1972C6;
}

.navbar  {
	color: #ecf0f1;
}

.navbar , .navbar  {
	color: #C0C0C0;
}

.navbar .navbar-text {
	color: #ecf0f1;
}

.navbar .navbar-text a {
	color: #000000;
}

.navbar .navbar-text a:hover, .navbar .navbar-text a:focus {
	color: #000000;
}

body {
	padding-top: 51px;
}

#main-nav {
	margin-left: 1px;
}

#main-nav.nav-tabs.nav-stacked>li>a {
	padding: 10px 8px;
	font-size: 12px;
	font-weight: 600;
	color: #FFFFFF;
	background: #1972C6;
	background: -moz-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #0F243E),
		color-stop(100%, #0F243E));
	background: -webkit-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: -o-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: -ms-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: linear-gradient(top, #0F243E 0%, #0F243E 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#0F243E',
		endColorstr='#0F243E');
	-ms-filter:
		"progid:DXImageTransform.Microsoft.gradient(startColorstr='#0F243E', endColorstr='#0F243E')";
	border: 0px solid #D5D5D5;
	border-radius: 4px;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #0F243E),
		color-stop(100%, #0F243E));
	background: -webkit-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: -o-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: -ms-linear-gradient(top, #0F243E 0%, #0F243E 100%);
	background: linear-gradient(top, #0F243E 0%, #0F243E 100%);
}

#main-nav.nav-tabs.nav-stacked>li>a>span {
	color: #4A515B;
}

#main-nav.nav-tabs.nav-stacked>li.active>a, #main-nav.nav-tabs.nav-stacked>li>a:hover
	{
	color: #FFF;
	background: #3C4049;
	background: -moz-linear-gradient(top, #4A515B 0%, #3C4049 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #4A515B),
		color-stop(100%, #3C4049));
	background: -webkit-linear-gradient(top, #4A515B 0%, #3C4049 100%);
	background: -o-linear-gradient(top, #4A515B 0%, #3C4049 100%);
	background: -ms-linear-gradient(top, #4A515B 0%, #3C4049 100%);
	background: linear-gradient(top, #4A515B 0%, #3C4049 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B',
		endColorstr='#3C4049');
	-ms-filter:
		"progid:DXImageTransform.Microsoft.gradient(startColorstr='#4A515B', endColorstr='#3C4049')";
	border-color: #2B2E33;
}

#main-nav.nav-tabs.nav-stacked>li.active>a, #main-nav.nav-tabs.nav-stacked>li>a:hover>span
	{
	color: #FFF;
}

#main-nav.nav-tabs.nav-stacked>li {
	margin-bottom: 4px;
}

/*定义二级菜单样式*/
.secondmenu a {
	font-size: 12px;
	color: #FFFFFF;
	text-align: left;
	left:12px;
}

.navbar-static-top {
	background-color: #212121;
	margin-bottom: 5px;
}

.navbar-brand {
	background: url('') no-repeat 10px 8px;
	display: inline-block;
	vertical-align: middle;
	color: #fff;
}

.nav-tabs {
	border-bottom: 0px solid #ddd;
}

.collapsed1 {
	display: none; /* hide it for small displays */
}

@media ( min-width : 992px) {
	.collapsed1 {
		display: block;
		margin-left: -16.7%; /* same width as sidebar */
	}
}

#row-main {
	overflow-x: hidden; /* necessary to hide collapsed sidebar */
}

#content {
	-webkit-transition: width 0.3s ease;
	-moz-transition: width 0.3s ease;
	-o-transition: width 0.3s ease;
	transition: width 0.3s ease;
}

#sidebar {
	-webkit-transition: margin 0.3s ease;
	-moz-transition: margin 0.3s ease;
	-o-transition: margin 0.3s ease;
	transition: margin 0.3s ease;
}

.nav>li>a:hover {
	background-color: #C0C0C0;
}
.glyphicon-th-list:focus{
	background-color: #000000;
}
.glyphicon-th-list:hover{
	background-color: #000000;
}
</style>
</head>
<body>
	<nav class="navbar  navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">				 
				<em class="navbar-brand" >Visionox</em>					
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
				
					<li>
						<div  style="padding-top:15px;padding-bottom:15px;padding-right:15px;" >
              			<span class="thumb-sm avatar pull-left m-t-n-xs m-r-xs">
            				<span class="glyphicon glyphicon-user"></span>
             			 </span><span style="color:#FFFFFF">&nbsp;<%=personname%> </span>
            			</div>
						<!-- <a href="#" color="#FFFFFF"> <span class="glyphicon glyphicon-user"></span>User</a> -->
					</li>
				</ul>

			</div>
		</div>
	</nav>
	<div class="container-fluid">
	<div class="row" >
	<div class="col-md-2 col-xs-2 col-sm-2" style="padding-left: 0px;padding-right: 0;background-color: #0F243E;color:#FFFFFF" name="sidebar" >
		<div>&nbsp;</div>
		
	</div>
	<div class="col-md-10 col-xs-10 col-sm-10" style="padding-left: 0px;padding-right: 0px;background-color: #0F243E;color:#FFFFFF" name="content">
		<div style="float:left"><span class="glyphicon glyphicon-th-list"  onclick="hide()"></span></div>
		<div style="margin-left:40px" id="btlxs">首页</div>
	</div>
	</div>
		<div class="row" id="row-main">
			<div class="col-md-2 col-xs-2 col-sm-2" style="padding-left: 0px;padding-right: 0px" name="sidebar">
				<div id='leftdiv1' style="background-color: #0F243E; overflow-y: auto;overflow-x: hidden; height:100%">
					<ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
						<li class="active" ><a href="home" > <i
								class="glyphicon glyphicon-home"></i> 首页
						</a></li>

						<li><a href="#ksxt" class="nav-header collapsed"
							data-toggle="collapse"> <i class="glyphicon glyphicon-refresh"></i>
								客诉系统 <span class="pull-right glyphicon glyphicon-chevron-down"></span>
						</a>
							<ul id="ksxt" class="nav nav-list collapse secondmenu"
								style="height: 0px;">
								<li><a href="kslcxj"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客诉新建流程</a></li>
								<li><a href="ksdt"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客诉动态</a></li>
								<li><a href="kslb"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客诉列表</a></li>
							</ul></li>
						<li><a href="#kxxt" class="nav-header collapsed" data-toggle="collapse"> <i class="glyphicon glyphicon-refresh"></i>
								客需系统 <span class="pull-right glyphicon glyphicon-chevron-down"></span>
						</a>
							<ul id="kxxt" class="nav nav-list collapse secondmenu"
								style="height: 0px;">
								<li><a href="kxlcxj"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客需新建流程</a></li>
								<li><a href="kxlb"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客需列表</a></li>
							</ul></li>
						<li><a href="#khxx" class="nav-header collapsed" data-toggle="collapse"> <i class="glyphicon glyphicon-refresh"></i>
								客户信息<span class="pull-right glyphicon glyphicon-chevron-down"></span>
						</a>
							<ul id="khxx" class="nav nav-list collapse secondmenu"
								style="height: 0px;">
								<li><a href="khxxxj"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客户信息新建</a></li>
								<li><a href="khxxlb"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;客户信息列表</a></li>
							</ul></li>
						<li><a href="#wblj" class="nav-header collapsed" data-toggle="collapse"> <i class="glyphicon glyphicon-refresh"></i>
								外部链接<span class="pull-right glyphicon glyphicon-chevron-down"></span>
							</a>
							<ul id="wblj" class="nav nav-list collapse secondmenu"
								style="height: 0px;">
								<li><a href="vlrr"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;VLRR报表系统</a></li>
								<li><a href="rma"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;RMA系统</a></li>
								<li><a href="vidas"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;Vidas系统</a></li>
								<li><a href="qit"><i class="glyphicon glyphicon-folder-open"></i>&nbsp;Qit系统</a></li>
							</ul>
						</li>
						
					</ul>
				</div>
			</div>
			<div class="col-md-10 col-xs-10 col-sm-10" name="content" style="padding-left: 0px;padding-right: 0px">
				<div id='leftdiv2'>
					<iframe src="/jsp/quality/main/main.jsp" id="mainFrame"
						style="height: 99%; width: 100%; overflow-x:scroll" frameborder="no" border="0"
						marginwidth="0" marginheight="0" scrolling="yes"  
						allowtransparency="yes" ></iframe>
				</div>

			</div>
		</div>
	</div>
	<script src="/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
	<script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			var clienthei = window.innerHeight
			var clientwid= window.innerWidth
			var height1 = Number(clienthei) - 71;
			if(clientwid <1191){
				clientwid =1280;
			}
			height1 = height1 + 'px';
			document.getElementById('leftdiv1').style.height = height1;
			document.getElementById('leftdiv2').style.height = height1;
			document.getElementsByTagName("body")[0].style.width  = clientwid+"px";
		}
		window.onresize=function(){
			var clienthei = window.innerHeight
			var clientwid= window.innerWidth
			var height1 = Number(clienthei) - 71;
			if(clientwid <1191){
				clientwid =1280;
			}
			height1 = height1 + 'px';
			document.getElementById('leftdiv1').style.height = height1;
			document.getElementById('leftdiv2').style.height = height1;
			document.getElementsByTagName("body")[0].style.width  = clientwid+"px";
			
		};
		function hide() {
			$("div[name='sidebar']").toggleClass("collapsed1");
			$("div[name='content']").toggleClass("col-md-12 col-md-10");
			//$("#sidebar1").toggleClass("collapsed1");
			//$("#content1").toggleClass("col-md-12 col-md-10");
		}
		function changepage(url) {
			var iframe = document.getElementById("mainFrame");
			iframe.src = url;
		}
		$(document).ready(function() {
			$('ul.nav > li').click(function(e) {
				e.preventDefault();
				$('ul.nav > li').removeClass('active');
				$(this).addClass('active');
				var url=jQuery(this).find("a").attr("href");
				if(url == "home"){
					url = "/jsp/quality/main/main.jsp";
					jQuery("#btlxs").text("首页")
				}else if(url == "vlrr"){
					url = "http://report.visionox.cn:8080/GvoReport/decision#directory";
					jQuery("#btlxs").text("VLRR报表系统")
				}else if(url == "rma"){
					url = "http://172.16.135.26:8080/wms-visionox-web-login/home.jsp";
					jQuery("#btlxs").text("RMA系统")
				}else if(url == "vidas"){
					url = "http://10.69.2.111/VidasLauncher";		
					jQuery("#btlxs").text("Vidas系统")
				}else if(url == "ksdt"){
					url = "/jsp/quality/ks/ksdtlist.jsp";	
					jQuery("#btlxs").text("客诉动态")
				}else if(url == "kslb"){
					url = "/jsp/quality/ks/kslist.jsp";	
					jQuery("#btlxs").text("客诉列表")
				}else if(url == "kslcxj"){
					url = "/jsp/quality/OARelated/createRoute.jsp?wfid=<%=kswfid%>";	
					window.open(url);
					return;
				}else if(url == "kxlcxj"){
					url = "/jsp/quality/OARelated/createRoute.jsp?wfid=<%=kxwfid%>";	
					window.open(url);
					return;
				}else if(url == "kxlb"){
					url = "/jsp/quality/kx/kxlist.jsp";
					jQuery("#btlxs").text("客需列表")
				}else if(url == "khxxxj"){
					url = "/jsp/quality/OARelated/addModeInfo.jsp?modeid=<%=khxxxj%>";	
					window.open(url);
					return;
				}else if(url == "khxxlb"){
					url = "/jsp/quality/khxx/khlist.jsp";	
					jQuery("#btlxs").text("客户信息列表")
				}else{
					url = "###";
				}
				if(url.indexOf("###")<0){
					var iframe = document.getElementById("mainFrame");
					iframe.src = url;
				}
				

			});
		});
		
		function changebtlxs(btlxs){
			jQuery("#btlxs").text(btlxs)
		}
	</script>
</body>
<script type="text/javascript">
document.onreadystatechange = function () {
	            if (document.readyState == "complete") {
	                document.body.style.display = "block";
	            } else {
	                document.body.style.display = "none";
	            };
	        };
</script>
</html>
