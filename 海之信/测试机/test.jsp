
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<script type="text/javascript">
function doAddWorkPlan(id) {
	openFullWindowForXtable("/workplan/data/WorkPlan.jsp?resourceid="+id+"&add=1")	
}
</script>
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

String customID = Util.null2String(request.getParameter("customID"));

if("".equals(customID)){
	customID = "-1";
}
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
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<%  
		/*
		String smac = "";  String sip = request.getHeader("x-forwarded-for");     
		if(sip == null || sip.length() == 0 || "unknown".equalsIgnoreCase(sip)) {        
			sip = request.getHeader("Proxy-Client-IP");    
		}     
		if(sip == null || sip.length() == 0 || "unknown".equalsIgnoreCase(sip)) {        
			sip = request.getHeader("WL-Proxy-Client-IP");    
		}     
		if(sip == null || sip.length() == 0 || "unknown".equalsIgnoreCase(sip)) {        
			sip = request.getRemoteAddr();    
		}    
		test.UdpGetClientMacAddr umac = new test.UdpGetClientMacAddr(sip); 
		smac = umac.GetRemoteMacAddr(); 
		*/
		String sip=""; String smac="test";  
		sip = request.getHeader("x-forwarded-for");  
		if(sip == null ||sip.length() == 0 || "unknown".equalsIgnoreCase(sip)){ 
			sip = request.getHeader("proxy-Client-IP"); 
		}  
		if (sip == null || sip.length() == 0 || "unknown".equalsIgnoreCase(sip)){     
			sip = request.getHeader("WL-Proxy-Client-IP"); 
		}    
		if (sip == null ||sip.length() == 0 || "unknown".equalsIgnoreCase(sip)){     
			sip = request.getRemoteAddr(); 
		}      
		//±¾»ú¹ýÂËµô      
		if(!"127.0.0.1".equals(sip)){
			try {        
				Process  process = Runtime.getRuntime().exec("nbtstat -a " + sip);
				java.io.InputStreamReader ir = new java.io.InputStreamReader(process.getInputStream());     
				java.io.LineNumberReader input = new java.io.LineNumberReader(ir); 
				String line;     
				while ((line = input.readLine()) != null)      { 
					if (line.indexOf("MAC Address") > 0) {            
					smac = line.substring(line.indexOf("-") - 2);     
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
		
%>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<input  name="userMacAddr" size="20" style="width:150px" readonly="yes" value=<%=smac%>> 
			</tr>
		</table>

	</FORM>

	<script type="text/javascript">
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
	</script>
</BODY>
</HTML>
