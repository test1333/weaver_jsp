﻿
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<script type="text/javascript">


</script>
<style>
.checkbox {
	display: none
}
</style>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

String contractID = Util.null2String(request.getParameter("contractID"));

if("".equals(contractID)){
	contractID = "-1";
}
String tmc_pageId = "contractxswx";
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;


%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				
			</tr>
		</table>

	</FORM>
	<%
								
	String backfields = " id,C_No,version,Year,KUNNRNAME,BEGINTIME,ENDTIME,POSTUSER,POSTDATE,PROCESS_TYPENAME"; 
	String fromSql  = " from uf_Con_ku_OTC_SC ";
	String sqlWhere = " where superid = " + contractID;
	String orderby = " version desc" ;
	String tableString = "";


//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"15%\" labelid=\"16802\" text=\"合同编号\" column=\"C_No\" orderkey=\"C_No\" linkvaluecolumn=\"id\" linkkey=\"billid\" "+
		" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=2545&amp;formId=-589&amp;opentype=0&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
	 "				<col width=\"5%\"  text=\"年度\" column=\"Year\" orderkey=\"Year\"   />"+
	  "				<col width=\"8%\"  text=\"合同处理类型\" column=\"PROCESS_TYPENAME\" orderkey=\"PROCESS_TYPENAME\"   />"+
	  "				<col width=\"15%\"  text=\"客户名称\" column=\"KUNNRNAME\" orderkey=\"KUNNRNAME\"   />"+
      "				<col width=\"10%\"  text=\"合同起始日期\" column=\"BEGINTIME\" orderkey=\"BEGINTIME\"  />"+
	  "				<col width=\"10%\"  text=\"合同终止日期\" column=\"ENDTIME\" orderkey=\"ENDTIME\"  />"+
	  "				<col width=\"8%\"  text=\"提交人\" column=\"POSTUSER\" orderkey=\"POSTUSER\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/>"+
	  "				<col width=\"10%\"  text=\"提交日期\" column=\"POSTDATE\" orderkey=\"POSTDATE\"  />"+
	  "				<col width=\"5%\"  text=\"版本\" column=\"version\" orderkey=\"version\"   />"+
				
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">

	</script>
</BODY>
</HTML>
