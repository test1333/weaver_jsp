<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
boolean isShow = false;
int userid = user.getUID();
String multiIds = Util.null2String(request.getParameter("multiIds"));
String year = Util.null2String(request.getParameter("year"));
String month = Util.null2String(request.getParameter("month"));
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
Calendar cal = Calendar.getInstance();
cal.setTime(new Date());
String nowDate = df.format(new Date());						
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
	RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report method=post> <!--/task/point/sysnDevelopPerPoint.jsp-->
		<input type="hidden" name="multiIds" value="-1">
	<%
		if("1".equals(multiIds)){
			DevelopPerPoint aa = new DevelopPerPoint();
			aa.perPointGenerate(year,month);
			out.println("<font size=\"5px\" color=\"red\">执行完成，获取成功!</font>");
		}	
	%>

<wea:layout type="2col">
<wea:group context="计算开发绩效" attributes="test">
		<wea:item>年份</wea:item>
		<wea:item>
			<select class="InputStyle" style="width:80px;" size="1" name="year" id="year" > 
			<option value="" <%if("".equals(year)){%> selected<%} %>>
				<%=""%></option>
			<option value="2019" <%if("2019".equals(year)){%> selected<%} %>>
				<%="2019"%></option>
			<option value="2020" <%if("2020".equals(year)){%> selected<%} %>>
				<%="2020"%></option>
			<option value="2021" <%if("2021".equals(year)){%> selected<%} %>>
				<%="2021"%></option>
			<option value="2022" <%if("2022".equals(year)){%> selected<%} %>>
				<%="2022"%></option>
			<option value="2023" <%if("2023".equals(year)){%> selected<%} %>>
				<%="2023"%></option>
			<option value="2024" <%if("2024".equals(year)){%> selected<%} %>>
				<%="2024"%></option>
		    <option value="2025" <%if("2025".equals(year)){%> selected<%} %>>
				<%="2025"%></option>
			<option value="2026" <%if("2026".equals(year)){%> selected<%} %>>
				<%="2026"%></option>
		</select>
		</wea:item>

		<wea:item>月份</wea:item>
		<wea:item>
			<select class="InputStyle" style="width:80px;" size="1" name="month" id="month" > 
			<option value="" <%if("".equals(month)){%> selected<%} %>>
				<%=""%></option>
			<option value="1" <%if("1".equals(month)){%> selected<%} %>>
				<%="1"%></option>
			<option value="2" <%if("2".equals(month)){%> selected<%} %>>
				<%="2"%></option>
			<option value="3" <%if("3".equals(month)){%> selected<%} %>>
				<%="3"%></option>
			<option value="4" <%if("4".equals(month)){%> selected<%} %>>
				<%="4"%></option>
			<option value="5" <%if("5".equals(month)){%> selected<%} %>>
				<%="5"%></option>
			<option value="6" <%if("6".equals(month)){%> selected<%} %>>
				<%="6"%></option>
		    <option value="7" <%if("7".equals(month)){%> selected<%} %>>
				<%="7"%></option>
			<option value="8" <%if("8".equals(month)){%> selected<%} %>>
				<%="8"%></option>
			<option value="9" <%if("9".equals(month)){%> selected<%} %>>
				<%="9"%></option>
			<option value="10" <%if("10".equals(month)){%> selected<%} %>>
				<%="10"%></option>
			<option value="11" <%if("11".equals(month)){%> selected<%} %>>
				<%="11"%></option>
			<option value="12" <%if("12".equals(month)){%> selected<%} %>>
				<%="12"%></option>
		</select>
		</wea:item>

		<wea:item>计算开发绩效</wea:item>
		<wea:item>
			<input name="hi2" type="button" value="计算开发绩效" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 200px;width:200px;height:30px;font-size:15px;" onClick="onCheckup()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</wea:item>
</wea:group>
</wea:layout>		
</FORM>
</BODY>
</HTML>
<script type="text/javascript">	
	function onCheckup(){
		var year = jQuery("#year").val();
		var month = jQuery("#month").val();
		if(year!=""&&month!=""){
			if(window.confirm('是否要重新计算开发绩效？')){
				document.report.multiIds.value = "1";
				document.report.submit();
			}
		}else{
			alert("年份月份必填");
		}
	}							
	function onBtnSearchClick1() {
		report.submit();
	}		
</script>	

