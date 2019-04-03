<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%!
    public String getEmpAttenInfo(String emp_id,String atten_day){
        StringBuffer buff = new StringBuffer();
        RecordSet recordSet = new RecordSet();
     
        //String nbsp = "&nbsp;详细&nbsp;";
        String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	    String sql = " select atten_start_time,atten_end_time,out_type,late_times,early_leave_times from sh_work_all_atten_info "
	                +" where emp_id = "+emp_id+" and  atten_day = '"+atten_day+"' ";
		recordSet.executeSql(sql);
		String temp1 = "<span style=\"border:1px; width: 1350px ; background:#92D050 ; color:white \">  ";
	    String temp2 = "<span style=\"border:1px; width: 1350px ; background:#538DD5 \">  ";
	    String temp3 = "<span style=\"border:1px; width: 1350px ; background:#FF0000\">  ";

		if(recordSet.next()) {
			String start_time = Util.null2String(recordSet.getString("atten_start_time"));
			String end_time = Util.null2String(recordSet.getString("atten_end_time"));
			String out_type = Util.null2String(recordSet.getString("out_type"));
			String late_times = Util.null2String(recordSet.getString("late_times"));
			String early_leave_times = Util.null2String(recordSet.getString("early_leave_times"));
			
			if(!"".equals(start_time)){
			    if(late_times.compareTo("0.0")>0){
			        buff.append(temp1+late_times+"&nbsp;");
			    }else{
			        buff.append(temp1+nbsp);
			    }
			    
			}else if("0".equals(out_type)){
			    buff.append(temp2+nbsp);
			}else{
			    buff.append(temp3+nbsp);
			}
			buff.append("<a href=javascript:this.openFullWindowForXtable('/seahonor/jsp/AttendPersonalDetail.jsp?emp_id="+emp_id+"&atten_day="+atten_day+"\')>详细</a>");
		    buff.append("</span>");
		
		    if(!"".equals(end_time)){
		        if(early_leave_times.compareTo("0.0")>0){
			        buff.append(temp1+early_leave_times+"&nbsp;");
			    }else{
			        buff.append(temp1+nbsp);
			    }
		 
		    }else if("0".equals(out_type)){
		        buff.append(temp2+nbsp);
		    }else{
		        buff.append(temp3+nbsp);
		    }
		    buff.append("<a href=javascript:this.openFullWindowForXtable('/seahonor/jsp/AttendPersonalDetail.jsp?emp_id="+emp_id+"&atten_day="+atten_day+"')>详细</a>");
	        buff.append("</span>");
		}
	if(buff.length() < 1)  buff.append("<span>&nbsp;</span>");
	//   System.out.println(emp_id + " : " + atten_day + " = " +buff.toString());
	return buff.toString();
	        //}
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
	String emp_id = "";
	String dep_name = "";
	String emp_name = "";
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
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
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
										<tr class="ListStyle" align="center" style="height: 10px;background-color: #DDD9C4;">
											<td rowspan="2">部门</td>
											<td rowspan="2">姓名</td>
											<td  align="center" bgcolor = "#FFFFFF" colspan="7"><%=year_name%> 年 <%=month_name%>月</td>
										</tr>
										<tr class="ListStyle" align="center" style="height: 20px;background-color: #DDD9C4;">
											<td>周一</td>
											<td>周二</td>
											<td>周三</td>
											<td>周四</td>
											<td>周五</td>
											<td>周六</td>
											<td>周日</td>
										</tr>
										<tr align="center">
											<%

											int maxDay = cal.getActualMaximum(cal.DAY_OF_MONTH);
											int day_week = cal.get(cal.DAY_OF_WEEK) - 1;
											int other_week = day_week;
											int firstday = 1;
											if (other_week == 0){
											    other_week = 7;
											}
											//out.println("other_week="+day_week);
											//out.println("maxDay="+maxDay);
											%>
											<td rowspan="6"><%=dep_name%></td>
											<td rowspan="6"><%=emp_name%></td>
											<%
											for (int j = 1; j <= 40; j++) {
											if (firstday >1){
											    out.println("<td>"+firstday+"日<br/>");
												String tmp_firstday = String.format("%02d",firstday);
												String tmp_date = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ tmp_firstday;
												//out.println("tmp_date="+tmp_date);
												out.println(getEmpAttenInfo(recipient,tmp_date));
											    out.println("</td>");
											
											if(firstday == maxDay) break;
											    firstday ++;
											}else if (firstday <=1){
											if (j == other_week){
											    out.println("<td>"+firstday+"日<br/>");
												String tmp_firstday = String.format("%02d",firstday);
												String tmp_date = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ tmp_firstday;
												//out.println("tmp_date="+tmp_date);
												out.println(getEmpAttenInfo(recipient,tmp_date));
											    out.println("</td>");
											    firstday ++;
											}else{
											    out.println("<td></td>");
											}
											
											}
											if(j%7 == 0){
											%>
										    </tr><tr align="center">
										    <%
										    }
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