<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/ksy/MeetingReport.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
                <wea:item>查询日期</wea:item>
		<wea:item>
			<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
              	<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
              	<INPUT type="hidden" name="beginDate" value="<%=beginDate%>">  
            &nbsp;-&nbsp;
            <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
            	<SPAN id=endDateSpan><%=endDate%></SPAN> 
            	<INPUT type="hidden" name="endDate" value="<%=endDate%>">  
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
	
		
<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
		<wea:item attributes="{'isTableList':'true'}">
		    <wea:layout type="table" attributes="{'cols':'3','cws':'200px,200px,200px'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				

				<wea:item type="thead">会议类型</wea:item>
				<wea:item type="thead">场次</wea:item>
			    <wea:item type="thead">参会人数</wea:item>
				
				
		
		<% 
		      String sqlWhere = "";
			  if(!"".equals(beginDate)){
				sqlWhere +=  " and begindate >='"+beginDate+"'";
			   }
			  if(!"".equals(endDate)){
				sqlWhere +=  " and begindate <='"+endDate+"'";
			  }
		      String sql="select count(1) as count from meeting where cancel is null and meetingtype=1 " + sqlWhere;
			  RecordSet.executeSql(sql);
			  String bigcount="";
			  if(RecordSet.next()){
				  bigcount = Util.null2String(RecordSet.getString("count"));
			  }
			  sql="select count(1) as count from meeting where cancel is null and meetingtype=2 " + sqlWhere;
			  RecordSet.executeSql(sql);
			  String smallcount="";
			  if(RecordSet.next()){
				  smallcount = Util.null2String(RecordSet.getString("count"));
			  }
			  sql="select hrmmembers from meeting where cancel is null and meetingtype=1 " + sqlWhere;
			  RecordSet.executeSql(sql);
			  int htmcount = 0;
			  while(RecordSet.next()){
				  String big= Util.null2String(RecordSet.getString("hrmmembers"));
				  htmcount = htmcount+big.split(",").length;
			  }
			  sql="select hrmmembers from meeting where cancel is null and meetingtype=2 " + sqlWhere;
			  RecordSet.executeSql(sql);
			  int htmcount1 = 0;
			  while(RecordSet.next()){
				  String big1= Util.null2String(RecordSet.getString("hrmmembers"));
				  htmcount1 = htmcount1+big1.split(",").length;
			  }

			  %>
			   <wea:item>大型会议</wea:item>			
			   <wea:item><%=bigcount%></wea:item>
			   <wea:item><%=htmcount%></wea:item>
			   <wea:item>小型会议</wea:item>			
			   <wea:item><%=smallcount%></wea:item>
			   <wea:item><%=htmcount1%></wea:item>

			   
				
				
			
		   </wea:group>
			</wea:layout>
		</wea:item>

	</div>
</wea:layout>

	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}

	</script>
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>