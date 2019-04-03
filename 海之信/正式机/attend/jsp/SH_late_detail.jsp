<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
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
	String emp_id = Util.null2String(request.getParameter("emp_id"));
	String countdate = Util.null2String(request.getParameter("countdate"));
	String startDate = Util.null2String(request.getParameter("startDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		
		<%
		
		String backfields = " emp_id,workcode,atten_day,isnull(late_times,0)+ISNULL (early_leave_times,0) as not_times ";
		String fromSql  = " from uf_all_attend_info ";
		String sqlWhere = " emp_id="+emp_id+" and (isnull(late_times,0)+ISNULL (early_leave_times,0))>0 and atten_day between '"+startDate+"' and '"+endDate+"' and isnull(isEffective,0)=0 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " emp_id,atten_day " ;
		String tableString = "";
		String operateString= "";
        
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"23%\" labelid=\"99\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"24%\" labelid=\"15502\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
			"		<col width=\"24%\" labelid=\"-10967\" text=\"考勤日期\" column=\"atten_day\" orderkey=\"atten_day\" />"+
			"		<col width=\"24%\" labelid=\"-10967\" text=\"迟到/早退(分钟)\" column=\"not_times\" orderkey=\"not_times\" />"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>