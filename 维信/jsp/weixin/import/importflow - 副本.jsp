
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
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
	<script type="text/javascript">	
				
				
		function onBtnSearchClick() {
			report.submit();
		}
					
	</script>
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
boolean isShow = false;

int userid = user.getUID();

String multiIds = Util.null2String(request.getParameter("multiIds"));

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

	RCMenu += "{刷新,javascript:refersh(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导入流程,javascript:daoru(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=/weixin/import/importflow.jsp method=post>
		<input type="hidden" name="multiIds" value="-1">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>

			</tr>
		</table>
			<%
		
			
	%>

<wea:layout type="2col">
<wea:group context="导入流程" attributes="test">

<wea:item>&nbsp;&nbsp;</wea:item><wea:item>&nbsp;&nbsp;</wea:item><wea:item>&nbsp;&nbsp;</wea:item>
		<wea:item>
		<table width="30%">
			<tr>
				<td><input name="hi1" type="button" value="导入" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:100px;height:30px;font-size:15px;" onClick="daoru()"></td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!--<td><input name="hi" type="button" value="刷新" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:80px;height:30px;font-size:15px;" onClick="onBtnSearchClick1()"></td>-->
			</tr>
		</table>
			<script type="text/javascript">	
				
				function onCheckup(){
					if(window.confirm('是否发送考勤异常邮件？')){
						document.report.multiIds.value = "1";
						document.report.submit();
				    }
				}
								
				function onBtnSearchClick1() {
					report.submit();
				}
					
			</script>
		
			 </wea:item>
		


</wea:group>
</wea:layout>	
			
	</FORM>
<Script language=javascript>
	function refersh() {
  		window.location.reload();
  	}
	function daoru() {
		var title = "导入";
		var url = "/systeminfo/BrowserMain.jsp?url=/weixin/import/ExcelIn.jsp";
		// var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,,";

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 500;
		diag_vote.Height = 300;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		

	}
</script>
</BODY>
</HTML>
	

