<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>
<jsp:useBean id="mrr" class="gvo.ITResouce.ITResouceListReport" scope="page"/>
<jsp:useBean id="SptmForMeeting" class="weaver.splitepage.transform.SptmForMeeting" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="checkSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page"/>
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<HTML><HEAD>
	<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
	<META http-equiv=Content-Type content="text/html; charset=GBK">
	<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
	<script type="text/javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
	<style type="text/css">
	.selectable .ui-selecting { background: #FECA40;}
	.selectable .ui-selected { background: #F39814; color: white; }
	.selectable { list-style-type: none; margin: 0; padding: 0;cursor :pointer; }
	</style>
</head>
<%!
public String getDayOccupied(String thisDate, List<String> beginDateList, List<String> beginTimeList,
List<String> endDateList, List<String> endTimeList, List<String> cancelList){
String[] minute = new String[24 * 60];

for (int i = 0; i < beginDateList.size(); i++){
String beginDate = beginDateList.get(i);
String beginTime = beginTimeList.get(i);
String endDate = endDateList.get(i);
String endTime = endTimeList.get(i);
String cancel = cancelList.get(i);

if(beginDate.compareTo(thisDate) <= 0 && thisDate.compareTo(endDate) <= 0){
if(beginDate.compareTo(thisDate) < 0){
beginTime = "00:00";
}
if(thisDate.compareTo(endDate) < 0){
endTime = "23:59";
}

int beginMinuteOfDay = getMinuteOfDay(beginTime) + 1;
int endMinuteOfDay  = getMinuteOfDay(endTime);

while(beginMinuteOfDay < endMinuteOfDay){
if("2".equals(minute[beginMinuteOfDay])){
return "2";
}else if("3".equals(minute[beginMinuteOfDay])){
return "3";
}else{
if("2".equals(cancel)){
minute[beginMinuteOfDay] = "2";
}else{
minute[beginMinuteOfDay] = "3";
}
}
beginMinuteOfDay++;
}
}
}

for(int i = 0; i < 24 * 60; i++){
if("2".equals(minute[i])){
return "2";
}
if("3".equals(minute[i])){
return "3";
}
}

return "0";
}
public String getHourOccupied(String thisDate, String thisHour, List<String> beginDateList, List<String> beginTimeList, List<String> endDateList,
List<String> endTimeList, List<String> cancelList,List<String> meetingstatus){
String[] minute = new String[24 * 60];
//	System.out.println("xxxxxxxxxxxxxxxxxxxxxxx#####################SSSSSSSSSSSSS ");
//	System.out.println("thisDate = " + thisDate);
//	System.out.println("thisHour = " + thisHour);
//	System.out.println("beginDateList = " + beginDateList);
//	System.out.println("beginTimeList = " + beginTimeList);
//	System.out.println("endDateList = " + endDateList);
//	System.out.println("endTimeList = " + endTimeList);
//	System.out.println("cancelList = " + cancelList);
//	System.out.println("meetingstatus = " + meetingstatus);
for (int i = 0; i < beginDateList.size(); i++) {
String beginDate = beginDateList.get(i);
String beginTime = beginTimeList.get(i);
String endDate = endDateList.get(i);
String endTime = endTimeList.get(i);
String cancel = cancelList.get(i);
String meetingstat = meetingstatus.get(i);

if((beginDate.compareTo(thisDate) < 0 || (beginDate.compareTo(thisDate) == 0 && beginTime.compareTo(thisHour + ":59") <= 0))
&& (thisDate.compareTo(endDate) < 0 || (thisDate.compareTo(endDate) == 0 && (thisHour + ":00").compareTo(endTime) <= 0))){
if(beginDate.compareTo(thisDate) < 0 || beginTime.compareTo(thisHour + ":00") < 0){
beginTime = thisHour + ":00";
}
if(thisDate.compareTo(endDate) < 0 || (thisHour + ":59").compareTo(endTime) <= 0){
endTime = thisHour + ":59";
}

int beginMinuteOfHour = getMinuteOfDay(beginTime) + 1;
int endMinuteOfHour  = getMinuteOfDay(endTime);

while(beginMinuteOfHour < endMinuteOfHour){
if("2".equals(minute[beginMinuteOfHour])){
return "2";
}else if("3".equals(minute[beginMinuteOfHour])){
return "3";
}else{
if("2".equals(meetingstat)){
minute[beginMinuteOfHour] = "2";
}else{
minute[beginMinuteOfHour] = "3";
}
}
beginMinuteOfHour++;
}
}
}
for(int i = 0; i < 24 * 60; i++){
if("2".equals(minute[i])){
return "2";
}else if("3".equals(minute[i])){
return "3";
}
}
return "0";
}
private int getMinuteOfDay(String time){
List<String> timeList = Util.TokenizerString(time, ":");

return (Integer.parseInt(timeList.get(0)) * 60 + Integer.parseInt(timeList.get(1)));
}
%>
<%
Calendar calendar = Calendar.getInstance();
RecordSet.executeSql("select detachable from SystemSet");
int detachable=0;
if(RecordSet.next())
{
detachable=RecordSet.getInt("detachable");
}
String subid=Util.null2String(request.getParameter("subCompanyId"));
//if("".equals(subid)){
//    subid = user.getUserSubCompany1()+"";
//}
// System.out.println("subid:"+subid);
String imagefilename = "/images/hdReport.gif";
String titlename = "实验室设备使用情况";
String needfav ="1";
String needhelp ="";
char flag=2;
String userid=user.getUID()+"" ;
// 0 It设备类    1 试验器材
int ITType = 1;
ArrayList<String> newMeetIds = new ArrayList<String>() ;
boolean cancelRight = HrmUserVarify.checkUserRight("Canceledpermissions:Edit",user);
//1: year 2:month 3:week 4:today but the year haven`t been used!
int bywhat = Util.getIntValue(request.getParameter("bywhat"),4);
String currentdate =  Util.null2String(request.getParameter("currentdate"));
String movedate = Util.null2String(request.getParameter("movedate"));
String relatewfid = Util.null2String(request.getParameter("relatewfid"));
String operation=Util.null2String(request.getParameter("operation"));
int meetingid=Util.getIntValue(request.getParameter("id"),0);
Calendar today = Calendar.getInstance();
Calendar temptoday1 = Calendar.getInstance();
Calendar temptoday2 = Calendar.getInstance();
String nowdate = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
String nowtime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
Util.add0(today.get(Calendar.SECOND), 2);
int start=0;
int end = 23;
int roomConflictChk	= 1;
int roomConflict	= 1;
RecordSet.executeSql("select timeRangeStart,timeRangeEnd,roomConflictChk,roomConflict from MeetingSet") ;
if(RecordSet.next()){
//  start = Util.getIntValue(RecordSet.getString("timeRangeStart"),0);
// end =Util.getIntValue(RecordSet.getString("timeRangeEnd"),23);
roomConflictChk	= Util.getIntValue(RecordSet.getString("roomConflictChk"), 1);
roomConflict	= Util.getIntValue(RecordSet.getString("roomConflict"), 1);
}
if(!currentdate.equals("")) {
int tempyear = Util.getIntValue(currentdate.substring(0,4)) ;
int tempmonth = Util.getIntValue(currentdate.substring(5,7))-1 ;
int tempdate = Util.getIntValue(currentdate.substring(8,10)) ;
today.set(tempyear,tempmonth,tempdate);
}
int currentyear=today.get(Calendar.YEAR);
int thisyear=currentyear;
int currentmonth=today.get(Calendar.MONTH);
int currentday=today.get(Calendar.DATE);
switch(bywhat) {
case 1:
today.set(currentyear,0,1) ;
if(movedate.equals("1")) today.add(Calendar.YEAR,1) ;
if(movedate.equals("-1")) today.add(Calendar.YEAR,-1) ;
break ;
case 2:
today.set(currentyear,currentmonth,1) ;
if(movedate.equals("1")) today.add(Calendar.MONTH,1) ;
if(movedate.equals("-1")) today.add(Calendar.MONTH,-1) ;
break ;
case 3:
Date thedate = today.getTime() ;
int diffdate = (-1)*thedate.getDay() ;
today.add(Calendar.DATE,diffdate) ;
if(movedate.equals("1")) today.add(Calendar.WEEK_OF_YEAR,1) ;
if(movedate.equals("-1")) today.add(Calendar.WEEK_OF_YEAR,-1) ;
today.add(Calendar.DATE,1);
break;
case 4:
if(movedate.equals("1")) today.add(Calendar.DATE,1) ;
if(movedate.equals("-1")) today.add(Calendar.DATE,-1) ;
break;
}
currentyear=today.get(Calendar.YEAR);
currentmonth=today.get(Calendar.MONTH)+1;
currentday=today.get(Calendar.DATE);
currentdate = Util.add0(currentyear,4)+"-"+Util.add0(currentmonth,2)+"-"+Util.add0(currentday,2) ;
temptoday1.set(currentyear,currentmonth-1,currentday) ;
temptoday2.set(currentyear,currentmonth-1,currentday) ;
calendar.set(currentyear, currentmonth - 1, currentday);
calendar.add(Calendar.MONTH, 1);
calendar.set(Calendar.DATE, 1);
calendar.add(Calendar.DATE, -1);
int daysOfThisMonth = calendar.get(Calendar.DATE);
switch (bywhat) {
case 1 :
today.add(Calendar.YEAR,1) ;
break ;
case 2:
today.add(Calendar.MONTH,1) ;
break ;
case 3:
today.add(Calendar.WEEK_OF_YEAR,1) ;
break;
case 4:
today.add(Calendar.DATE,1) ;
break;
}
currentyear=today.get(Calendar.YEAR);
currentmonth=today.get(Calendar.MONTH)+1;
currentday=today.get(Calendar.DATE);
String currenttodate = Util.add0(currentyear,4)+"-"+Util.add0(currentmonth,2)+"-"+Util.add0(currentday,2) ;
String 	currentWeekEnd = "";
String datefrom = "" ;
String dateto = "" ;
String datenow = "" ;
switch (bywhat) {
case 1 :
datenow = Util.add0(temptoday1.get(Calendar.YEAR),4) ;
temptoday1.add(Calendar.YEAR,-1) ;
datefrom = Util.add0(temptoday1.get(Calendar.YEAR),4) ;
temptoday2.add(Calendar.YEAR,1) ;
dateto = Util.add0(temptoday2.get(Calendar.YEAR),4) ;
break ;
case 2 :
datenow = Util.add0(temptoday1.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday1.get(Calendar.MONTH)+1,2) ;
temptoday1.add(Calendar.MONTH,-1) ;
datefrom = Util.add0(temptoday1.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday1.get(Calendar.MONTH)+1,2) ;
temptoday2.add(Calendar.MONTH,1) ;
dateto = Util.add0(temptoday2.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday2.get(Calendar.MONTH)+1,2) ;
break ;
case 3 :
datenow = Util.add0(temptoday1.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday1.get(Calendar.MONTH)+1,2)+"-"+Util.add0(temptoday1.get(Calendar.DATE),2) ;
temptoday1.add(Calendar.WEEK_OF_YEAR,-1) ;
datefrom = Util.add0(temptoday1.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday1.get(Calendar.MONTH)+1,2)+"-"+Util.add0(temptoday1.get(Calendar.DATE),2) ;
temptoday2.add(Calendar.WEEK_OF_YEAR,1) ;
dateto = Util.add0(temptoday2.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday2.get(Calendar.MONTH)+1,2)+"-"+Util.add0(temptoday2.get(Calendar.DATE),2) ;
break ;
case 4 :
datenow = Util.add0(temptoday1.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday1.get(Calendar.MONTH)+1,2)+"-"+Util.add0(temptoday1.get(Calendar.DATE),2) ;
temptoday1.add(Calendar.DATE,-1) ;
datefrom = Util.add0(temptoday1.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday1.get(Calendar.MONTH)+1,2)+"-"+Util.add0(temptoday1.get(Calendar.DATE),2) ;

Calendar datetos = Calendar.getInstance();
temptoday2.add(Calendar.DATE,1) ;
dateto = Util.add0(temptoday2.get(Calendar.YEAR),4)+"-"+Util.add0(temptoday2.get(Calendar.MONTH)+1,2)+"-"+Util.add0(temptoday2.get(Calendar.DATE),2) ;
}
ArrayList<String> itResourceIds = new ArrayList<String>() ;
ArrayList<String> itResourceNames = new ArrayList<String>();
String unionSql = "select id,zcmc,gdzcbh,zylx,zyzt,mqjyr from formtable_main_215  where zylx="+ITType+" order by lpad(zybm,8,'0') ";
RecordSet.executeSql(unionSql);
while(RecordSet.next()){
itResourceIds.add(RecordSet.getString("id")) ;
itResourceNames.add(RecordSet.getString("zcmc")) ;
}
//get the mapping from the select type
//out.println("datenow = " + datenow + " bywhat = " + bywhat + " daysOfThisMonth = " + daysOfThisMonth );
HashMap<String,HashMap<String,ArrayList<String>>> mrrHash= mrr.getMapping(datenow,bywhat,ITType);
//out.println("mrrHash" + mrrHash);
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
	<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(6076,user.getLanguage())+SystemEnv.getHtmlLabelName(160,user.getLanguage())+SystemEnv.getHtmlLabelName(622,user.getLanguage())+",javascript:ShowMONTH(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(1926,user.getLanguage())+SystemEnv.getHtmlLabelName(160,user.getLanguage())+SystemEnv.getHtmlLabelName(622,user.getLanguage())+",javascript:ShowWeek(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(390,user.getLanguage())+SystemEnv.getHtmlLabelName(160,user.getLanguage())+SystemEnv.getHtmlLabelName(622,user.getLanguage())+",javascript:ShowDay(),_self} " ;
	%>
	<%@ include file="/systeminfo/RightClickMenu.jsp" %>
	<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
		<colgroup>
		<col width="10">
		<col width="">
		<col width="10">
		<tr style="height:0px;">
			<td height="0" colspan="3"></td>
		</tr>
		<tr>
			<td ></td>
			<td valign="top">
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
							<FORM id="frmmain" name="frmmain" method="get" action="ITResourceList1.jsp">
								<input type=hidden name=currentdate value="<%=currentdate%>">
								<input type=hidden name=bywhat value="<%=bywhat%>">
								<input type=hidden name=subCompanyId value="<%=subid%>"/>
								<input type=hidden name=movedate value="">
								<input type=hidden name=operation value="">
								<input type=hidden name="id" value="">
								<TABLE class=ViewForm>
									<TR class=Title>
										<TH colspan=4><%=SystemEnv.getHtmlLabelName(324,user.getLanguage())%></TH>
									</TR>
									<TR class= Spacing>
										<TD CLASS=Sep1 colspan=4></TD>
									</TR>
								</table>
								<br>
								<div>
									<button title="<%=datefrom%>" onclick="getSubdate();" name="But1">&lt;</button>
									<BUTTON class="calendar" type="button" onclick="gethbtheDate(subscribeDateFrom,subscribeDateFromSpan)"></BUTTON>
									<SPAN id=subscribeDateFromSpan ><%=datenow%></SPAN>
									<input type="hidden" name="subscribeDateFrom" value="<%=datenow%>">
									<script>
									function gethbtheDate(inputname,spanname){
									WdatePicker({el:spanname,
											onpicked:function(dp){jQuery("#frmmain")[0].currentdate.value = dp.cal.getDateStr();
												document.frmmain.submit();},
												oncleared:function(dp){jQuery("input[name="+inputname+"]").val("");}//$dp.getElement(inputname).value =''
												});
									}
									</script>
									<button title="<%=dateto%>" onclick="getSupdate();"  name=But2>&gt;</button>
									<style type=text/css>.TH {
										CURSOR: auto; BACKGROUND-COLOR: beige
									}
									.PARENT {
										CURSOR: auto
									}
									.TH1 {
										CURSOR: auto; HEIGHT: 25px; BACKGROUND-COLOR: beige
									}
									.TODAY {
										CURSOR: auto; BACKGROUND-COLOR: lightgrey
									}
									.T_HOUR {
										BORDER-LEFT: white 1px solid; CURSOR: auto; BACKGROUND-COLOR: lightgrey
									}
									.TI TD {
										BORDER-TOP: 0px; FONT-SIZE: 1px; LEFT: -1px; BORDER-LEFT: 0px; CURSOR: auto; POSITION: relative; TOP: -1px
									}
									.CU {
										
									}
									.SD {
										CURSOR: auto; COLOR: white; BACKGROUND-COLOR: mediumblue
									}
									.L {
										BORDER-TOP: white 1px solid; CURSOR: auto; BACKGROUND-COLOR: lightgrey
									}
									.LI {
										BORDER-TOP: white 1px solid; CURSOR: auto; BACKGROUND-COLOR: lightgrey
									}
									.L1 {
										BORDER-TOP: white 1px solid; BORDER-LEFT: white 1px solid; CURSOR: auto; BACKGROUND-COLOR: lightgrey
									}
									.MI TD {
										BORDER-TOP: 1px solid; BORDER-LEFT: 1px solid
									}
									.WE {
										BORDER-LEFT-WIDTH: 0px
									}
									.PI TD {
										BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; BORDER-LEFT: lightgrey 1px solid; BORDER-BOTTOM: 1px solid
									}
									</style>
								</div>
								<br>
								
								<!--============================ 月报表 ============================-->
								<% if(bywhat==2) {%>
								<table border=0 cellspacing=0 cellpadding=0 bgcolor="" width="100%">
									<TR class=Title>
										<TH align="left" width="75%">月使用情况</TH>
										<td align="right" width="25%">
											<table>
												<tr><td>
													<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
														<tr><td bgcolor="" width="15" style="border-width:1">&nbsp;</td></tr>
													</table>
												</td><td>
												&nbsp;空闲
											</td><td>
											<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
												<tr><td bgcolor="green" width="15" style="border-width:1">&nbsp;</td></tr>
											</table>
										</td><td>
										&nbsp;占用
									</td><td>
									<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
										<tr><td bgcolor="red" width="15" style="border-width:1">&nbsp;</td></tr>
									</table>
								</td><td>
								&nbsp;审批中
							</td></tr>
						</table>
					</td>
				</TR>
			</table>
			<table class=MI id=AbsenceCard
				style="BORDER-RIGHT: 1px solid; TABLE-LAYOUT: fixed; FONT-SIZE: 8pt; WIDTH: 100%; CURSOR: hand; BORDER-BOTTOM: 1px solid"
				cellSpacing=0 cellPadding=0>
				<tr>
					<td>
						<table border=0 cellspacing=2 cellpadding=2 Style="width:100%; font-size:8pt;table-layout:fixed">
							
							<tr  bgcolor=lightblue>
								<td width=22.5%>日期</td>
								<%for(int i=0;i<daysOfThisMonth;i++){%>
								<td width=2.5% align=center><%=i+1%></td>
								<%}%>
							</tr>
							<%
							
							for(int k=0;k<itResourceIds.size();k++){
							String tmproomid=(String) itResourceIds.get(k);
							%>
							<tr>
								<td width=22.5%><%=itResourceNames.get(k)%>   <a href="/workflow/request/AddRequestIframe.jsp?workflowid=1604&bookid=<%=tmproomid%>" target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;<img style=" width: 60px; height: 21px; overflow: hidden; display: table-cell; vertical-align: middle; text-align: center; *font: 18px arial;" src="/images/ljjy1.png" border="0"></a>   </td>
								<%
								HashMap<String,ArrayList<String>> tempMap = mrrHash.get(itResourceIds.get(k));
								ArrayList<String> ids = tempMap.get("ids");
								
								if (ids.size()==0) {
								for (int p=0 ;p<daysOfThisMonth;p++) {
								out.println("<td></td>");
								}
								out.println(" <TR class=Line ><TD style='padding:0;' colspan=" + (Integer.parseInt(""+daysOfThisMonth)+1)+ "></TD></TR> ");
								continue;
								};
								
								ArrayList<String> beginDates = tempMap.get("beginDates");
								ArrayList<String> endDates = tempMap.get("endDates");
								ArrayList<String> begintimes = tempMap.get("begintimes");
								ArrayList<String> endtimes = tempMap.get("endtimes");
								
								ArrayList<String> emp_ids = tempMap.get("emp_ids");
								ArrayList<String> statuss = tempMap.get("statuss");
								
								//	ArrayList<String> totalmembers = (ArrayList)tempMap.get("totalmembers");
								//		ArrayList<String> callers = (ArrayList)tempMap.get("callers");
								//		ArrayList<String> contacters = (ArrayList)tempMap.get("contacters");
								
								for(int j=0; j<daysOfThisMonth; j++)
								{
								String bgcolor="#f5f5f5";
								String tdTitle = "" ;
								String tmpdate = datenow + "-"+Util.add0(j+1,2) ;	//for td4306
								String temp = getDayOccupied(tmpdate, beginDates, begintimes, endDates, endtimes, statuss);
								//	if(ids.size()>0){
								//		String tmp_status = statuss.get(0);
								//		if("2".equals(tmp_status)){
								//			temp = "2";
								//	}
								//	}
								
								for (int h=0 ;h<ids.size();h++) {
								String beginDate = beginDates.get(h);
								String endDate = endDates.get(h);
								String begintime = begintimes.get(h);
								String endtime = endtimes.get(h);
								String emp_id = emp_ids.get(h);
								String status = statuss.get(h);
								
								//		String name = (String)names.get(h);
								//		String totalmember = (String)totalmembers.get(h);
								//		String caller = (String)callers.get(h);
								//		String contacter = (String)contacters.get(h);
								
								//	if(cancel.equals("1")) continue;
								if(tmpdate.compareTo(beginDate)>=0 && tmpdate.compareTo(endDate)<=0)
								{
								if(tdTitle.equals(""))
								{
								tdTitle = mrr.getITResourceInfo(emp_id,beginDate,endDate,begintime,endtime);
								}
								else
								{
								tdTitle +="\n"+"----------------------------------------------------------\n"+
								mrr.getITResourceInfo(emp_id,beginDate,endDate,begintime,endtime);
								}
								}
								}
								
								if("2".equals(temp)){
								bgcolor="red";
								}else if("3".equals(temp)){
								bgcolor="green";
								}
								%>
								<td bgcolor="<%=bgcolor%>"
									<%if(!"".equals(tdTitle)) {%>title="<%=tdTitle%>"<%}%>
								></td>
								<%}%>
							</tr>
						<tr height=5></tr>
						<%  }%>
					</table>
				</td>
			</tr>
		</table>
		<%}%>
		<!--============================ 周报表 ============================-->
		<% if(bywhat==3) {%>
		<table border=0 cellspacing=0 cellpadding=0 bgcolor="" width="100%">
			<TR class=Title>
				<TH align="left" width="75%">周使用情况</TH>
				<td align="right" width="25%">
					<table>
						<tr><td>
							<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
								<tr><td bgcolor="" width="15" style="border-width:1">&nbsp;</td></tr>
							</table>
						</td><td>
						&nbsp;空闲
					</td><td>
					<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
						<tr><td bgcolor="green" width="15" style="border-width:1">&nbsp;</td></tr>
					</table>
				</td><td>
				&nbsp;占用
			</td><td>
			<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
				<tr><td bgcolor="red" width="15" style="border-width:1">&nbsp;</td></tr>
			</table>
		</td><td>
		&nbsp;审批中
	</td></tr>
</table>
</td>
</TR>
</table>
<table class=MI id=AbsenceCard
style="BORDER-RIGHT: 1px solid; TABLE-LAYOUT: fixed; FONT-SIZE: 8pt; WIDTH: 100%; CURSOR: hand; BORDER-BOTTOM: 1px solid"
cellSpacing=0 cellPadding=0>
<tr>
<td>
<table width="100%" border=0 cellspacing=2 cellpadding=2 Style="width:100%; font-size:8pt;table-layout:fixed">
	
	<tr  bgcolor=lightblue>
		<td width=22.5%>星期</td>
		<%for(int i=0;i<7;i++){%>
		<td width=11% align=center><%=i+1%></td>
		<%}%>
	</tr>
	<%
	for(int k=0;k<itResourceIds.size();k++){
	String tmproomid=(String) itResourceIds.get(k);
	%>
	<tr>
		<td width=22.5%><%=itResourceNames.get(k)%>  <a href="/workflow/request/AddRequestIframe.jsp?workflowid=1604&bookid=<%=tmproomid%>" target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;<img style=" width: 60px; height: 21px; overflow: hidden; display: table-cell; vertical-align: middle; text-align: center; *font: 18px arial;" src="/images/ljjy1.png" border="0"></a> </td>
		<%
		HashMap<String,ArrayList<String>> tempMap = mrrHash.get(itResourceIds.get(k));
		ArrayList<String> ids = tempMap.get("ids");
		
		if (ids.size()==0) {
		for (int p=0 ;p<7;p++) {
		out.println("<td></td>");
		}
		out.println(" <TR class=Line><TD colspan='8'></TD></TR> ");
		continue;
		};
		
		ArrayList<String> beginDates = tempMap.get("beginDates");
		ArrayList<String> endDates = tempMap.get("endDates");
		ArrayList<String> begintimes = tempMap.get("begintimes");
		ArrayList<String> endtimes = tempMap.get("endtimes");
		ArrayList<String> emp_ids = tempMap.get("emp_ids");
		ArrayList<String> statuss = tempMap.get("statuss");
		
		//			ArrayList totalmembers = (ArrayList)tempMap.get("totalmembers");
		//			ArrayList callers = (ArrayList)tempMap.get("callers");
		//			ArrayList contacters = (ArrayList)tempMap.get("contacters");
		
		for(int j=0; j<7; j++){
		String bgcolor="#f5f5f5";
		String tdTitle = "" ;
		String tmpdate = TimeUtil.dateAdd(datenow,j) ;
		String temp = getDayOccupied(tmpdate, beginDates, begintimes, endDates, endtimes, statuss);
		for (int h=0 ;h<ids.size();h++) {
		String beginDate = beginDates.get(h);
		String endDate = endDates.get(h);
		String begintime = begintimes.get(h);
		String endtime = endtimes.get(h);
		String status = statuss.get(h);
		
		String emp_id = emp_ids.get(h);
		//			String name = (String)names.get(h);
		//			String totalmember = (String)totalmembers.get(h);
		//			String caller = (String)callers.get(h);
		//			String contacter = (String)contacters.get(h);
		
		//			if(cancel.equals("1"))continue;
		if(tmpdate.compareTo(beginDate)>=0&& tmpdate.compareTo(endDate)<=0){
		if(tdTitle.equals("")){
		tdTitle = mrr.getITResourceInfo(emp_id,beginDate,endDate,begintime,endtime);
		}else{
		tdTitle +="\n"+"----------------------------------------------------------\n"+
		mrr.getITResourceInfo(emp_id,beginDate,endDate,begintime,endtime);
		}
		}
		}
		
		if("2".equals(temp)){
		bgcolor="red";
		}else if("3".equals(temp)){
		bgcolor="green";
		}
		%>
		<td bgcolor="<%=bgcolor%>"
			<%if(!"".equals(tdTitle)) {%>title="<%=tdTitle%>"<%}%>
		></td>
		<%}%>
	</tr>
<tr height=5></tr>
<%  }%>
</table>
</td>
</tr>
</table>
<%}%>
<!--============================ 日报表 ============================-->
<% if(bywhat==4) {%>
<table border=0 cellspacing=0 cellpadding=0 bgcolor="" width="100%">
<TR class=Title>
<TH align="left" width="50%">日使用情况</TH>
<td align="right" width="50%">
<table>
<tr><td>
	<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
		<tr><td bgcolor="" width="15" style="border-width:1">&nbsp;</td></tr>
	</table>
</td><td>
&nbsp;空闲
</td><td>
<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
<tr><td bgcolor="green" width="15" style="border-width:1">&nbsp;</td></tr>
</table>
</td><td>
&nbsp;占用
</td><td>
<table border=1 cellspacing=0 cellpadding=0 bgcolor="">
<tr><td bgcolor="red" width="15" style="border-width:1">&nbsp;</td></tr>
</table>
</td><td>
&nbsp;审批中
</td>
</tr>
</table>
</td>
</TR>
</table>
<table class=MI id=AbsenceCard
style="BORDER-RIGHT: 1px solid; TABLE-LAYOUT: fixed; FONT-SIZE: 8pt; WIDTH: 100%; CURSOR: hand; BORDER-BOTTOM: 1px solid"
cellSpacing=0 cellPadding=0>
<tr>
<td>
<table width="100%" border=0 cellspacing=2 cellpadding=2 Style="width:100%; font-size:8pt;table-layout:fixed">

<tr  bgcolor=lightblue>
<td width=22.5%>小时</td>
<%for(int i=start;i<end+1;i++){%>
<td width=3.5% align=center><%=i%></td>
<%}%>
</tr>
<%
for(int k=0;k<itResourceIds.size();k++){
String tmproomid= itResourceIds.get(k);
%>
<tr class="selectable">
<td width=22.5%><%=itResourceNames.get(k)%>  <a href="/workflow/request/AddRequestIframe.jsp?workflowid=1604&bookid=<%=tmproomid%>" target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;<img style=" width: 60px; height: 21px; overflow: hidden; display: table-cell; vertical-align: middle; text-align: center; *font: 18px arial;" src="/images/ljjy1.png" border="0"></a> </td>
<%
HashMap<String,ArrayList<String>> tempMap = mrrHash.get(itResourceIds.get(k));
ArrayList<String> ids = tempMap.get("ids");



if (ids.size()==0) {
for (int p=start ;p<end+1;p++) {
out.println("<td id='"+tmproomid+"' target='"+p+"' onmousedown='createMeetingAction.startDrag(event);' bgcolor='#f5f5f5'>&nbsp;</td>");
}
//out.println(" <TR class=Line><TD colspan='25'></TD></TR> ");
continue;
};

ArrayList<String> beginDates = tempMap.get("beginDates");
ArrayList<String> endDates = tempMap.get("endDates");
ArrayList<String> begintimes = tempMap.get("begintimes");
ArrayList<String> endtimes = tempMap.get("endtimes");
ArrayList<String> emp_ids = tempMap.get("emp_ids");
ArrayList<String> statuss = tempMap.get("statuss");

//		out.println("beginDates = " + beginDates);
//		out.println("endDates = " + endDates);
//		out.println("begintimes = " + begintimes);
//		out.println("endtimes = " + endtimes);
//		out.println("emp_ids = " + emp_ids);
//		out.println("statuss = " + statuss);

//			ArrayList names = (ArrayList)tempMap.get("names");
//			ArrayList totalmembers = (ArrayList)tempMap.get("totalmembers");

//			ArrayList callers = (ArrayList)tempMap.get("callers");
//
//				ArrayList contacters = (ArrayList)tempMap.get("contacters");
//				ArrayList cancels = (ArrayList)tempMap.get("cancels");
//				ArrayList meetingstatus = (ArrayList)tempMap.get("meetingstatus");
for(int j=start; j<end+1; j++){
String bgcolor="#f5f5f5";
String tdTitle = "" ;
String tempTime = datenow+" "+Util.add0(j,2) ;
//	out.println("xxxxxxxxxxxxxxxxxxxxxxx#####################SSSSSSSSSSSSSSS");
//	out.println("datenow = " + datenow);
//	out.println("Util.add0(j,2) = " + Util.add0(j,2));
//	out.println("beginDates = " + beginDates);
//	out.println("begintimes = " + begintimes);
//	out.println("endDates = " + endDates);
//	out.println("endtimes = " + endtimes);
//	out.println("statuss = " + statuss);

String temp=getHourOccupied(datenow, Util.add0(j,2), beginDates, begintimes, endDates, endtimes, statuss,statuss);
//		out.println("日使用 ：temp =  " + temp);
for (int h=0 ;h<ids.size();h++) {
String beginDate = beginDates.get(h);
String endDate = endDates.get(h);
String begintime = begintimes.get(h);
String endtime = endtimes.get(h);

String emp_id = emp_ids.get(h);
String status = statuss.get(h);
//				String caller = (String)callers.get(h);
//				String contacter = (String)contacters.get(h);

//				String cancel = (String)cancels.get(h);
//				if(cancel.equals("1"))continue;

String tempBeginDateTime = beginDate+" "+begintime;
String tempEndDateTime = endDate+" "+endtime;

if((tempTime+":59").compareTo(tempBeginDateTime)>=0&& (tempTime+":00").compareTo(tempEndDateTime)<0){
if(tdTitle.equals("")){
tdTitle = mrr.getITResourceInfo(emp_id,beginDate,endDate,begintime,endtime);
}else{
tdTitle +="\n"+"----------------------------------------------------------\n"+
mrr.getITResourceInfo(emp_id,beginDate,endDate,begintime,endtime);
}
}
}
if("2".equals(temp)){
bgcolor="red";
}else if("3".equals(temp)){
bgcolor="green";
}

%>
<td id="<%=tmproomid %>" target="<%=j %>" onmousedown='createMeetingAction.startDrag(event);' bgcolor="<%=bgcolor%>" <%if(!"".equals(tdTitle)) {%> title="<%=tdTitle%>"<%}%>>&nbsp;</td>
<%}%>
</tr>
<%  }%>
</table>
</td>
</tr>
</table>
<%}
%>
<script language=vbs>
sub onShowResourceID()
	id = window.showModalDialog("/systeminfo/BrowserMafin.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	frmmain.resourceid.value=id(0)
	document.frmmain.submit()
	end if
	end if
end sub
</script>
<script language=javascript>
//jQuery(document).ready(function(){
	//	jQuery("body").bind("mousemove", function(event){createMeetingAction.moving(event)});
	//	jQuery("body").bind("mouseup", function(event){createMeetingAction.stopDrag(event)});
//})
var enable = true;
function CreateMeetingAction()
{
	this.roomid;
	this.active;
	this.startTime;
	this.endTime;
}
CreateMeetingAction.prototype.startDrag = function(event)
{
	this.roomid = "";
	this.startTime = "";
	this.endTime = "";
	this.active = false;
	//alert(event.button);
	event = jQuery.event.fix(event);
	if(enable && (0 == event.button || 1 == event.button))
	{
		var startElement = event.target;
		this.roomid = startElement.id;
		this.startTime =jQuery(startElement).attr("target");
		this.endTime = jQuery(startElement).attr("target");
		startElement.className = "ui-selecting";
		jQuery(startElement).css("background-color","#FECA40");
		this.active = true;
	}
}
CreateMeetingAction.prototype.moving = function(event)
{
	if(enable && this.active)
	{
		event = jQuery.event.fix(event);
		var movingElement = event.target;
		var pElement = movingElement.parentNode;
		if(pElement.tagName=="TR"&&pElement.className=="selectable")
		{
			var roomid = movingElement.id;
			if(roomid==this.roomid)
			{
				this.roomid = movingElement.id;
				this.endTime = jQuery(movingElement).attr("target");
				movingElement.className = "ui-selecting";
				jQuery(movingElement).css("background-color","#FECA40");
			}
		}
	}
}
CreateMeetingAction.prototype.stopDrag = function(event)
{
	event = jQuery.event.fix(event);
	if(enable && this.active)
	{
		this.createMeeting();
		this.active = false;
	}
}
CreateMeetingAction.prototype.createMeeting = function()
{
	var url = "/systeminfo/BrowserMain.jsp?url=/meeting/data/AddMeeting_left.jsp?";
var detachablee = <%=detachable%>;
if(detachablee==1){
url +="subCompanyId=<%=subid%>&";
}
	url +="roomid="+this.roomid;
	var currentdate = document.frmmain.currentdate.value;
	url +="&startdate="+currentdate;
	url +="&enddate="+currentdate;
	var tempStartTime = this.startTime;
	var tempEndTime = this.endTime;
	if(parseInt(tempStartTime)>parseInt(tempEndTime))
	{
		var temp = this.startTime;
		this.startTime = this.endTime;
		this.endTime = temp;
	}
	if(this.startTime.length==1)
	{
		this.startTime = "0"+this.startTime;
	}
	this.startTime += ":00";
	if(this.endTime.length==1)
	{
		this.endTime = "0"+this.endTime;
	}
	this.endTime += ":59";
	url +="&starttime="+this.startTime;
	url +="&endtime="+this.endTime;
	var isused = checkMeetingRoom();
	var iscontinue = false;
	if(isused && <%=roomConflictChk%>==1)
	{
		iscontinue=confirm("<%=SystemEnv.getHtmlLabelName(19095,user.getLanguage())%>")
	}
	else
	{
		iscontinue = true;
	}
	if(iscontinue)
	{
		//var rvalue = window.showModalDialog(url,'','dialogWidth:650px;dialogHeight:500px;');
		//window.location.reload();
		var dialog=new Dialog();
		dialog.URL=url;
		dialog.Height=600;
		dialog.Width=800;
		dialog.CancelEvent=function(){
			window.location.reload();
		}
		dialog.ShowButtonRow = true;
		dialog.show();
		dialog.okButton.style.display = "none";
		dialog.cancelButton.style.display = "";
		dialog.cancelButton.value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>";
	}
	else
	{
		resetMeetingRoom();
	}
}
var createMeetingAction = new CreateMeetingAction();
function checkMeetingRoom()
{
	var tds = document.getElementsByTagName("TD");
	for(var i=0;i<tds.length;i++)
	{
		var cname = tds[i].className;
		if(cname=="ui-selecting")
		{
			var bc = tds[i].bgColor;
			if(bc !=""&&bc != "#f5f5f5")
			{
				return "1";
			}
		}
	}
}
function resetMeetingRoom()
{
	var tds = document.getElementsByTagName("TD");
	for(var i=0;i<tds.length;i++)
	{
		var cname = tds[i].className;
		if(cname=="ui-selecting")
		{
			tds[i].className = "";
			jQuery(tds[i]).css("background-color","");
		}
	}
}
function getSubdate() {
	document.frmmain.movedate.value = "-1" ;
	document.frmmain.submit() ;
}
function getSupdate() {
	document.frmmain.movedate.value = "1" ;
	document.frmmain.submit() ;
}
function ShowYear() {
	document.frmmain.bywhat.value = "1" ;
	document.frmmain.currentdate.value = "" ;
	document.frmmain.submit() ;
}
function ShowMONTH() {
	document.frmmain.bywhat.value = "2" ;
	document.frmmain.currentdate.value = "" ;
	document.frmmain.submit() ;
}
function ShowWeek() {
	document.frmmain.bywhat.value = "3" ;
	document.frmmain.currentdate.value = "" ;
	document.frmmain.submit() ;
}
function ShowDay() {
	document.frmmain.bywhat.value = "4" ;
	document.frmmain.currentdate.value = "" ;
	document.frmmain.submit() ;
}
function ajaxinit(){
var ajax=false;
try {
ajax = new ActiveXObject("Msxml2.XMLHTTP");
} catch (e) {
try {
ajax = new ActiveXObject("Microsoft.XMLHTTP");
} catch (E) {
ajax = false;
}
}
if (!ajax && typeof XMLHttpRequest!='undefined') {
ajax = new XMLHttpRequest();
}
return ajax;
}
function doCancel(id){
	var ajaxroom=ajaxinit();
	ajaxroom.open("POST", "/meeting/data/MeetingOperation.jsp", true);
	ajaxroom.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	ajaxroom.send("method=cancelMeeting&meetingId="+id);
	ajaxroom.onreadystatechange = function() {
		if (ajaxroom.readyState == 4 && ajaxroom.status == 200) {
			document.frmmain.submit() ;
		}
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>