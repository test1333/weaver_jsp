<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
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
    
    String year_name = Util.null2String(request.getParameter("year_name"));
	String month_name = Util.null2String(request.getParameter("month_name"));

	int userid = user.getUID();
	String resourceid = Util.null2String(request.getParameter("resourceid"));

	Calendar cal = Calendar.getInstance();
	if (!"".equals(year_name) && !"".equals(month_name)) {
	cal.set(Integer.parseInt(year_name),Integer.parseInt(month_name)-1, 1);
	}else{
	cal.set(Calendar.DAY_OF_MONTH, 1);
	}
	out.println(1234567890);
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
				<tr>
					<td>查询年月</td>
						<td class=field><select id="year_name" name="year_name">
							<option value=""></option>
							<option value="2014" <%if ("2014".equals(year_name)) {%>selected<%}%>>2014</option>
							<option value="2015" <%if ("2015".equals(year_name)) {%>selected<%}%>>2015</option>
							<option value="2016" <%if ("2016".equals(year_name)) {%>selected<%}%>>2016</option>
							<option value="2017" <%if ("2017".equals(year_name)) {%>selected<%}%>>2017</option>
							<option value="2018" <%if ("2018".equals(year_name)) {%>selected<%}%>>2018</option>
							<option value="2019" <%if ("2019".equals(year_name)) {%>selected<%}%>>2019</option>
						</select></td>
						<td>年</td>
						<td class=field><select id="month_name" name="month_name">
							<option value=""></option>
							<option value="01" <%if ("01".equals(month_name)) {%>selected<%}%>>01</option>
							<option value="02" <%if ("02".equals(month_name)) {%>selected<%}%>>02</option>
							<option value="03" <%if ("03".equals(month_name)) {%>selected<%}%>>03</option>
							<option value="04" <%if ("04".equals(month_name)) {%>selected<%}%>>04</option>
							<option value="05" <%if ("05".equals(month_name)) {%>selected<%}%>>05</option>
							<option value="06" <%if ("06".equals(month_name)) {%>selected<%}%>>06</option>
							<option value="07" <%if ("07".equals(month_name)) {%>selected<%}%>>07</option>
							<option value="08" <%if ("08".equals(month_name)) {%>selected<%}%>>08</option>
							<option value="09" <%if ("09".equals(month_name)) {%>selected<%}%>>09</option>
							<option value="10" <%if ("10".equals(month_name)) {%>selected<%}%>>10</option>
							<option value="11" <%if ("11".equals(month_name)) {%>selected<%}%>>11</option>
							<option value="12" <%if ("12".equals(month_name)) {%>selected<%}%>>12</option>
						</select></td>
						<td>月</td>
				</tr>
			</table>
            <%
                out.println(456);
            %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="resourceid" browserValue="<%=resourceid %>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%>">
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
		out.println(123);
		String tmp_startdate = year_name + "-" + (month_name.length()==1?"0"+(Integer.parseInt(month_name)-1):(Integer.parseInt(month_name)-1)) + "-"+ "26";
		String tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25";
        
	    
	    out.println(789);
        
        String backfields = " emp_id ";
		//String backfields = " emp_id,should_attend,normal_attend,adjusted_leave,sick_leave,casual_leave,other_leave,different ";
		String fromSql  = " from sh_bonus_report ";
		String sqlWhere = " where 1 = 1 ";
		out.println("select "+ backfields + fromSql + sqlWhere);
		out.println(sqlWhere);
		String orderby = " emp_id " ;
		String tableString = "";
		String operateString= "";

		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
        /*
	    tableString =" <table tabletype=\"none\" pagesize=\"15\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="	<col width=\"8%\" labelid=\"1933\" text=\"工号\" column=\"atten_day\" orderkey=\"atten_day\" />"+
		    "      <col width=\"8%\" labelid=\"25034\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"8%\" labelid=\"34082\" text=\"应出勤\" column=\"should_attend\" orderkey=\"should_attend\" />"+
			"		<col width=\"8%\" labelid=\"34091\" text=\"实出勤\" column=\"normal_attend\" orderkey=\"normal_attend\" />"+
			"		<col width=\"8%\" labelid=\"31297\" text=\"调休假\" column=\"adjusted_leave\" orderkey=\"adjusted_leave\"/>"+
			"		<col width=\"8%\" labelid=\"1919\" text=\"病假\" column=\"sick_leave\" orderkey=\"sick_leave\" />"+
			"		<col width=\"8%\" labelid=\"1920\" text=\"事假\" column=\"casual_leave\" orderkey=\"casual_leave\" />"+
			"		<col width=\"8%\" labelid=\"20083\" text=\"其他假\" column=\"other_leave\" orderkey=\"other_leave\"/>"+
			"		<col width=\"8%\" labelid=\"22516\" text=\"差异\" column=\"different\" orderkey=\"different\" />"+
			"		<col width=\"8%\" labelid=\"1896\" text=\"饭贴\" column=\"different\" orderkey=\"different\" />"+
			"		<col width=\"8%\" labelid=\"1895\" text=\"车贴\" column=\"different\" orderkey=\"different\"/>"+
			"		<col width=\"8%\" labelid=\"19266\" text=\"通讯费\" column=\"different\" orderkey=\"different\" />"+
		"			</head>"+
	" </table>"; */

	tableString =" <table tabletype=\"none\" pagesize=\"15\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
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
			report.submit();
		}
		// function setCheckbox(chkObj) {
		// 	if (chkObj.checked == true) {
		// 		chkObj.value = 1;
		// 	} else {
		// 		chkObj.value = 0;
		// 	}
		// }
	</script>
<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>