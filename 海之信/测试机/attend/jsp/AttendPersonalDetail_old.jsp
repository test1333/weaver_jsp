<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
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
	String departmentid_para = Util.null2String(request.getParameter("departmentid")) ;
	//int userid = user.getUID();

    String empid = Util.null2String(request.getParameter("emp_id"));
    String atten_date = Util.null2String(request.getParameter("atten_day"));
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">

					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
					</span>
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
					</span>
					</td>
				</tr>
			</table> 

		</FORM>
		<%
		
		String backfields = " emp_id,atten_day,AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,atten_start_time, "
		                   +" atten_end_time,not_times,late_times,early_leave_times,out_type,card_status,apply_date, "
		                   +" apply_time,case normal_status when 0 then '正常' else '异常' end as normal ";
		String fromSql  = " from uf_all_attend_info ";
		String sqlWhere = " where 1 = 1 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//out.println(sqlWhere);
		String orderby = " atten_day " ;
		String tableString = "";
		String  operateString= "";
        
        //员工姓名
        if(!"".equals(empid)){
			sqlWhere += "and emp_id ="+empid+" ";
		}
        
        //是否正常
		if(!"".equals(atten_date)){
			sqlWhere += " and atten_day ='"+atten_date+"' ";
		}
        
        
		//out.println("select "+ backfields + fromSql +  sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"none\" pagesize=\"15\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"6%\" labelid=\"413\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"6%\" labelid=\"33456\" text=\"考勤日期\" column=\"atten_day\" orderkey=\"atten_day\" />"+
			"		<col width=\"6%\" labelid=\"-11\" text=\"上午开始时间\" column=\"AmBeginTime\" orderkey=\"AmBeginTime\" />"+
			"		<col width=\"6%\" labelid=\"-12\" text=\"上午结束时间\" column=\"AmEndTime\" orderkey=\"AmEndTime\" />"+
			"		<col width=\"6%\" labelid=\"-13\" text=\"下午开始时间\" column=\"PmBeginTime\" orderkey=\"PmBeginTime\"/>"+
			"		<col width=\"6%\" labelid=\"-14\" text=\"下午结束时间\" column=\"PmEndTime\" orderkey=\"PmEndTime\" />"+
			"		<col width=\"6%\" labelid=\"-6\" text=\"上班时间\" column=\"atten_start_time\" orderkey=\"atten_start_time\" />"+
			"		<col width=\"6%\" labelid=\"-7\" text=\"下班时间\" column=\"atten_end_time\" orderkey=\"atten_end_time\" />"+
			"		<col width=\"6%\" labelid=\"1924\" text=\"缺勤(min)\" column=\"not_times\" orderkey=\"not_times\" />"+
			"		<col width=\"6%\" labelid=\"34264\" text=\"迟到(min)\" column=\"late_times\" orderkey=\"late_times\"/>"+
			"		<col width=\"6%\" labelid=\"34265\" text=\"早退(min)\" column=\"early_leave_times\" orderkey=\"early_leave_times\" />"+
			"		<col width=\"6%\" labelid=\"31345\" text=\"外出\" column=\"out_type\" orderkey=\"out_type\"/>"+
			"		<col width=\"6%\" labelid=\"-23\" text=\"忘打卡\" column=\"card_status\" orderkey=\"card_status\"/>"+
			"		<col width=\"6%\" labelid=\"-22\" text=\"补卡日期\" column=\"apply_date\" orderkey=\"apply_date\" />"+
			"		<col width=\"6%\" labelid=\"-24\" text=\"补卡时间\" column=\"apply_time\" orderkey=\"apply_time\"/>"+
			"		<col width=\"6%\" labelid=\"24770\" text=\"是否异常\" column=\"normal\" orderkey=\"normal\"/>"+
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