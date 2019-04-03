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
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	 String alarmid = (String)session.getAttribute("alarmid");
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String zuzhidanwei="";
	String duration="";
	String kfcode="";
	String namedesc="";
	String approvestatus="";
	
	//判断操作
	 
	 
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
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			
		
			
		</FORM>
		<div >
				<wea:layout type="2col">
				<wea:group context="更新状态">

				

				<wea:item>RequestId</wea:item>
				<wea:item>
				 <input name="requestid" id="requestid" class="InputStyle" type="text" value=""/>
				</wea:item>
               

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="同步状态" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
		<div>
	<script type="text/javascript">
    function onBtnSearchClick() {
		var rqid  = document.getElementById('requestid').value;
	 var xhr = null;
     if (window.ActiveXObject) {//IE浏览器
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
     } else if (window.XMLHttpRequest) {
	xhr = new XMLHttpRequest();
     }
     if (null != xhr) {

	xhr.open("GET","/ghy/service/sendsapstatus.jsp?requestid="+rqid, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
	    var text = xhr.responseText;  
		 text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
	    		alert(text);			
	    }
	  }
	}
	xhr.send(null);
     }
}
	   
 
	</script>
</BODY>
</HTML>