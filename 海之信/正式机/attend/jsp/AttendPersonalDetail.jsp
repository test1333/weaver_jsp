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
	int userid = user.getUID();
	
	String empid = Util.null2String(request.getParameter("emp_id"));
	String atten_date = Util.null2String(request.getParameter("atten_day"));
	
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String departmentidpar = Util.null2String(request.getParameter("departmentid"));
	String isNormal = Util.null2String(request.getParameter("isNormal"));
	String isEffective = Util.null2String(request.getParameter("isEffective"));
	if("".equals(isEffective)) isEffective = "0";
	//String isCard = Util.null2String(request.getParameter("isCard"));
	
	String detail_pageId = "attend_info_detail";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=detail_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
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
		                   +" atten_end_time,isnull(late_times,0)+isnull(early_leave_times,0) as not_times,late_times,early_leave_times,out_type,card_status,apply_date, "
		                   +" apply_time,case normal_status when 0 then '正常' else '异常' end as normal, "
		                   +" leave_type,over_start_time,over_end_time,leave_start_time,leave_end_time, "
						   +" (select holiname from uf_holiday_table where id=(select applyholidays from uf_holiday_apply where id=leave_type)) as holiday,"
		                   +" case is_over_day when 1 then '跨天' else '不跨天' end as overDay, "
		                   +" case isEffective when 1 then '无效' else '有效' end as isEffective ";
		String fromSql  = " from uf_all_attend_info ";
		String sqlWhere = " where isnull(isEffective,0) = "+isEffective;
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " atten_day,emp_id " ;
		String tableString = "";
		String  operateString= "";
        
        //员工姓名
        if(!"".equals(empid)){
			sqlWhere += "and emp_id ="+empid+" ";
		}
		
		if(!"".equals(atten_date)){
			sqlWhere += " and atten_day ='"+atten_date+"' ";
		}
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(detail_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+detail_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"4%\" labelid=\"25034\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"4%\" labelid=\"33456\" text=\"考勤日期\" column=\"atten_day\" orderkey=\"atten_day\" />"+
			"		<col width=\"4%\" labelid=\"-9321\" text=\"上午开始时间\" column=\"AmBeginTime\" orderkey=\"AmBeginTime\" />"+
			"		<col width=\"4%\" labelid=\"-9320\" text=\"上午结束时间\" column=\"AmEndTime\" orderkey=\"AmEndTime\" />"+
			"		<col width=\"4%\" labelid=\"-9319\" text=\"下午开始时间\" column=\"PmBeginTime\" orderkey=\"PmBeginTime\"/>"+
			"		<col width=\"4%\" labelid=\"-9318\" text=\"下午结束时间\" column=\"PmEndTime\" orderkey=\"PmEndTime\" />"+
			"		<col width=\"4%\" labelid=\"-9222\" text=\"上班时间\" column=\"atten_start_time\" orderkey=\"atten_start_time\" />"+
			"		<col width=\"4%\" labelid=\"-9221\" text=\"下班时间\" column=\"atten_end_time\" orderkey=\"atten_end_time\" />"+
			"		<col width=\"4%\" labelid=\"-9295\" text=\"合计(分钟)\" column=\"not_times\" orderkey=\"not_times\" />"+
			"		<col width=\"4%\" labelid=\"-9282\" text=\"迟到(分钟)\" column=\"late_times\" orderkey=\"late_times\"/>"+
			"		<col width=\"4%\" labelid=\"-9281\" text=\"早退(分钟)\" column=\"early_leave_times\" orderkey=\"early_leave_times\" />"+
			"		<col width=\"4%\" labelid=\"31345\" text=\"外出\" column=\"out_type\" orderkey=\"out_type\"/>"+
			"		<col width=\"4%\" labelid=\"-9231\" text=\"忘打卡\" column=\"card_status\" orderkey=\"card_status\"/>"+
			"		<col width=\"4%\" labelid=\"-9280\" text=\"补卡日期\" column=\"apply_date\" orderkey=\"apply_date\" />"+
			"		<col width=\"4%\" labelid=\"-9279\" text=\"补卡时间\" column=\"apply_time\" orderkey=\"apply_time\"/>"+
			"		<col width=\"4%\" labelid=\"670\" text=\"请假\" column=\"holiday\" orderkey=\"holiday\"/>"+
			"		<col width=\"4%\" labelid=\"-9277\" text=\"请假开始时间\" column=\"leave_start_time\" orderkey=\"leave_start_time\"/>"+
			"		<col width=\"4%\" labelid=\"-9276\" text=\"请假结束时间\" column=\"leave_end_time\" orderkey=\"leave_end_time\"/>"+
			"		<col width=\"4%\" labelid=\"-9275\" text=\"加班开始时间\" column=\"over_start_time\" orderkey=\"over_start_time\"/>"+
			"		<col width=\"4%\" labelid=\"-9274\" text=\"加班结束时间\" column=\"over_end_time\" orderkey=\"over_end_time\"/>"+
			"		<col width=\"4%\" labelid=\"-9273\" text=\"是否跨天\" column=\"overDay\" orderkey=\"overDay\"/>"+
			"		<col width=\"4%\" labelid=\"15591\" text=\"是否有效\" column=\"isEffective\" orderkey=\"isEffective\"/>"+
			"		<col width=\"4%\" labelid=\"24770\" text=\"是否异常\" column=\"normal\" orderkey=\"normal\"/>"+
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