<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%!
public static int getWeekdayOfDateTime(String datetime){
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
Calendar c = Calendar.getInstance();
try {
c.setTime(df.parse(datetime));
} catch (Exception e) {
e.printStackTrace();
}
int weekday = c.get(Calendar.DAY_OF_WEEK)-1;
return weekday;
}
%>
<%!
public int getMonthDay(String source){
//String source = "2007年12月";
int count=30;
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
try {
Date date = format.parse(source);
Calendar calendar = new GregorianCalendar();
calendar.setTime(date);
count=calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
}catch (Exception e) {
e.printStackTrace();
}
return count;
}
%>
<%
String year_name = Util.null2String(request.getParameter("year_name"));
String month_name = Util.null2String(request.getParameter("month_name"));
String recipient = Util.null2String(request.getParameter("recipient"));
Calendar cal = Calendar.getInstance();
if (!"".equals(year_name) && !"".equals(month_name)) {
cal.set(Integer.parseInt(year_name),Integer.parseInt(month_name)-1, 1);
}else{
cal.set(Calendar.DAY_OF_MONTH, 1);
}
if("".equals(year_name))   year_name  = Integer.toString(cal.get(Calendar.YEAR));
if("".equals(month_name))   month_name  = Integer.toString(cal.get(Calendar.MONTH)+1);

%>
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
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:doEdit(this),_TOP} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
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
				<wea:item>
				<select id="year_name" name="year_name">
					<option value=""></option>
					<option value="2014" <%if ("2014".equals(year_name)) {%>selected<%}%>>2014</option>
					<option value="2015" <%if ("2015".equals(year_name)) {%>selected<%}%>>2015</option>
					<option value="2016" <%if ("2016".equals(year_name)) {%>selected<%}%>>2016</option>
					<option value="2017" <%if ("2017".equals(year_name)) {%>selected<%}%>>2017</option>
					<option value="2018" <%if ("2018".equals(year_name)) {%>selected<%}%>>2018</option>
					<option value="2019" <%if ("2019".equals(year_name)) {%>selected<%}%>>2019</option>
				</select>
				</wea:item>
				<wea:item>年</wea:item>
				<wea:item>
				<select id="month_name" name="month_name">
					<option value=""></option>
					<option value="1" <%if ("1".equals(month_name)) {%>selected<%}%>>01</option>
					<option value="2" <%if ("2".equals(month_name)) {%>selected<%}%>>02</option>
					<option value="3" <%if ("3".equals(month_name)) {%>selected<%}%>>03</option>
					<option value="4" <%if ("4".equals(month_name)) {%>selected<%}%>>04</option>
					<option value="5" <%if ("5".equals(month_name)) {%>selected<%}%>>05</option>
					<option value="6" <%if ("6".equals(month_name)) {%>selected<%}%>>06</option>
					<option value="7" <%if ("7".equals(month_name)) {%>selected<%}%>>07</option>
					<option value="8" <%if ("8".equals(month_name)) {%>selected<%}%>>08</option>
					<option value="9" <%if ("9".equals(month_name)) {%>selected<%}%>>09</option>
					<option value="10" <%if ("10".equals(month_name)) {%>selected<%}%>>10</option>
					<option value="11" <%if ("11".equals(month_name)) {%>selected<%}%>>11</option>
					<option value="12" <%if ("12".equals(month_name)) {%>selected<%}%>>12</option>
				</select>
				</wea:item>
				<wea:item>月</wea:item>
				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
			
			<TABLE width="99%" style="background:white;margin-left: 0.2%;margin-top: -1px;font-size: 9pt;align: center;" border="1px" bordercolor="#DADADA" cellspacing="0px">
				<tr>
					<td valign="top">
						<TABLE width="100%" >
							<colgroup>
							<col width="12%"></col>
							<col width="12%"></col>
							<col width="12%"></col>
							<col width="12%"></col>
							<col width="12%"></col>
							<col width="12%"></col>
							<col width="12%"></col>
							<col width="12%"></col>
							</colgroup>
							<TBODY>
							<tr class="ListStyle" align="center" style="height: 20px;background-color: #DDD9C4;">
									<td>姓名</td>
									<td>应出勤</td>
									<td>正常出勤</td>
									<td>调休假</td>
									<td>病假</td>
									<td>事假</td>
									<td>其他假</td>
									<td>异常</td>
							</tr>
								<%
								String tmp_startdate = year_name + "-" + (month_name.length()==1?"0"+(Integer.parseInt(month_name)-1):(Integer.parseInt(month_name)-1)) + "-"+ "26";
								String tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25";
								String sql = " select emp_id,should_attend,normal_attend,adjusted_leave,sick_leave,casual_leave,other_leave,different  from  sh_bonus_report ";

							// 	if(!"".equals(recipient)){
							// 	    sql = sql + " and emp_id = "+recipient;
							// }
								rs.executeSql(sql);
								new BaseBean().writeLog("SH_attend_sql___________" + sql);
								while(rs.next()) {
								String emp_id = rs.getString("emp_id");
								int should_attend = rs.getInt("should_attend");
								int normal_attend = rs.getInt("normal_attend");
								int adjusted_leave = rs.getInt("adjusted_leave");
								int sick_leave = rs.getInt("sick_leave");
								int casual_leave = rs.getInt("casual_leave");
								int other_leave = rs.getInt("other_leave");
								int different = rs.getInt("different");

								%>
								<tr class="ListStyle" align="center">
									<td><a href=javascript:this.openFullWindowForXtable('/seahonor/jsp/BonusPersonalDetail.jsp?recipient=<%=emp_id%>')><%=ResourceComInfo.getResourcename(emp_id)%></a></td>
									<td><%=should_attend%></td>
									<td><%=normal_attend%></td>
									<td><%=adjusted_leave%></td>
									<td><%=sick_leave%></td>
									<td><%=casual_leave%></td>
									<td><%=other_leave%></td>
									<td><%=different%></td>
							</tr>
								<%
								}
								
								%>
							</tr>
						</TBODY>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</FORM>
	<script type="text/javascript">
		function onBtnSearchClick() {
			weaver.submit();
		}
		// function setCheckbox(chkObj) {
			// 	if (chkObj.checked == true) {
				// 		chkObj.value = 1;
			// 	} else {
				// 		chkObj.value = 0;
			// 	}
		// }
	function openFullWindowForXtable(url){
	          var redirectUrl = url ;
	          var width = screen.width ;
	           var height = screen.height ;
	           var szFeatures = "top=100," ;
	           szFeatures +="left=400," ;
	           szFeatures +="width="+width+"," ;
	           szFeatures +="height="+height+"," ;
	           szFeatures +="directories=no," ;
	           szFeatures +="status=yes," ;
	          szFeatures +="menubar=no," ;
	           szFeatures +="scrollbars=yes," ;
	           szFeatures +="resizable=yes" ; //channelmode
	           window.open(redirectUrl,"",szFeatures) ;
	          }
	
	</script>
	<Script language=javascript>
		function doEdit(obj) {
			weaver.submit();
			obj.disabled = true;
		}
	</script>
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>