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
	String targetname = Util.null2String(request.getParameter("targetname"));
	String alarmtime = Util.null2String(request.getParameter("alarmtime"));
	String alarmlevel = Util.null2String(request.getParameter("alarmlevel"));
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
		<FORM id=report name=report action="/alarm/pendingApprovalAlarm.jsp" method=post>
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
				<wea:item>指标名称</wea:item>
				<wea:item>
				 <input name="targetname" id="targetname" class="InputStyle" type="text" value="<%=targetname %>"/>
				</wea:item>	
				<wea:item>Alarm时间段</wea:item>
				<wea:item>
				 <input name="alarmtime" id="alarmtime" class="InputStyle" type="text" value="<%=alarmtime %>"/>
				</wea:item>
				<wea:item>Alarm级别</wea:item>
				<wea:item>
				 <input name="alarmlevel" id="alarmlevel" class="InputStyle" type="text" value="<%=alarmlevel %>"/>
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
		String backfields = "id,alarm_id,alarm_id as alarmid,kfcode,getTextValue('KPI',"+language+",kfcode) as namedesc ,duration,target_val,actual_val,decode(lxsp,1,'立项审批',2,'待提交') approvestatus,is_plan,Receipt_NO,requestid,R_Level,decode(lxsp,1,'立项审批','待提交') as xianshi";			  
		String fromSql  = " uf_alarm_info t";
		String sqlWhere = " where 1=1 and creat_ind ='Y' and approval_no = '"+userid+"'";
		String orderby = " alarm_id desc";
		String tableString = "";
		if(!"".equals(alarmid)){
		  sqlWhere +=" and alarm_id = '"+alarmid+"'";
		}
		if(!"".equals(kpicode)){
		  sqlWhere +=" and kfcode = '"+kpicode+"'";
		}
		if(!"".equals(targetname)){
		   String sql3="select code from uf_mainalarm where active =0 and language = "+language+" and type = 'KPI' and text ='"+targetname+"'";

		   rs.execute(sql3);
		   String code1="";
		   if(rs.next()){
		   code1 = Util.null2String(rs.getString("code"));
		   
		   }
		    sqlWhere +=" and kfcode = '"+code1+"'";
		 
		}
		if(!"".equals(alarmtime)){
		  sqlWhere +=" and duration = '"+alarmtime+"'";
		}
		if(!"".equals(alarmlevel)){
		  sqlWhere +=" and R_Level = '"+alarmlevel+"'";
		}
		
		
		  sqlWhere +=" and lxsp = '1'";
	
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"Alarm ID\" column=\"alarm_id\" orderkey=\"alarm_id\"/>"+
			"               <col width=\"10%\" text=\"KPI代码\" column=\"kfcode\" orderkey=\"kfcode\"/>"+
			"               <col width=\"11%\" text=\"指标名称\" column=\"namedesc\" orderkey=\"namedesc\"/>"+
			"               <col width=\"15%\" text=\"Alarm时间段\" column=\"duration\" orderkey=\"duration\"/>"+
			"               <col width=\"12%\" text=\"目标值\" column=\"target_val\" orderkey=\"target_val\"/>"+
			"               <col width=\"12%\" text=\"实际值\" column=\"actual_val\" orderkey=\"actual_val\"/>"+
			"               <col width=\"10%\" text=\"状态\" column=\"approvestatus\" orderkey=\"approvestatus\"/>"+	
			"               <col width=\"10%\" text=\"Alarm级别\" column=\"R_Level\" orderkey=\"R_Level\"/>"+		
			"               <col width=\"10%\" text=\"审批\" column=\"xianshi\" orderkey=\"xianshi\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"  href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"   />"+
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