<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
String year_name = Util.null2String(request.getParameter("year_name"));
String month_name = Util.null2String(request.getParameter("month_name"));
String recipient = Util.null2String(request.getParameter("recipient"));
String empid = Util.null2String(request.getParameter("emp_id"));
String tmp_startdate = "";
String tmp_enddate = "";
Calendar cal = Calendar.getInstance();
if (!"".equals(year_name) && !"".equals(month_name)) {
cal.set(Integer.parseInt(year_name),Integer.parseInt(month_name)-1, 1);
}else{
cal.set(Calendar.DAY_OF_MONTH, 1);
}
if("".equals(year_name))   year_name  = Integer.toString(cal.get(Calendar.YEAR));
if("".equals(month_name))   month_name  = Integer.toString(cal.get(Calendar.MONTH)+1);
String bef_month = Integer.toString(Integer.parseInt(month_name)-1);
String bef_year = Integer.toString(Integer.parseInt(year_name)-1);
//out.println("bef_month="+bef_month);
if("0".equals(bef_month)){
bef_month = "12";
tmp_startdate = bef_year + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25";
}
else{
tmp_startdate = year_name + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25";
}
%>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<style type="text/css">
		TD.BodyStyle {
		color: #000;
		padding: 10 5 10 5;
		background-color: #9AB7ED;
		vertical-align: middle;
		overflow:visible;
		text-align: center
		}
		</style>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
	+ SystemEnv.getHtmlLabelName(480, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(18599, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(352, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
			<%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<!-- <div id="dialog">
				<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/> 定制列-->
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch">
							<%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
						</span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
						</span>
					</td>
				</tr>
			</table>
			<div>
				<table width="100%" class="ListStyle" style="font-size: 8pt">
					<colgroup>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="80%"></col>
					</colgroup>
					
					<tr>
						<td style="color:white;background: #9AB7ED;border-left: 1px solid #F2F2F2;border-right: 1px solid #F2F2F2;border-top: 1px solid #F2F2F2;font-weight: normal;text-align: center"><%=year_name%> 年</td>
						<td style="color:white;background: #9AB7ED;border-left: 1px solid #F2F2F2;border-right: 1px solid #F2F2F2;border-top: 1px solid #F2F2F2;font-weight: normal;text-align: center"><%=month_name%> 月</td>
						<td style="color:white;background: #9AB7ED;border-left: 1px solid #F2F2F2;border-right: 1px solid #F2F2F2;border-top: 1px solid #F2F2F2;font-weight: normal;text-align: center">当月出勤福利明细表 <font color="red">[<%=tmp_startdate%> - <%=tmp_enddate%>]</font></td>
					</tr>
				</table>
			</div>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient %>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
				</brow:browser>
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
		String backfields = " emp_id,atten_day,transport,meal,case status when 0 then '正常' when 1 then '调休假' when 2 then '病假' when 3 then '事假' when 4 then '其他假' when 9 then '旷工' end  as status ";
		String fromSql  = " from sh_bonus_detail ";
		String sqlWhere = " where atten_day between '"+tmp_startdate+"' and '"+tmp_enddate+"' ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " emp_id,atten_day " ;
		String tableString = "";
		String operateString= "";
		
		//员工姓名
		if(!"".equals(recipient)){
		sqlWhere += "and emp_id ="+recipient+" ";
		}
		//员工姓名
		if(!"".equals(recipient)){
		sqlWhere += "and emp_id ="+recipient+" ";
		}
		//员工姓名
		if(!"".equals(empid)){
		sqlWhere += "and emp_id ="+empid+" ";
		}
		// //考勤部门
		// if(!"".equals(departmentidpar)){
		// 	sqlWhere += " and emp_id in (select id from HrmResource where departmentid = "+departmentidpar+") ";
		// }
		
		//out.println("select "+ backfields + fromSql +  sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
			"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
			operateString +
			"			<head>";
				tableString+="<col width=\"20%\" labelid=\"413\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
				"		<col width=\"20%\" labelid=\"25733\" text=\"日期\" column=\"atten_day\" orderkey=\"atten_day\" />"+
				"		<col width=\"20%\" labelid=\"1895\" text=\"车贴\" column=\"transport\" orderkey=\"transport\" />"+
				"		<col width=\"20%\" labelid=\"1896\" text=\"饭贴\" column=\"meal\" orderkey=\"meal\" />"+
				"		<col width=\"20%\" labelid=\"622\" text=\"情况\" column=\"status\" orderkey=\"status\"/>"+
			"			</head>"+
		" </table>";
		%>
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
		<script type="text/javascript">
			function onBtnSearchClick() {
				weaver.submit();
			}
			function setCheckbox(chkObj) {
				if (chkObj.checked == true) {
					chkObj.value = 1;
				} else {
					chkObj.value = 0;
				}
			}
		</script>
		<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
		<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
	</BODY>
</HTML>