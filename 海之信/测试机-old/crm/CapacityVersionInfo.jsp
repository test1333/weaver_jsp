
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
function openNewInfo(id) {
//	openFullWindowForXtable("CustomVersionInfoDetail.jsp?type=custom&customID="+id);
//	alert(123);
	var title = "";
	var url = "/seahonor/crm/CustomVersionInfoDetail.jsp?type=custom&customID="+id;
	var diag_vote = new window.top.Dialog();
	diag_vote.currentWindow = window;
	diag_vote.Width = 1200;		
	diag_vote.Height = 700;
	diag_vote.Modal = true;		
	diag_vote.Title = title;
	diag_vote.URL = url;
	diag_vote.isIframe=false;
	diag_vote.show();
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
String tmc_pageId = "tmcCusDif033";
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				
			</tr>
		</table>

	</FORM>

<%
								
	String backfields = " id,name,remark,Version,period,uploader,uploadDate+' '+uploadTime as createTime ,(select customName from uf_custom where id=a.custom) as customName"; 
	String fromSql  = " from uf_CustomCapacity a ";
	String sqlWhere = " where superid  = '"+ customID+"' and version <>(select Max(version) from uf_CustomCapacity where superid='"+customID+"')";
	String orderby = " version desc " ;
	String tableString = "";


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"5%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"javascript:viewInfo();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"详细\" target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
 	       				"</operates>";

tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"10%\"  text=\"公司名称\" column=\"customName\" orderkey=\"customName\"/>"+
		"<col width=\"15%\"  text=\"资质名称\" column=\"name\" orderkey=\"name\"/>"+
		 "	<col width=\"10%\" labelid=\"567\" text=\"版本\" column=\"Version\" orderkey=\"Version\"   />"+
		"<col width=\"30%\"  text=\"说明\" column=\"remark\" orderkey=\"remark\"/>"+
	  "				<col width=\"10%\"  text=\"有效期\" column=\"period\" orderkey=\"period\" />"+
	  "				<col width=\"10%\"  text=\"上传人\" column=\"uploader\" orderkey=\"uploader\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  />"+
	  "				<col width=\"10%\"  text=\"上传时间\" column=\"createTime\" orderkey=\"createTime\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
	function viewInfo(id) {
         var title = "";
	//	var url = "/systeminfo/BrowserMain.jsp?url=/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>";
		
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=customzz1,"+id;
		
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 700;
		diag_vote.Height = 550;
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
