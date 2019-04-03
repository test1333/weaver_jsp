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
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String alarmid = Util.null2String(request.getParameter("alarmid"));
	String kpicode = Util.null2String(request.getParameter("kpicode"));
	String alarmtime = Util.null2String(request.getParameter("alarmtime"));
	String alarmlevel = Util.null2String(request.getParameter("alarmlevel"));
	String actionid1 = Util.null2String(request.getParameter("actionid1"));
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	
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
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/alarm/pendingApprovalAction.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>Alarm ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value="<%=alarmid%>"/>
				</wea:item>
                <wea:item>KPI代码</wea:item>
				<wea:item>
				 <input name="kpicode" id="kpicode" class="InputStyle" type="text" value="<%=kpicode %>"/>
				</wea:item>
				<wea:item>Alarm时间段</wea:item>
				<wea:item>
				 <input name="alarmtime" id="alarmtime" class="InputStyle" type="text" value="<%=alarmtime %>"/>
				</wea:item>
				<wea:item>Alarm级别</wea:item>
				<wea:item>
				 <input name="alarmlevel" id="alarmlevel" class="InputStyle" type="text" value="<%=alarmlevel %>"/>
				</wea:item>
				<wea:item>Action ID</wea:item>
				<wea:item>
				 <input name="actionid1" id="actionid1" class="InputStyle" type="text" value="<%=actionid1 %>"/>
				</wea:item>
				


				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
		<%
		String backfields = "b.id as idkey,b.alarm_id ,b.kfcode,b.duration,b.r_level,a.actionid,a.xdfa,a.famb,a.sjwc,a.jzrq,a.wcbl,decode(a.jxsp,1,'结项审批','带创建') as xianshi,a.requestid";			  
		String fromSql  = " uf_action_plan a join  uf_alarm_info b on a.alarmid = b.alarm_id";
		String sqlWhere = " where 1=1 and b.creat_ind ='Y' and jxsp='1' and b.approval_no = '"+userid+"'";
		String orderby = " a.alarmid asc,a.actionid asc";
		String tableString = "";
		if(!"".equals(alarmid)){
		  sqlWhere +=" and b.alarm_id = '"+alarmid+"'";
		}
		if(!"".equals(kpicode)){
		  sqlWhere +=" and b.kfcode = '"+kpicode+"'";
		}
		if(!"".equals(alarmtime)){
		  sqlWhere +=" and b.duration = '"+alarmtime+"'";
		}
		if(!"".equals(alarmlevel)){
		  sqlWhere +=" and b.R_Level = '"+alarmlevel+"'";
		}
		if(!"".equals(actionid1)){
		  sqlWhere +=" and a.actionid = '"+actionid1+"'";
		}
		
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"7%\" text=\"Alarm ID\" column=\"alarm_id\" orderkey=\"alarm_id\"/>"+
			"               <col width=\"8%\" text=\"KPI代码\" column=\"kfcode\" orderkey=\"kfcode\"/>"+
			"               <col width=\"10%\" text=\"Alarm时间段\" column=\"duration\" orderkey=\"duration\"/>"+
			"               <col width=\"10%\" text=\"Alarm级别\" column=\"r_level\" orderkey=\"r_level\"/>"+
			"               <col width=\"10%\" text=\"Action ID\" column=\"actionid\" orderkey=\"actionid\"/>"+
			"               <col width=\"10%\" text=\"行动方案\" column=\"xdfa\" orderkey=\"xdfa\"/>"+
			"               <col width=\"10%\" text=\"方案目标\" column=\"famb\" orderkey=\"famb\"/>"+
			"               <col width=\"10%\" text=\"实际完成\" column=\"sjwc\" orderkey=\"sjwc\"/>"+	
			"               <col width=\"10%\" text=\"截止日期\" column=\"jzrq\" orderkey=\"jzrq\"/>"+
			"               <col width=\"7%\" text=\"完成比率\" column=\"wcbl\" orderkey=\"wcbl\"/>"+			
			"               <col width=\"8%\" text=\"审批\" column=\"xianshi\" orderkey=\"xianshi\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"  href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"   />"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
	    function onBtnSearchClick() {
			report.submit();
		}
		function refersh() {
  			window.location.reload();
  		}
     
	</script>
</BODY>
</HTML>