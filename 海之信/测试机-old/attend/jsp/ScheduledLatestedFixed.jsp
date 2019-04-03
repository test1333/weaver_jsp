<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%
//if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
// response.sendRedirect("/notice/noright.jsp");
//return;
//}
String deptid = Util.null2String(request.getParameter("deptid"));
String subcomid = Util.null2String(request.getParameter("subcomid"));
String sql="";
String id = "";
sql=" select modedatacreater,modedatacreatedate,modedatacreatetime,(select lastname from HrmResource where id =EmployeeName ) "
+" as empName,AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,EffectiveStartDate,EffectiveEndDate,EmployeeName  "
+" from uf_Scheduling_table where isActive = 0 ";
if(!"".equals(deptid)){
sql = sql + " and department  = "+deptid+" ";
}
if(!"".equals(subcomid)){
sql = sql + " and subcompany = "+subcomid+" ";
}
%>
<%
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
	<style type="text/css">
	<!--
	/* Terence Ordona, portal[AT]imaputz[DOT]com */
	/* http://creativecommons.org/licenses/by-sa/2.0/ */
	/* begin some basic styling here */
	body {
	background: #FFF;
	color: #000;
	font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif;
	margin: 10px;
	height: 600px;
	padding: 0
	}
	table, td, a {
	color: #000;
	font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
	}
	h1 {
	font: normal normal 18px Verdana, Geneva, Arial, Helvetica, sans-serif;
	margin: 0 0 5px 0
	}
	h2 {
	font: normal normal 16px Verdana, Geneva, Arial, Helvetica, sans-serif;
	margin: 0 0 5px 0
	}
	h3 {
	font: normal normal 13px Verdana, Geneva, Arial, Helvetica, sans-serif;
	color: #008000;
	margin: 0 0 15px 0
	}
	/* end basic styling */
	/* define height and width of scrollable area. Add 16px to width for scrollbar */
	div.tableContainer {
	clear: both;
	border: 1px solid #CCC;
	height: 580px;
	overflow: auto;
	width: 1090px
	}
	/* Reset overflow value to hidden for all non-IE browsers. */
	html>body div.tableContainer {
	overflow: hidden;
	width: 1090px
	}
	/* define width of table. IE browsers only */
	div.tableContainer table {
	float: left;
	width: 1084px
	}
	/* define width of table. Add 16px to width for scrollbar. */
	/* All other non-IE browsers. */
	html>body div.tableContainer table {
	width: 1090px
	}
	/* set table header to a fixed position. WinIE 6.x only */
	/* In WinIE 6.x, any element with a position property set to relative and is a child of */
	/* an element that has an overflow property set, the relative value translates into fixed. */
	/* Ex: parent element DIV with a class of tableContainer has an overflow property set to auto */
	thead.fixedHeader tr {
	position: relative
	}
	/* set THEAD element to have block level attributes. All other non-IE browsers */
	/* this enables overflow to work on TBODY element. All other non-IE, non-Mozilla browsers */
	html>body thead.fixedHeader tr {
	display: block
	}
	/* make the TH elements pretty */
	thead.fixedHeader th {
	color: #FFF;
	background: #0070C1;
	border-left: 1px solid #F2F2F2;
	border-right: 1px solid #F2F2F2;
	border-top: 1px solid #F2F2F2;
	font-weight: normal;
	padding: 4px 3px;
	text-align: center
	}
	/* make the A elements pretty. makes for nice clickable headers */
	thead.fixedHeader a, thead.fixedHeader a:link, thead.fixedHeader a:visited {
	color: #FFF;
	display: block;
	text-decoration: none;
	height:20px;
	width: 100%
	}
	/* make the A elements pretty. makes for nice clickable headers */
	/* WARNING: swapping the background on hover may cause problems in WinIE 6.x */
	thead.fixedHeader a:hover {
	color: #FFF;
	display: block;
	text-decoration: underline;
	width: 100%
	}
	/* define the table content to be scrollable */
	/* set TBODY element to have block level attributes. All other non-IE browsers */
	/* this enables overflow to work on TBODY element. All other non-IE, non-Mozilla browsers */
	/* induced side effect is that child TDs no longer accept width: auto */
	html>body tbody.scrollContent {
	display: block;
	height: 570px;
	overflow: auto;
	width: 100%
	}
	/* make TD elements pretty. Provide alternating classes for striping the table */
	/* http://www.alistapart.com/articles/zebratables/ */
	tbody.scrollContent td, tbody.scrollContent tr.normalRow td {
	background: #FFF;
	border-bottom: none;
	border-left: none;
	border-right: 1px solid #CCC;
	border-top: 1px solid #DDD;
	text-align: center;
	padding: 4px 6px 6px 8px
	}
	tbody.scrollContent tr.alternateRow td {
	background: #EEE;
	border-bottom: none;
	border-left: none;
	border-right: 1px solid #CCC;
	border-top: 1px solid #DDD;
	padding: 4px 6px 6px 8px
	}
	/* define width of TH elements: 1st, 2nd, and 3rd respectively. */
	/* Add 16px to last TH for scrollbar padding. All other non-IE browsers. */
	/* http://www.w3.org/TR/REC-CSS2/selector.html#adjacent-selectors */
	html>body thead.fixedHeader th {
	width: 200px
	}
	html>body thead.fixedHeader th + th {
	width: 240px
	}
	html>body thead.fixedHeader th + th + th {
	width: 316px
	}
	/* define width of TD elements: 1st, 2nd, and 3rd respectively. */
	/* All other non-IE browsers. */
	/* http://www.w3.org/TR/REC-CSS2/selector.html#adjacent-selectors */
	html>body tbody.scrollContent td {
	width: 200px
	}
	html>body tbody.scrollContent td + td {
	width: 240px
	}
	html>body tbody.scrollContent td + td + td {
	width: 300px
	}
	-->
	</style>
