<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.login.Account"%>
<%@ include file="/systeminfo/init.jsp"%>
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="UsrTemplate"
	class="weaver.systeminfo.template.UserTemplate" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<%
//	if(!cu.canOperate(user,"3"))//不具有入口权限
//	{
//		response.sendRedirect("/notice/noright.jsp");
//		return;
//	}
	UsrTemplate.getTemplateByUID(user.getUID(), user
			.getUserSubCompany1());
	String logo = UsrTemplate.getLogo();
	String logoBottom = UsrTemplate.getLogoBottom();
	String templateTitle = UsrTemplate.getTemplateTitle();
	String strDepartment=departmentComInfo.getDepartmentname(String.valueOf(user.getUserDepartment()));
	boolean maintFlag = false;
	if(cu.canOperate(user,"1"))//后台维护权限
	{
		maintFlag = true;
	}
%>
<html>
	<title>公司卡片</title>
	<head>
		<link href="/cpcompanyinfo/style/Operations2.css" rel="stylesheet"
			type="text/css" />
		<link href="/cpcompanyinfo/style/Public2.css" rel="stylesheet"
			type="text/css" />
		<link href="/cpcompanyinfo/style/Business2.css" rel="stylesheet"
			type="text/css" />
		<link href="/newportal/style/Contacts.css" rel="stylesheet"
			type="text/css" />
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
	<script type="text/javascript">
		function doLogOut(){
			window.close();
		}
	</script>
	</head>

	<body>
	
		<script type="text/javascript" src="/js/swfupload/swfupload.js"></script>
		<script type="text/javascript" src="/js/swfupload/swfupload.queue.js"></script>
		<script type="text/javascript" src="/js/swfupload/fileprogress.js"></script>
		<script type="text/javascript" src="/js/swfupload/handlers.js"></script>
		<script type='text/javascript' src="/js/weaver-lang-cn-gbk.js"></script>
		
		<SCRIPT language="javascript" src="/js/datetime.js"></script>
		<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
		<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>
		<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
		<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>

		<script type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
		<script type='text/javascript' src='/cpcompanyinfo/js/jquery.qtip-1.0.0-rc3.min.js'></script>
			
		<!--头部 start-->

	</body>
</html>