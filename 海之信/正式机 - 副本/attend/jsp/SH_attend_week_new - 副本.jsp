<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<style>
.sp1{
	display:inline-block;
	width:50%;
	height:20px;
	background:#92D050;
	text-align:center;
	color:white;
	float: left;
    line-height: 20px;
    vertical-align: middle;
}

.sp2{
	display:inline-block;
	width:50%;
	height:20px;
	background:#538DD5;
	text-align:center;
}

.sp3{
	display:inline-block;
	width:50%;
	height:20px;
	background:#FF0000;
	text-align:center;
}

</style>

<%!
public String getEmpAttenInfo(String emp_id,String atten_day){
StringBuffer buff = new StringBuffer();
RecordSet recordSet = new RecordSet();
	buff.append("<p style=\"width:100%;\">");
String sql = " select atten_start_time,atten_end_time,leave_type,late_times,early_leave_times from uf_all_attend_info "
+" where emp_id = "+emp_id+" and  atten_day = '"+atten_day+"' ";
recordSet.executeSql(sql);
//String temp1 = "<span style=\"background:#92D050 ; width:50%;color:white;height: 20px;\">  ";
String temp1 = "<span class=\"sp1\">  ";
	String temp2 = "<span class=\"sp2\" >  ";
		String temp3 = "<span class=\"sp3\" > ";
			if(recordSet.next()) {
			String start_time = Util.null2String(recordSet.getString("atten_start_time"));
			String end_time = Util.null2String(recordSet.getString("atten_end_time"));
			String leave_type = Util.null2String(recordSet.getString("leave_type"));
			String late_times = Util.null2String(recordSet.getString("late_times"));
			//String tmp_late = late_times.substring(0,late_times.indexOf("."));
			String tmp_late = late_times;
			String early_leave_times = Util.null2String(recordSet.getString("early_leave_times"));
			//String tmp_early = early_leave_times.substring(0,early_leave_times.indexOf("."));
			String tmp_early = early_leave_times;
			
			if(!"".equals(start_time)){
			if(tmp_late.compareTo("0")>0){
			buff.append(temp1+tmp_late);
			}else{
			buff.append(temp1);
			}
			
			}else if("0".equals(leave_type)){
			buff.append(temp3);
			}else{
			buff.append(temp2);
			}
		buff.append("</span>");
		
		if(!"".equals(end_time)){
			if(tmp_early.compareTo("0")>0){
				buff.append(temp1+tmp_early);
			}else{
				buff.append(temp1);
			}
		
		}else if("0".equals(leave_type)){
			buff.append(temp2);
		}else{
			buff.append(temp3);
		}
	buff.append("</span>");
	}
	buff.append("</p>");
	//if(buff.length() < 1)  buff.append("<td>&nbsp;test</td>");
	//System.out.println(emp_id + " : " + atten_day + " = " +buff.toString());
	return buff.toString();
	//}
	}
	%>
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
	String tmp_firstdate = "";
	String tmp_month = "";
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
        tmp_firstdate = bef_year + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
        tmp_month = bef_year + "-" + (bef_month.length()==1?"0"+bef_month:bef_month);
    }
    else{
        tmp_firstdate = year_name + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
        tmp_month = year_name + "-" + (bef_month.length()==1?"0"+bef_month:bef_month);
    }

	String emp_id = "";
	String dep_name = "";
	String emp_name = "";
	int userid = user.getUID();
	if(userid != 1){
        if("".equals(recipient))   recipient  = Integer.toString(userid);
    }
	//out.println("year_name="+year_name);
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
			<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
			<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
			<%
			RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:doEdit(this),_TOP} ";
			RCMenuHeight += RCMenuHeightStep;
			%>
			<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
			<FORM id=weaver name=weaver method=post action="" >
			<div>
			<TABLE width="80%" style="margin-left: 10%;margin-top: 1px;margin-right: 10%;font-size: 9pt;" border="0px" bordercolor="#DADADA" cellspacing="1px">
			    <colgroup>
			    <col width="10%"></col>
			    <col width="5%"></col>
			    <col width="10%"></col>
			    <col width="5%"></col>
				<col width="10%"></col>
			    <col width="10%"></col>
			    <col width="10%"></col>
			    <col width="40%"></col>
			    </colgroup>
				
				<tr>
					<td class=Field>
						<select id="year_name" name="year_name">
					    <option value=""></option>
					    <option value="2014" <%if ("2014".equals(year_name)) {%>selected<%}%>>2014</option>
					    <option value="2015" <%if ("2015".equals(year_name)) {%>selected<%}%>>2015</option>
					    <option value="2016" <%if ("2016".equals(year_name)) {%>selected<%}%>>2016</option>
					    <option value="2017" <%if ("2017".equals(year_name)) {%>selected<%}%>>2017</option>
					    <option value="2018" <%if ("2018".equals(year_name)) {%>selected<%}%>>2018</option>
					    <option value="2019" <%if ("2019".equals(year_name)) {%>selected<%}%>>2019</option>
				        </select>
					</td>
					<td class=Field>年</td>
					<td><select id="month_name" name="month_name">
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
				    </select></td>
				    <td class=Field>月</td>
					<td class=Field>员工姓名</td>
					<td class=Field>
						<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient %>"
							browserOnClick=""
							browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
						</brow:browser>
					</td>
					<td class=Field></td>
					<td class=Field><font color="red">当月考勤视图</font></td>
				</tr>
			</table>
			</div>
				<TABLE width="80%" rules="all" style="background:white;margin-left: 10%;margin-top: 5px;margin-right: 10%;font-size: 9pt;border-collapse:collapse;" border="1px" bordercolor="#D3D3D3" cellspacing="1px">
								<colgroup>
								<col width="11%"></col>
								<col width="11%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								<col width="5.5%"></col>
								</colgroup>
								<TBODY>
									<%
									String sql = " select id,lastname,(select departmentname from HrmDepartment where id = departmentid) "
									+" as dep_name from HrmResource where id = "+recipient+" ";
									rs.executeSql(sql);
									//new BaseBean().writeLog("SH_attend_sql___________" + sql);
									while(rs.next()) {
									emp_id = Util.null2String(rs.getString("id"));
									dep_name = Util.null2String(rs.getString("dep_name"));
									emp_name = Util.null2String(rs.getString("lastname"));
									}
									%>
									<tr class="ListStyle" align="center" style="color:#FFF;height: 60px;background-color: #008DF6;">
										<td>部门</td>
										<td>姓名</td>
										<td colspan="2">周一</td>
										<td colspan="2">周二</td>
										<td colspan="2">周三</td>
										<td colspan="2">周四</td>
										<td colspan="2">周五</td>
										<td colspan="2">周六</td>
										<td colspan="2">周日</td>
									</tr>
									<tr align="center" style="height: 40px;">
										<%
										
										int maxDay = getMonthDay(tmp_month);
										int other_week = getWeekdayOfDateTime(tmp_firstdate);
										int firstday = 26;
										if (other_week == 0){
										other_week = 7;
										}
										//out.println("tmp_month="+tmp_month+"|"+"tmp_firstdate="+tmp_firstdate);
										//out.println("other_week="+other_week);
										//out.println("maxDay="+maxDay);
										%>
										<td rowspan="6"><%=dep_name%></td>
										<td rowspan="6"><%=emp_name%></td>
										<%
										for (int j = 1; j <= 40; j++) {
										if (firstday !=26){
										if(firstday>26){
											String tmp_firstday = String.format("%02d",firstday);
											String tmp_date = tmp_month + "-"+ tmp_firstday;
											out.println("<td colspan=\"2\" style=\"height: 20px;\"><a href=javascript:this.addFieldTrigger("+emp_id+",'"+tmp_date+"')><font color=\"#948787\">"+firstday+"日</a></font><br/>");
											//out.println("tmp_date="+tmp_date);
											out.println(getEmpAttenInfo(recipient,tmp_date));
										out.println("</td>");
										}else{
											String tmp_firstday = String.format("%02d",firstday);
											String tmp_date = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ tmp_firstday;
											out.println("<td colspan=\"2\" style=\"height: 20px;\"><a href=javascript:this.addFieldTrigger("+emp_id+",'"+tmp_date+"')>"+firstday+"日</a><br/>");
											//out.println("tmp_date="+tmp_date);
											out.println(getEmpAttenInfo(recipient,tmp_date));
											out.println("</td>");
										}
										if(firstday==25) break;
										if(firstday == maxDay) firstday = 1;
										else firstday ++;
										}else if (firstday ==26){
										if (j == other_week){
											String tmp_firstday = String.format("%02d",firstday);
											String tmp_date = tmp_month + "-"+ tmp_firstday;
											out.println("<td colspan=\"2\" style=\"height: 20px;\"><a href=javascript:this.addFieldTrigger("+emp_id+",'"+tmp_date+"')><font color=\"#948787\">"+firstday+"日</a></font><br/>");
											//out.println("tmp_date="+tmp_date);
											out.println(getEmpAttenInfo(recipient,tmp_date));
										out.println("</td>");
										firstday ++;
										}else{
											out.println("<td colspan=\"2\" style=\"height: 20px;\"></td>");
										}
										
										}
										if(j%7 == 0){
										%>
									</tr><tr align="center" style="height: 40px;">
									<%
									}
									}
									
						%>
					</tr>
				</TBODY>
			</TABLE>
		</FORM>
		<script type="text/javascript">
			function onBtnSearchClick() {
				weaver.submit();
			}
			//function setCheckbox(chkObj) {
				//if (chkObj.checked == true) {
					//chkObj.value = 1;
				//} else {
					//chkObj.value = 0;
				//}
			//}
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
		
		function addFieldTrigger(emp_id,atten_day){
		//alert(emp_id+"|"+atten_day);
		var title = "";
		var url = "";
		title = "<%=SystemEnv.getHtmlLabelNames("81543",user.getLanguage())%>";
		url="/seahonor/attend/jsp/AttendPersonalDetail.jsp?emp_id="+emp_id+"&atten_day="+atten_day+"";
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 900;
		diag_vote.Height = 400;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show();
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