</HEAD>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
	//RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
	//RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<!-- <form id=frmmain name=frmmain method=post action=""> -->
		<div id="tableContainer" class="tableContainer">
			<table border="0" cellpadding="0" cellspacing="0"  height="750px" class="scrollTable">
				<thead class="fixedHeader">
				    <tr>
				    	<td style="color:white;background: #0070C1;border-left: 1px solid #F2F2F2;border-right: 1px solid #F2F2F2;border-top: 1px solid #F2F2F2;font-weight: normal;padding: 4px 3px;text-align: center;width:100%">最新排班情况</td>
				    	<td style="background: #0070C1;border-left: 1px solid #F2F2F2;border-right: 1px solid #F2F2F2;border-top: 1px solid #F2F2F2;font-weight: normal;padding: 4px 3px;text-align: center;width:100%"></td>
				    </tr>
					<tr>
						<th><a href="#">姓名</a></th>
						<th><a href="#">上午开始时间</a></th>
						<th><a href="#">上午结束时间</a></th>
						<th><a href="#">下午开始时间</a></th>
						<th><a href="#">下午结束时间</a></th>
						<th><a href="#">有效开始日期</a></th>
						<th><a href="#">有效结束日期</a></th>
						<th><a href="#">创建人</a></th>
						<th><a href="#">创建时间</a></th>
					</tr>
				</thead>
				<tbody class="scrollContent">
					<%
					RecordSet.executeSql(sql);
					while(RecordSet.next()){
					String creater = Util.null2String(RecordSet.getString("modedatacreater"));
					String createdate = Util.null2String(RecordSet.getString("modedatacreatedate"));
					String createtime = Util.null2String(RecordSet.getString("modedatacreatetime"));
					String empName = Util.null2String(RecordSet.getString("EmpName"));
					String amBeginTime = Util.null2String(RecordSet.getString("AmBeginTime"));
					String amEndTime = Util.null2String(RecordSet.getString("AmEndTime"));
					String pmBeginTime = Util.null2String(RecordSet.getString("PmBeginTime"));
					String pmEndTime = Util.null2String(RecordSet.getString("PmEndTime"));
					String startDate = Util.null2String(RecordSet.getString("EffectiveStartDate"));
					String endDate = Util.null2String(RecordSet.getString("EffectiveEndDate"));
					String employeeName = Util.null2String(RecordSet.getString("EmployeeName"));
					if("".equals(endDate)) endDate = "9999-12-31";
					%><tr>
						<td><a href=javascript:this.openFullWindowForXtable('/seahonor/attend/jsp/ScheduledPersonal.jsp?id=<%=employeeName%>')><%=empName%></a></td>
					<td><%=amBeginTime%></td>
					<td><%=amEndTime%></td>
					<td><%=pmBeginTime%></td>
					<td><%=pmEndTime%></td>
					<td><%=startDate%></td>
					<td><%=endDate%></td>
					<td><%=ResourceComInfo.getResourcename(creater)%></td>
					<td><%=createdate%>&nbsp<%=createtime%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
<!-- </form> -->
<script type="text/javascript">
<!--
function removeClassName (elem, className) {
elem.className = elem.className.replace(className, "").trim();
}
function addCSSClass (elem, className) {
removeClassName (elem, className);
elem.className = (elem.className + " " + className).trim();
}
String.prototype.trim = function() {
return this.replace( /^\s+|\s+$/, "" );
}
function stripedTable() {
if (document.getElementById && document.getElementsByTagName) {
var allTables = document.getElementsByTagName('table');
if (!allTables) { return; }
for (var i = 0; i < allTables.length; i++) {
if (allTables[i].className.match(/[\w\s ]*scrollTable[\w\s ]*/)) {
var trs = allTables[i].getElementsByTagName("tr");
for (var j = 0; j < trs.length; j++) {
removeClassName(trs[j], 'alternateRow');
addCSSClass(trs[j], 'normalRow');
}
for (var k = 0; k < trs.length; k += 2) {
removeClassName(trs[k], 'normalRow');
addCSSClass(trs[k], 'alternateRow');
}
}
}
}
}
window.onload = function() { stripedTable(); }
-->
</script>
</BODY>
</HTML>