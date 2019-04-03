<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%
int emp_id = user.getUID();
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage = 10;

	//int userid = user.getUID();
	//user = (User)session.getAttribute("weaver_user@bean");
	//user.setLanguage(7);
	//int uid_1 = user.getUID();
	//if(uid_1!=-10&&uid_1!=1) {
		//	session.removeAttribute("weaver_user@bean");
		//	response.sendRedirect("/login/login.jsp") ;
		//	return ;
	//}//控制权限

String sqr_name = Util.null2String(request.getParameter("sqr_name"));  
String sqrbm_name = Util.null2String(request.getParameter("sqrbm_name"));  
String dcr1_name = Util.null2String(request.getParameter("dcr1_name"));  
String sqqrlxfs_name = Util.null2String(request.getParameter("sqqrlxfs_name"));

%>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<link rel="stylesheet" type="text/css" href="/gvo/information/css/css.css">
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	
	<BODY>
		
		<FORM id=weaver name=weaver method=post action="" >
		
<table  style=" background-repeat:repeat-x;" width=100% height=100% border="0" cellspacing="0" cellpadding="0" background="/gvo/information/images/bannern.jpg">
<tr>
	<td valign="top">
		<TABLE class=Shadow  style=" background-color:#EDF1F5">
		<tr>
		<div class="zstop" style="height:180px; width:100%; position:relative;">
		  <div class="zslr" style=" position:absolute; width:90px; height:90px; left:30px; top:105px; color:#fff;"><a href="/formmode/view/AddFormMode.jsp?modeId=1001&formId=-325&type=1"  target="_blank">知识录入</a></div>
		  <div class="zscx" style=" position:absolute; width:90px; height:90px; left:150px; top:105px; color:#fff;"><a href="/formmode/search/CustomSearchBySimple.jsp?customid=961&e71459318042984=" target="_blank">知识查询</a></div>
		</div>
		
		<td valign="top">
		<div class="juzhong" style=" text-align:center;">
<div class="juzhong" style="margin:0 auto; width:1050px; padding-top:50px;">

<table width=100% class=ViewForm>
<tr>

<div class="ruodian1">
     <div class="ruodian" style="padding-left:120px;">
        <a href="/gvo/information/informationInfoWeak_wev8.jsp" target="_blank">弱电类</a>
	 </div>
	 <div class="rdlist">
	    <ul>
	      <li>弱电类：包含综合布线、网络、视频系统、考勤门禁、监控系统和电话等异常问题的解决办法和技术手册。</li>
	    </ul>
	 </div>
	 </div>
	 <div class="yunwei1">
	 <div class="yunwei" style="padding-left:120px;">
	    <a href="/gvo/information/informationInfoO&M_wev8.jsp" target="_blank">运维类</a>
	  </div>
	   <div class="ywlist">
	     <ul>
	      <li>运维类：包含桌面运维、存储技术、会务支持、服务器和数据库等异常问题的解决办法和技术手册。</li>      
	     </ul>
	  </div> 
	</div>
	  <div class="yingyong1">
	   <div class="yingyong" style="padding-left:120px;">
	     <a href="/gvo/information/informationInfosystem_wev8.jsp" target="_blank">应用系统</a>
		 </div>
		  <div class="yylist">
	     <ul>
	      <li>应用系统类：包含以应用系统和办公系统为主的各软件系统的异常问题解决办法和技术手册，主要由SAP ERP、Kingdee ERP、鼎捷 ERP、泛微OA、EMC D2、HR、BI、旧OA和FineReport等系统。</li>
	     </ul>
	 </div>  
	  
</div>
</tr>
</table></div></div>		
	</FORM>
	
</BODY>
</HTML>