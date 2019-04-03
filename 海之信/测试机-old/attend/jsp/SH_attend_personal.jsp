<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<html>
	<head>
		<script type="text/javascript" src="/js/weaver.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
		<style type="text/css">
		TR.HeaderStyle{
			height: 28px;
			padding: 3px;
			cursor: pointer;
			color: #000;
			text-align: center;
			background-color: #B7CCF2;
		}
		TD.BodyStyle {
			color: #000;
			padding: 10 5 10 5;
			background-color: #9AB7ED;
			vertical-align: middle;
			overflow:visible;
			text-align: center;
		}
		</style>
	</head>
	<%
	String year_name = Util.null2String(request.getParameter("year_name"));
	String month_name = Util.null2String(request.getParameter("month_name"));
	//String imagefilename = "/images/hdDOC.gif";
	String titlename = "当月报表记录汇总";
	String needfav = "1";
	String needhelp = "";
	%>
	<BODY>
        <%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage())+ ",javascript:document.weaver.submit(),_top} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<table width=100% height=100% border="0" cellspacing="0"
			cellpadding="0">
			<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
			<tr>
				<td height="10" colspan="3"></td>
			</tr>
			<tr>
				<td></td>
				<td valign="top">
					<TABLE class=Shadow>
						<tr>
							<td valign="top">
								<FORM id=weaver name=weaver STYLE="margin-bottom: 0" action=""
									method="post">
									<input type="hidden" name="multiRequestIds" value=""> <input
									type="hidden" name="operation" value="">
									<table width=100% class=ViewForm>
										<colgroup>
										<col width="10%"></col>
										<col width="5%"></col>
										<col width="5%"></col>
										<col width="5%"></col>
										<col width="5%"></col>
										<col width="5%"></col>
										<col width="65%"></col>
										</colgroup>
										<tr>
											<td>查询年月</td>
											<td class=field><select id="year_name" name="year_name">
												<option value=""></option>
												<option value="2014" <%if ("2014".equals(year_name)) {%> selected
												<%}%>>2014</option>
												<option value="2015" <%if ("2015".equals(year_name)) {%> selected
												<%}%>>2015</option>
												<option value="2016" <%if ("2016".equals(year_name)) {%> selected
												<%}%>>2016</option>
												<option value="2017" <%if ("2017".equals(year_name)) {%> selected
												<%}%>>2017</option>
												<option value="2018" <%if ("2018".equals(year_name)) {%> selected
												<%}%>>2018</option>
												<option value="2019" <%if ("2019".equals(year_name)) {%> selected
												<%}%>>2019</option>
											</select></td>
											<td>年</td>
											<td class=field><select id="month_name" name="month_name">
												<option value=""></option>
												<option value="1" <%if ("1".equals(month_name)) {%> selected
												<%}%>>01</option>
												<option value="2" <%if ("2".equals(month_name)) {%> selected
												<%}%>>02</option>
												<option value="3" <%if ("3".equals(month_name)) {%> selected
												<%}%>>03</option>
												<option value="4" <%if ("4".equals(month_name)) {%> selected
												<%}%>>04</option>
												<option value="5" <%if ("5".equals(month_name)) {%> selected
												<%}%>>05</option>
												<option value="6" <%if ("6".equals(month_name)) {%> selected
												<%}%>>06</option>
												<option value="7" <%if ("7".equals(month_name)) {%> selected
												<%}%>>07</option>
												<option value="8" <%if ("8".equals(month_name)) {%> selected
												<%}%>>08</option>
												<option value="9" <%if ("9".equals(month_name)) {%> selected
												<%}%>>09</option>
												<option value="10" <%if ("10".equals(month_name)) {%> selected
												<%}%>>10</option>
												<option value="11" <%if ("11".equals(month_name)) {%>
												selected <%}%>>11</option>
												<option value="12" <%if ("12".equals(month_name)) {%>
												selected <%}%>>12</option>
											</select></td>
											<td>月</td>
											<td><input type="submit" value="查询"></td>
											<td>&nbsp;</td>
										</tr>
										<tr style="height: 1px;">
											<td class=Line colspan=11></td>
										</tr>
									</table>
									<TABLE width="100%" class=ViewForm>
										<tr>
											<td valign="top">
												<table width="100%">
													<colgroup>
													<col width="7%"></col>
													<!-- <col width="3%"></col> -->
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<col width="3%"></col>
													<tr class=HeaderStyle>
														<%
														Calendar cal = Calendar.getInstance();
														if (!"".equals(year_name) && !"".equals(month_name)) {
														cal.set(Integer.parseInt(year_name),Integer.parseInt(month_name), 1);
														}
														int maxDay = cal.getActualMaximum(cal.DAY_OF_MONTH);
														int day_week = cal.get(cal.DAY_OF_WEEK) - 1;
														int other_week = day_week;
														int other_week_1 = day_week;
														int other_week_2 = day_week;
														String tmp_week = "";
														//out.println("maxDay="+maxDay);
														%>
														<td rowspan="2">姓名(编号)</td>
														<!--<td rowspan="2">工号</td>  -->
														<%
														for (int j = 1; j <= maxDay; j++) {
														if (other_week_1==6 || other_week_1 == 7){
														%>
														<td bgcolor = "#036C99"><%=j%></td>
														<%
														}else{
														%>
														<td><%=j%></td>
														<%
														}
														if (other_week_1 == 7){
														other_week_1 = 0;
														}
														other_week_1++;
														}
														%>
													</tr>
													<tr class=HeaderStyle>
														<%
														for (int i = 1; i <= maxDay; i++) {
														//String tmp_week = "";
														if (day_week == 7)
														tmp_week = "日";
														if (day_week == 1)
														tmp_week = "一";
														if (day_week == 2)
														tmp_week = "二";
														if (day_week == 3)
														tmp_week = "三";
														if (day_week == 4)
														tmp_week = "四";
														if (day_week == 5)
														tmp_week = "五";
														if (day_week == 6)
														tmp_week = "六";
														if (tmp_week == "六"||tmp_week == "日"){
														%>
														<td bgcolor = "#036C99"><%=tmp_week%></td>
														<%
														}else{
														%>
														<td><%=tmp_week%></td>
														<%
														}
														if (day_week == 7)
														day_week = 0;
														day_week++;
														}
														%>
													</tr>
													<%
													String sql_1 = " select DATEPART(DAY,[atten_day]) as [Day],(select datename(weekday,atten_day)) as week_day,"
													+"emp_id,atten_day,atten_start_time,(select lastname from hrmresource where id =emp_id) as emp_name, atten_end_time "
													+" from sh_work_all_atten_info where DATEPART(mm,atten_day) =  '08' and "
													+" DATEPART(yyyy,atten_day) =  '2015' order by emp_id,atten_day desc ";
													rs.executeSql(sql_1);
													//out.print("SQL="+sql_1);
													int tmp_emp_id = 0;
													boolean isNewLine = true;
													int befday = 0;
													StringBuffer buff = new StringBuffer();
													%>
													<tr>
														<%
														while (rs.next()) {
														String emp_name = rs.getString("emp_name");
														//String gh = rs.getString("gh");
														int emp_id = rs.getInt("emp_id");
														int tmp_Day = rs.getInt("Day");
														String week_day = rs.getString("week_day");
														if (tmp_emp_id != emp_id) {
														isNewLine = true;
														if (befday > 0) {
														for (int i = befday+1; i <=maxDay; i++) {
														//   如果 other_week 是  6 0 的话就是周六和周日
														if(other_week%7==6||other_week%7==0){
														// 如果是周六周日则变换内容和底色
														%><td  bgcolor = "#036C99"></td><%
														}else{
														%><td class=BodyStyle style="color:red;">x</td>
														<%
														}
														other_week++;
														//out.println("other_week3="+other_week);
														}
														%>
													</tr><tr>
													<%other_week = other_week_2; }%>
													<%
													befday = 0;
													//buff = new StringBuffer();
													}else{
													isNewLine = false;
													}
													if(isNewLine){
													%>
													<td class=BodyStyle><%=emp_name%></td>
													<%}%>
													<%
													for(int i=befday+1;i<tmp_Day;i++){
													//  zhgge  dif yejia xia gangg de daima
													if(other_week%7==6||other_week%7==0){
													// 如果是周六周日则变换内容和底色
													%><td  bgcolor = "#036C99"></td><%
													}else{
													%><td class=BodyStyle style="color:red;">x</td><%
													}
													other_week++;
													}%>
													<%if(other_week%7==6||other_week%7==0){
													%><td  bgcolor = "#036C99"></td><%
													
													}else{
													%>
													<td class=BodyStyle><%="√"%></td>
													<%
													}
													befday = tmp_Day;
													tmp_emp_id = emp_id;
													other_week++;
													}%>
													<%for(int i=befday+1;befday>0&&i<=maxDay;i++){
													//  zhgge  dif yejia xia gangg de daima
													if(other_week%7==6||other_week%7==0){
													// 如果是周六周日则变换内容和底色
													%><td  bgcolor = "#036C99"></td><%
													}else{
													%>
													<td class=BodyStyle style="color:red;">x</td>
													<%
													}
													other_week++;
													}%>
												</tr>
											</table>
										</td>
									</tr>
								</TABLE>
							</FORM>
						</td>
					</tr>
				</TABLE>
			</td>
			<td></td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>
</BODY>
</HTML>