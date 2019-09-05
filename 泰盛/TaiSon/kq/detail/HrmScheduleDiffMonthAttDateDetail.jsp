<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!-- Added by wcd 2015-05-18 [月考勤报表明细] -->
<%@page import="weaver.hrm.attendance.domain.HrmMFScheduleDiff"%>
<%@ page import="weaver.general.Util,weaver.hrm.common.*,weaver.conn.*" %>
<%@ page import="weaver.file.*,net.sf.json.*,java.util.*,java.text.*,weaver.common.DataBook" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="strUtil" class="weaver.common.StringUtil" scope="page" />
<jsp:useBean id="dateUtil" class="weaver.common.DateUtil" scope="page" />
<jsp:useBean id="enumUtil" class="weaver.common.EnumUtil" scope="page" />
<jsp:useBean id="detachCommonInfo" class="weaver.hrm.moduledetach.ManageDetachComInfo" scope="page" />
<jsp:useBean id="diffUtil" class="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="monthAttManager" class="weaver.hrm.attendance.manager.HrmScheduleDiffMonthAttManager" scope="page" />
<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage()) +":" + SystemEnv.getHtmlLabelName(82801,user.getLanguage()) ;
	String needfav ="1";
	String needhelp ="";
	
	String isDialog = strUtil.vString(request.getParameter("isdialog"),"1");
	String curDate = strUtil.vString(request.getParameter("curDate"));
	String resourceId = strUtil.vString(request.getParameter("resourceId"));
	diffUtil.setUser(user);
	monthAttManager.setUser(user);
	int subCompanyId = strUtil.parseToInt(resourceComInfo.getSubCompanyID(resourceId));
	Map timeMap = diffUtil.getOnDutyAndOffDutyTimeMap(curDate, subCompanyId);
	
	
	List fList = monthAttManager.getScheduleList(curDate, curDate, resourceId);
	boolean showFList = fList!=null && fList.size() > 0;
	String layoutAtt = "{'cols':'6','cws':'15%,13%,13%,24%,15%,15%'}";
	String groupAtt = showFList ? "{'groupDisplay':''}" : "{'groupDisplay':'none'}";
	Map map = null;
%>
<html>
	<head>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
		<script type="text/javascript">
			var dialog = parent.parent.getDialog(parent);
			
			function exportExcel(){
				document.getElementById("excels").src = "/TaiSon/kq/kqReportExcel.jsp?cmd=HrmScheduleDiffMonthAttDateDetail&tnum=15880,17463&fromDate=<%=curDate%>&toDate=<%=curDate%>&resourceId=<%=resourceId%>";
			}
		</script>
	</head>
	<body>
		<%if("1".equals(isDialog)){ %>
			<div class="zDialog_div_content">
		<%} %>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{"+SystemEnv.getHtmlLabelName(28343,user.getLanguage())+",javascript:exportExcel(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td></td>
				<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" class="e8_btn_top" onclick="exportExcel();" value="<%=SystemEnv.getHtmlLabelName(28343,user.getLanguage())%>"></input>
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</td>
			</tr>
		</table>
		<wea:layout type="table" needImportDefaultJsAndCss="false" attributes='<%=layoutAtt%>'>
			<wea:group context='<%=SystemEnv.getHtmlLabelNames("15880,17463",user.getLanguage())%>' attributes="<%=groupAtt%>">
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(97,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(125799,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(20035,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(20039,user.getLanguage())%></wea:item>
				<%
				String sql ="select a.id,b.lastname as resourceName,c.departmentName,atten_day as signDate,am_begin_time||'-'||pm_end_time as scheduleName,atten_start_time as signInTime,atten_end_time as signOutTime from uf_all_atten_info a ,hrmresource b,hrmdepartment c where a.emp_id=b.id and b.departmentid=c.id and a.emp_id="+resourceId+" and a.atten_day='"+curDate+"'";
				rs.execute(sql);
				while(rs.next()){
				%>
				<wea:item><%=strUtil.vString(rs.getString("departmentName"))%></wea:item>
				<wea:item><%=strUtil.vString(rs.getString("resourceName"))%></wea:item>
				<wea:item><%=strUtil.vString(rs.getString("signDate"))%></wea:item>
				<wea:item><%=strUtil.vString(rs.getString("scheduleName"))%></wea:item>
				<wea:item><%=strUtil.vString(rs.getString("signInTime"))%></wea:item>
				<wea:item><%=strUtil.vString(rs.getString("signOutTime"))%></wea:item>
				<%
					}
				%>
			</wea:group>
		</wea:layout>
		<%if(showFList){%>
		<wea:layout type="table" needImportDefaultJsAndCss="false" attributes="{'cols':'7','cws':'20%,12%,15%,15%,12%,14%,12%'}">
			<wea:group context='<%=SystemEnv.getHtmlLabelNames("15880,18015",user.getLanguage())%>'>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(1334,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(742,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(743,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(15378,user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(670,user.getLanguage())+"/"+SystemEnv.getHtmlLabelNames("31345,496",user.getLanguage())%></wea:item>
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(63,user.getLanguage())%></wea:item>
				<%
					for(int i=0; i<fList.size(); i++){
						map = (Map)fList.get(i);
				%>
				<wea:item><%=strUtil.vString(map.get("reqLinkName"))%></wea:item>
				<wea:item><%=strUtil.vString(map.get("resourceName"))%></wea:item>
				<wea:item><%=strUtil.vString(map.get("startTime"))%></wea:item>
				<wea:item><%=strUtil.vString(map.get("endTime"))%></wea:item>
				<wea:item><%=strUtil.vString(map.get("status"))%></wea:item>
				<wea:item><%=strUtil.vString(map.get("days"))%></wea:item>
				<wea:item><%=strUtil.vString(map.get("dType"))%></wea:item>
				<%}%>
			</wea:group>
		</wea:layout>
		<%}%>
	<%if("1".equals(isDialog)){ %>
		</div>
		<div id="zDialog_div_bottom" class="zDialog_div_bottom">
			<wea:layout type="2col">
				<wea:group context="">
					<wea:item type="toolbar">
						<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" class="e8_btn_cancel" onclick="dialog.close();">
					</wea:item>
				</wea:group>
			</wea:layout>
		</div>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				resizeDialog(document);
			});
		</script>
	<%} %>
	<iframe name="excels" id="excels" src="" style="display:none" ></iframe>
	</body>
</html>



