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
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String fmid = Util.null2String(request.getParameter("fmid"));
	String fmname = "";
	String needfav ="1";
	String needhelp ="";
	
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
		<FORM id=report name=report action="/hhgd/HQ/DECODE/update-history-data.jsp" method=post>
			
		
			
		
		<div >
				<wea:layout type="2col">
				<wea:group context="同步ISO文档">				
				

				<wea:item>ISO目录编码</wea:item>
				<wea:item>
				 <input name="isoseccode" id="isoseccode" class="InputStyle" type="text" value=""/>
				</wea:item>
				 <wea:item>OA目录编码</wea:item>
				<wea:item>
				 <input name="oaseccode" id="oaseccode" class="InputStyle" type="text" value=""/>

				</wea:item>              

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="同步文档" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
		<div>
		</FORM>
	<script type="text/javascript">
    function onBtnSearchClick() {
		var oaseccode  = document.getElementById('oaseccode').value;
		var isoseccode  = document.getElementById('isoseccode').value;
		if(oaseccode == ""||isoseccode == ""){
			alert("信息填写不完整，请填写完整后，再处理");
			return;
		}
		if(confirm("是否确定要同步")){
		}else{
			return false;
		}
	 var xhr = null;
     if (window.ActiveXObject) {//IE浏览器
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
     } else if (window.XMLHttpRequest) {
	xhr = new XMLHttpRequest();
     }
     if (null != xhr) {

	xhr.open("GET","/appdevjsp/HQ/DECODE/do-update-history.jsp?fmid="+fmid+"&oldfieldname="+oldfieldname+"&oldfieldtype="+oldfieldtype+"&newfieldname="+newfieldname+"&newfieldtype="+newfieldtype, false);
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
	   function refersh() {
  			window.location.reload();
  		}
 
	</script>
</BODY>
</HTML>