<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String prjID = (String)session.getAttribute("prjID");
if("".equals(prjID)){
	prjID = "-1";
}
	
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/CRM/report/getProjectReportAll.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
				
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
			
			</div>
		</FORM>

<!--<div>
	
	<input type="button" value="投前项目基本信息" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 200px;width:200px;height:20px;font-size:15px;" onclick="onchange1();"/>
<br/>&nbsp;
<br/>
</div>	-->
<wea:layout >
<wea:group context="投资项目信息" attributes="{'itemAreaDisplay':'none'}">
<wea:item>
<div id="iframe1" display="block" style="height:500px">				
<iframe src ="/formmode/view/ViewMode.jsp?type=0&modeId=80&formId=-186&billid=<%=prjID%>" scrolling="no" height="90%" width="98%"></iframe>
</div>
</wea:item>
</wea:group>
<wea:group context="任务信息" attributes="{'itemAreaDisplay':'none'}">
<wea:item>
<div id="iframe1" display="block" style="height:300px">				
<iframe src ="/formmode/search/CustomSearchBySimple.jsp?customid=100" scrolling="no" height="300px" width="98%"></iframe>
</div>
</wea:item>
</wea:group>
<wea:group context="问题列表" attributes="{'itemAreaDisplay':'none'}">
<wea:item>
<div id="iframe1" display="block" style="height:300px">				
<iframe src ="/formmode/search/CustomSearchBySimple.jsp?customid=101" scrolling="no" height="300px" width="98%"></iframe>
</div>
</wea:item>
</wea:group>
<wea:group context="项目甘特图" attributes="{'itemAreaDisplay':'none'}">
<wea:item>
<div id="iframe1" display="block" style="height:400px">				
<iframe src ="/proj/process/ViewProcessByPic1.jsp?proOid=<%=prjID%>" scrolling="yes" height="400px" width="98%"></iframe>
</div>
</wea:item>
</wea:group>
<wea:group context="项目相关周报" attributes="{'itemAreaDisplay':'none'}">
<wea:item>
<div id="iframe1" display="block" style="height:300px">				
<iframe src ="/tmc/npForWeekFrame.jsp?proID=<%=prjID%>" scrolling="no" height="300px" width="98%"></iframe>
</div>
</wea:item>
</wea:group>
<wea:group context="项目资料" attributes="{'itemAreaDisplay':'none'}">
<wea:item>
<div id="iframe1" display="block" style="height:300px">				
<iframe src ="/tmc/ProjectDocFile.jsp?ProjID=<%=prjID%>" scrolling="no" height="300px" width="98%"></iframe>
</div>
</wea:item>
</wea:group>
</wea:layout>
	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}
        function onchange1(){
			alert("1");
			if(jQuery("#iframe1").css('display')=='block'){
			jQuery("#iframe1").css('display','none'); 
			}else{
				jQuery("#iframe1").css('display','block'); 
			}
		}
		function refersh() {
  			window.location.reload();
  		}

	</script>
</BODY>
</HTML>