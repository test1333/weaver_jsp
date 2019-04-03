<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
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
	String type = Util.null2String(request.getParameter("type"));
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
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				</td>
				<td class="rightSearchSpan" 
					style="text-align: right; width: 400px !important">
					<span
						title="<%=SystemEnv.getHtmlLabelName(23036, user.getLanguage())%>"  class="cornerMenu middle"></span>
				</td>
			</tr>
		</table>
	<% 
		if("1".equals(type)){
			out.print("<font  size=\"4\" face=\"Arial\">该资产不允许借用</font>");
		}else if("2".equals(type)){
			out.print("<font  size=\"4\" face=\"Arial\">该资产不允许归还</font>");
		}else if("3".equals(type)){
			out.print("<font  size=\"4\" face=\"Arial\">该资产不允许领用</font>");
		}else if("4".equals(type)){
			out.print("<font  size=\"4\" face=\"Arial\">该资产不允许退还</font>");
		}else if("7".equals(type)){
			out.print("<font  size=\"4\" face=\"Arial\">该资产不允许维修</font>");
		}else if("8".equals(type)){
			out.print("<font  size=\"4\" face=\"Arial\">该资产不允许归还客户");
		}
	%>


	<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include> 
</FORM> 
</BODY>
</HTML>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript">
        
		var diag_vote;
	      function closeDialog(){
	    diag_vote.close();
      }

          function closeDlgARfsh(){
	   _table.reLoad();
	   diag_vote.close();
       }

		  function onBtnSearchClick() {
			report.submit();
		}

	</script>