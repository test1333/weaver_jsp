<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
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
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 3000px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		.table-head{padding-right:17px}
         .table-body{width:100%;overflow-y:auto;overflow-x: hidden}
		</style>
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action=# method=post>
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

				

				<wea:item>Alarm ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value=""/>
				</wea:item>
				<wea:item>Alarm ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value=""/>
				</wea:item>
                
				<wea:item>Alarm ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value=""/>
				</wea:item>
                
				<wea:item>Alarm ID</wea:item>
				<wea:item>
				 <input name="alarmid" id="alarmid" class="InputStyle" type="text" value=""/>
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
		 
		String backfields = "";
														
		String fromSql  = " ";
		String sqlWhere = "";
		String orderby = " ";
		String tableString = "";
	
		%>
	<div style="width:3000px; ">	
	<div class="table-head">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				            <col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				 </colgroup>
                <tbody>
					 <tr>
					    
	                    <td class="fname" rowspan="2" align="center">灯号</td>
						<td class="fname" rowspan="2" align="center">SOP ID</td>
						<td class="fname" rowspan="2" align="center">SOP名称</td>
						<td class="fname" rowspan="2" align="center">SOP负责人</td>
						<td class="fname" rowspan="2" align="center">SOP负责人工厂</td>
						<td class="fname" rowspan="2" align="center">业务流程</td>
						<td class="fname" rowspan="2" align="center">流程负责人</td>
						<td class="fname" rowspan="2" align="center">流程负责人工厂</td>
						<td class="fname" rowspan="2" align="center">子流程</td>
						<td class="fname" rowspan="2" align="center">子流程负责人</td>
						<td class="fname" rowspan="2" align="center">子流程负责人工厂</td>
						<td class="fname" rowspan="2" align="center">CMO组别</td>
						<td class="fname" rowspan="2" align="center">CMO组别负责人</td>
						<td class="fname" colspan="3" align="center">(40%)草案完成</td>
						<td class="fname" colspan="3" align="center">(50%)与各部门讨论完成</td>
						<td class="fname" colspan="3" align="center">(70%)向股东报告</td>
						<td class="fname" colspan="3" align="center">(90%)完成完整SOP</td>
						<td class="fname" colspan="3" align="center">(100%)书面呈准</td>						
                       	
                 </tr>
				 <tr>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
				</tr>
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				            <col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				 </colgroup>
                <tbody>
					 
					<% 
					  for(int i=1;i<=100;i++){

					  
					%>
                    <tr>
					    
	                    <td class="fvalue" bgcolor="red">&nbsp;&nbsp;</td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
						<td class="fvalue">&nbsp;&nbsp;Action ID<%=i%></td>
                       	
                 </tr>
				 <%}%>
                </tbody>
            </table>
			 </td>
        </tr>
    </tbody>
</table>
           
</div>
</div>	
	<script type="text/javascript">
	window.onload=function(){
		var clienthei= document.body.clientHeight;
		var height1=Number(clienthei)-100;
		height1=height1+'px';
		document.getElementById('div22').style.height=height1;
	}
	  
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	   

	</script>
</BODY>
</HTML>